-- This script creates a dataset from Retrosheet events files.
-- This dataset will contain base/out state run expectancy and run value
-- In my setup I have PostgreSQL database called 'baseball'
-- In there there is a schema called 'retrosheet' with following tables:
--    - events
--    - game logs
-- I don't know if there is a way to do the same without intermediate tables

-- This is a basis query that prepares the original dataset
-- I create a new schema called 'run_expectancy' to hold all my calculations separately
create table run_expectancy.source_1912_2024 as
with basis_logs as (
  select *,
         to_date(substring(game_id from 4 for 8), 'YYYYMMDD') as game_date,
         cast(extract(year from to_date(substring(game_id from 4 for 8), 'YYYYMMDD')) as text) as season
  from retrosheet.events 
)
select *
from basis_logs
order by game_id, inn_ct, cast(bat_home_id as int), outs_ct, cast(event_id as int);

-- Add new columns to calculate:
--  runs_before: total runs scored by away and home team
--  half_inning: is an identifier of the half-inning
--  runs_scored: is the runs scored during half-inning
alter table run_expectancy.source_1912_2024
add column runs_before int,
add column half_inning text,
add column runs_scored int;

-- The actual calculation of the above
update run_expectancy.source_1912_2024
set runs_before = away_score_ct + home_score_ct,
    half_inning = game_id || ' ' || cast(inn_ct as int) || ' ' || bat_home_id,
    runs_scored = (
        (cast(bat_dest_id as int) > 3)::int +
        (cast(run1_dest_id as int) > 3)::int +
        (cast(run2_dest_id as int) > 3)::int +
        (cast(run3_dest_id as int) > 3)::int
    );

-- The following calculates the fields in three steps:
-- First:
--        outs_inning is the number of outs for each half-inning
--        runs_inning is the total runs scored in each half-inning
-- Second:
--        runs_start is the score at the beginning of the half-inning
-- Third:
--        max_runs is the maximum total score in a half-inning, 
--                 which is the sum of the initial total runs and the runs scored.
create table run_expectancy.half_innings_1912_2024_first as
select half_inning,
       sum(event_outs_ct) as outs_inning,
       sum(runs_scored) as runs_inning
from run_expectancy.source_1912_2024
group by half_inning;

create table run_expectancy.half_innings_1912_2024_second as
select distinct half_inning,
       first_value(runs_before) over (partition by half_inning order by half_inning, inn_ct, bat_home_id, outs_ct, cast(event_id as int)) as runs_start
from run_expectancy.source_1912_2024
group by half_inning, runs_before, inn_ct, bat_home_id, outs_ct, event_id
order by half_inning;

create table run_expectancy.half_innings_1912_2024 as
select f.*,
       s.runs_start,
       f.runs_inning + s.runs_start as max_runs
from run_expectancy.half_innings_1912_2024_first f
inner join run_expectancy.half_innings_1912_2024_second s
on f.half_inning = s.half_inning;

-- Drop tables that are not needed anymore
drop table run_expectancy.half_innings_1912_2024_first;
drop table run_expectancy.half_innings_1912_2024_second;

-- Calculate runs_roi
create table run_expectancy.pre_1912_2024 as
select ts.*,
       hi.outs_inning,
       hi.runs_inning,
       hi.runs_start,
       hi.max_runs,
       hi.max_runs - ts.runs_before as runs_roi
from run_expectancy.source_1912_2024 ts
inner join run_expectancy.half_innings_1912_2024 hi
on ts.half_inning = hi.half_inning;

-- Drop tables that are not needed anymore
drop table run_expectancy.half_innings_1912_2024 cascade;

-- Add and calculate new columns for Base/Out state
alter table run_expectancy.pre_1912_2024
add column bases text,
add column state text,
add column is_runner1 numeric,
add column is_runner2 numeric,
add column is_runner3 numeric,
add column new_outs int,
add column new_bases text,
add column new_state text;

update run_expectancy.pre_1912_2024
set bases = (
    (case when base1_run_id is null then '0' else '1' end) ||
    (case when base2_run_id is null then '0' else '1' end) ||
    (case when base3_run_id is null then '0' else '1' end)
),
    is_runner1 = (run1_dest_id = '1' or bat_dest_id = '1')::int,
    is_runner2 = (run1_dest_id = '2' or run2_dest_id = '2' or bat_dest_id = '2')::int,
    is_runner3 = (run1_dest_id = '3' or run2_dest_id = '3' or run3_dest_id = '3' or bat_dest_id = '3')::int,
    new_outs = outs_ct + event_outs_ct;

update run_expectancy.pre_1912_2024
set state = bases || ' ' || cast(cast(outs_ct as int) as text),
    new_bases = cast(is_runner1 as text) || cast(is_runner2 as text) || cast(is_runner3 as text);

update run_expectancy.pre_1912_2024
set new_state = new_bases || ' ' || cast(new_outs as text);

-- Selecting only half-innings that have reached 3 outs
create table run_expectancy.final_pre_1912_2024 as
with ch as (
    select *
    from run_expectancy.pre_1912_2024
    where state != new_state or runs_scored > 0
)
select *
from ch
where outs_inning = 3;

-- Calculating RV (Run Value)
-- Excluding extra-innings and home team halves
create table run_expectancy.matrix_1912_2024 as
select season,
       "state",
       avg(runs_roi) as mean_run_value
from run_expectancy.final_pre_1912_2024
where inn_ct <= 9.0 and not (inn_ct = 9.0 and bat_home_id = '1')
group by season, "state";

-- Calculating starting and ending RV (Run Value)
create table run_expectancy.full_rv_1912_2024 as
with full_prv_state as (
  select main.*,
         coalesce(matrix.mean_run_value, 0) as rv_start
  from run_expectancy.pre_1912_2024 main
  left join run_expectancy.matrix_1912_2024 matrix on main.season = matrix.season and main.state = matrix.state
)
select main.*,
       coalesce(matrix.mean_run_value, 0) as rv_end,
	   coalesce(matrix.mean_run_value, 0) - main.rv_start + main.runs_scored as run_value
from full_prv_state main
left join run_expectancy.matrix_1912_2024 matrix on main.season = matrix.season and main.new_state = matrix.state;

-- Creating final RE24 matrix per season and Base/Out State
create table run_expectancy.re24 as
with re_matrix_long as (
	SELECT season,
	  case
	    when bases = '000' THEN 1
	    when bases = '100' THEN 2
	    when bases = '010' THEN 3
	    when bases = '001' THEN 4
	    when bases = '110' THEN 5
	    when bases = '101' THEN 6
	    when bases = '011' THEN 7
	    when bases = '111' THEN 8
	   end as bases_state_order,
	   case
	    when bases = '000' THEN '-- -- --'
	    when bases = '100' THEN '1B -- --'
	    when bases = '010' THEN '-- 2B --'
	    when bases = '001' THEN '-- -- 3B'
	    when bases = '110' THEN '1B 2B --'
	    when bases = '101' THEN '1B -- 3B'
	    when bases = '011' THEN '-- 2B 3B'
	    when bases = '111' THEN '1B 2B 3B'
	   end as bases,
	   cast(cast(outs_ct as int) as text) as outs_ct,
	   round(avg(runs_roi),3) as mean_run_value
   FROM run_expectancy.final_pre_1912_2024
   where inn_ct <= 9.0 and not (inn_ct = 9.0 and bat_home_id = '1')
   group by season, bases, cast(cast(outs_ct as int) as text)
	)
select season,
	bases_state_order,
	bases,
	max(case when outs_ct = '0' then mean_run_value else 0 end) as "0 Outs",
	max(case when outs_ct = '1' then mean_run_value else 0 end) as "1 Out",
	max(case when outs_ct = '2' then mean_run_value else 0 end) as "2 Outs"
from re_matrix_long
group by season, bases, bases_state_order
order by season, bases_state_order;

-- Drop tables that are not needed anymore
drop table run_expectancy.pre_1912_2024 cascade;
drop table run_expectancy.final_pre_1912_2024 cascade;
drop table run_expectancy.source_1912_2024 cascade;
