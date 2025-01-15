-- GDP Run Value statistics
create table gdp_article_2017_2024.gdp_rv_by_state as
with basis as (
  select *
  from run_expectancy.full_rv_1912_2024
  where inn_ct <= 9.0 and not (inn_ct = 9.0 and bat_home_id = '1') and cast(season as integer) > 2016
),
gdp as (
  select season as "Season",
         "state" as "Base/Out State",
		 event_cd,
         'GDP' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_tx like '%GDP%'
  group by season, "state", event_cd
),
events as (
  select "Season", "Base/Out State", event_cd, "Event", "N", "Runs to End of Inning", "Average Runs"
  from gdp
),
cleaned as (
  select "Season",
       "Base/Out State" as "Numeric B/O State",
	    event_cd,
       case
	    when "Base/Out State" = '000 0' THEN 1
	    when "Base/Out State" = '100 0' THEN 4
	    when "Base/Out State" = '010 0' THEN 7
	    when "Base/Out State" = '001 0' THEN 10
	    when "Base/Out State" = '110 0' THEN 13
	    when "Base/Out State" = '101 0' THEN 16
	    when "Base/Out State" = '011 0' THEN 19
	    when "Base/Out State" = '111 0' THEN 22
		when "Base/Out State" = '000 1' THEN 2
	    when "Base/Out State" = '100 1' THEN 5
	    when "Base/Out State" = '010 1' THEN 8
	    when "Base/Out State" = '001 1' THEN 11
	    when "Base/Out State" = '110 1' THEN 14
	    when "Base/Out State" = '101 1' THEN 17
	    when "Base/Out State" = '011 1' THEN 20
	    when "Base/Out State" = '111 1' THEN 23
		when "Base/Out State" = '000 2' THEN 3
	    when "Base/Out State" = '100 2' THEN 6
	    when "Base/Out State" = '010 2' THEN 9
	    when "Base/Out State" = '001 2' THEN 12
	    when "Base/Out State" = '110 2' THEN 15
	    when "Base/Out State" = '101 2' THEN 18
	    when "Base/Out State" = '011 2' THEN 21
	    when "Base/Out State" = '111 2' THEN 24
	   end as bases_state_order,
	   case
	    when "Base/Out State" = '000 0' THEN '-- -- -- 0 Outs'
	    when "Base/Out State" = '100 0' THEN '1B -- -- 0 Outs'
	    when "Base/Out State" = '010 0' THEN '-- 2B -- 0 Outs'
	    when "Base/Out State" = '001 0' THEN '-- -- 3B 0 Outs'
	    when "Base/Out State" = '110 0' THEN '1B 2B -- 0 Outs'
	    when "Base/Out State" = '101 0' THEN '1B -- 3B 0 Outs'
	    when "Base/Out State" = '011 0' THEN '-- 2B 3B 0 Outs'
	    when "Base/Out State" = '111 0' THEN '1B 2B 3B 0 Outs'
		when "Base/Out State" = '000 1' THEN '-- -- -- 1 Out'
	    when "Base/Out State" = '100 1' THEN '1B -- -- 1 Out'
	    when "Base/Out State" = '010 1' THEN '-- 2B -- 1 Out'
	    when "Base/Out State" = '001 1' THEN '-- -- 3B 1 Out'
	    when "Base/Out State" = '110 1' THEN '1B 2B -- 1 Out'
	    when "Base/Out State" = '101 1' THEN '1B -- 3B 1 Out'
	    when "Base/Out State" = '011 1' THEN '-- 2B 3B 1 Out'
	    when "Base/Out State" = '111 1' THEN '1B 2B 3B 1 Out'
		when "Base/Out State" = '000 2' THEN '-- -- -- 2 Outs'
	    when "Base/Out State" = '100 2' THEN '1B -- -- 2 Outs'
	    when "Base/Out State" = '010 2' THEN '-- 2B -- 2 Outs'
	    when "Base/Out State" = '001 2' THEN '-- -- 3B 2 Outs'
	    when "Base/Out State" = '110 2' THEN '1B 2B -- 2 Outs'
	    when "Base/Out State" = '101 2' THEN '1B -- 3B 2 Outs'
	    when "Base/Out State" = '011 2' THEN '-- 2B 3B 2 Outs'
	    when "Base/Out State" = '111 2' THEN '1B 2B 3B 2 Outs'
	   end as "Base/Out State",
	   "Event", 
	   "N", 
	   "Runs to End of Inning", 
	   "Average Runs"
  from events
),
re as (
  select season,
         "state",
		 event_cd,
		 avg(runs_scored) as runs_scored,
         avg(rv_start) as rv_start,
		 avg(rv_end) as rv_end,
		 avg(run_value) as run_value
  from run_expectancy.full_rv_1912_2024
  group by season, "state", event_cd
),
cleaned_with_re as (
  select cl.*,
		 "Average Runs" - r.rv_start as "Original RE (Avg Runs - Starting RE)",
		 r.runs_scored as "Runs Scored",
         r.rv_start as "Starting RE (overall B/O State)",
		 r.rv_end as "Ending RE (overall B/O State",
		 r.rv_start + r.runs_scored as "Ending RE (Event)",
		 r.run_value as "Run Value"
  from cleaned cl
  left join re r on cl."Season" = r.season and cl."Numeric B/O State" = r."state" and cl.event_cd = r.event_cd
)
select bases_state_order,
       event_cd,
       "Season",
       "Numeric B/O State",
	   "Base/Out State",
	   "Event", 
	   "N", 
	   "Runs to End of Inning", 
	   "Average Runs",
	   "Original RE (Avg Runs - Starting RE)",
	   "Runs Scored",
       "Starting RE (overall B/O State)",
	   "Ending RE (overall B/O State",
	   "Ending RE (Event)",
	   "Run Value"
from cleaned_with_re
order by "Season", bases_state_order;

create table gdp_article_2017_2024.gdp_rv_by_state as
with basis as (
  select *
  from run_expectancy.full_rv_1912_2024
  where inn_ct <= 9.0 and not (inn_ct = 9.0 and bat_home_id = '1') and cast(season as integer) > 2016
),
gdp as (
  select season as "Season",
         bat_team_id as "Batting Team",
         "state" as "Base/Out State",
		 event_cd,
         'GDP' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_tx like '%GDP%'
  group by season, bat_team_id, "state", event_cd
),
events as (
  select "Season", "Batting Team", "Base/Out State", event_cd, "Event", "N", "Runs to End of Inning", "Average Runs"
  from gdp
),
cleaned as (
  select "Season",
       "Batting Team",
       "Base/Out State" as "Numeric B/O State",
	    event_cd,
       case
	    when "Base/Out State" = '000 0' THEN 1
	    when "Base/Out State" = '100 0' THEN 4
	    when "Base/Out State" = '010 0' THEN 7
	    when "Base/Out State" = '001 0' THEN 10
	    when "Base/Out State" = '110 0' THEN 13
	    when "Base/Out State" = '101 0' THEN 16
	    when "Base/Out State" = '011 0' THEN 19
	    when "Base/Out State" = '111 0' THEN 22
		when "Base/Out State" = '000 1' THEN 2
	    when "Base/Out State" = '100 1' THEN 5
	    when "Base/Out State" = '010 1' THEN 8
	    when "Base/Out State" = '001 1' THEN 11
	    when "Base/Out State" = '110 1' THEN 14
	    when "Base/Out State" = '101 1' THEN 17
	    when "Base/Out State" = '011 1' THEN 20
	    when "Base/Out State" = '111 1' THEN 23
		when "Base/Out State" = '000 2' THEN 3
	    when "Base/Out State" = '100 2' THEN 6
	    when "Base/Out State" = '010 2' THEN 9
	    when "Base/Out State" = '001 2' THEN 12
	    when "Base/Out State" = '110 2' THEN 15
	    when "Base/Out State" = '101 2' THEN 18
	    when "Base/Out State" = '011 2' THEN 21
	    when "Base/Out State" = '111 2' THEN 24
	   end as bases_state_order,
	   case
	    when "Base/Out State" = '000 0' THEN '-- -- -- 0 Outs'
	    when "Base/Out State" = '100 0' THEN '1B -- -- 0 Outs'
	    when "Base/Out State" = '010 0' THEN '-- 2B -- 0 Outs'
	    when "Base/Out State" = '001 0' THEN '-- -- 3B 0 Outs'
	    when "Base/Out State" = '110 0' THEN '1B 2B -- 0 Outs'
	    when "Base/Out State" = '101 0' THEN '1B -- 3B 0 Outs'
	    when "Base/Out State" = '011 0' THEN '-- 2B 3B 0 Outs'
	    when "Base/Out State" = '111 0' THEN '1B 2B 3B 0 Outs'
		when "Base/Out State" = '000 1' THEN '-- -- -- 1 Out'
	    when "Base/Out State" = '100 1' THEN '1B -- -- 1 Out'
	    when "Base/Out State" = '010 1' THEN '-- 2B -- 1 Out'
	    when "Base/Out State" = '001 1' THEN '-- -- 3B 1 Out'
	    when "Base/Out State" = '110 1' THEN '1B 2B -- 1 Out'
	    when "Base/Out State" = '101 1' THEN '1B -- 3B 1 Out'
	    when "Base/Out State" = '011 1' THEN '-- 2B 3B 1 Out'
	    when "Base/Out State" = '111 1' THEN '1B 2B 3B 1 Out'
		when "Base/Out State" = '000 2' THEN '-- -- -- 2 Outs'
	    when "Base/Out State" = '100 2' THEN '1B -- -- 2 Outs'
	    when "Base/Out State" = '010 2' THEN '-- 2B -- 2 Outs'
	    when "Base/Out State" = '001 2' THEN '-- -- 3B 2 Outs'
	    when "Base/Out State" = '110 2' THEN '1B 2B -- 2 Outs'
	    when "Base/Out State" = '101 2' THEN '1B -- 3B 2 Outs'
	    when "Base/Out State" = '011 2' THEN '-- 2B 3B 2 Outs'
	    when "Base/Out State" = '111 2' THEN '1B 2B 3B 2 Outs'
	   end as "Base/Out State",
	   "Event", 
	   "N", 
	   "Runs to End of Inning", 
	   "Average Runs"
  from events
),
re as (
  select season,
         "state",
		 event_cd,
		 avg(runs_scored) as runs_scored,
         avg(rv_start) as rv_start,
		 avg(rv_end) as rv_end,
		 avg(run_value) as run_value
  from run_expectancy.full_rv_1912_2024
  group by season, "state", event_cd
),
cleaned_with_re as (
  select cl.*,
		 "Average Runs" - r.rv_start as "Original RE (Avg Runs - Starting RE)",
		 r.runs_scored as "Runs Scored",
         r.rv_start as "Starting RE (overall B/O State)",
		 r.rv_end as "Ending RE (overall B/O State",
		 r.rv_start + r.runs_scored as "Ending RE (Event)",
		 r.run_value as "Run Value"
  from cleaned cl
  left join re r on cl."Season" = r.season and cl."Batting Team" = bat_team_id and cl."Numeric B/O State" = r."state" and cl.event_cd = r.event_cd
)
select bases_state_order,
       event_cd,
       "Season",
       "Batting Team",
       "Numeric B/O State",
	   "Base/Out State",
	   "Event", 
	   "N", 
	   "Runs to End of Inning", 
	   "Average Runs",
	   "Original RE (Avg Runs - Starting RE)",
	   "Runs Scored",
       "Starting RE (overall B/O State)",
	   "Ending RE (overall B/O State",
	   "Ending RE (Event)",
	   "Run Value"
from cleaned_with_re
order by "Season", "Batting Team", bases_state_order;

create table gdp_article_2017_2024.gdps_count_by_season_team as
select season ,
       fr.bat_team_id ,
       count(*) as gdps
from run_expectancy.full_rv_1912_2024 fr 
where fr.event_tx like '%GDP%' and cast(season as integer) > 2016
group by season, fr.bat_team_id 
order by season, count(*) desc;

create table gdp_article_2017_2024.gdps_count_by_season_team_inning as
select season ,
       cast(inn_ct as text) as inn_ct,
       fr.bat_team_id ,
       count(*) as gdps
from run_expectancy.full_rv_1912_2024 fr 
where fr.event_tx like '%GDP%' and cast(season as integer) > 2016
group by season, cast(inn_ct as text), fr.bat_team_id 
order by season, cast(inn_ct as text), count(*) desc;

create table gdp_article_2017_2024.gdps_count_by_season_team_state as
select season ,
       fr.bat_team_id ,
       state ,
       count(*) as gdps
from run_expectancy.full_rv_1912_2024 fr 
where fr.event_tx like '%GDP%' and cast(season as integer) > 2016
group by season, state, fr.bat_team_id 
order by season, state, count(*) desc;

create table gdp_article_2017_2024.gdps_count_by_season_team_state_inning as
select season ,
       cast(inn_ct as text) as inn_ct,
       fr.bat_team_id ,
       state ,
       count(*) as gdps
from run_expectancy.full_rv_1912_2024 fr 
where fr.event_tx like '%GDP%' and cast(season as integer) > 2016
group by season, cast(inn_ct as text), state, fr.bat_team_id 
order by season, cast(inn_ct as text), state, count(*) desc;

create table gdp_article_2017_2024.avg_value_of_out as
select *
from run_expectancy.events_run_value erv 
where erv."Event" = 'Out' and cast(season as integer) > 2016;

create table gdp_article_2017_2024.avg_value_of_out_by_base_state as
select *
from run_expectancy.events_rv_by_bo_state erbbs 
where erbbs."Event" = 'Out' and cast(season as integer) > 2016;