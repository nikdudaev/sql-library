create table run_expectancy.events_rv_by_bo_state as
with basis as (
  select *
  from run_expectancy.full_rv_1912_2023
  where inn_ct <= 9.0 and not (inn_ct = 9.0 and bat_home_id = '1')
),
homeruns as (
  select season as "Season",
         "state" as "Base/Out State",
         'Home Run' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '23'
  group by season, "state"
),
triples as (
  select season as "Season",
         "state" as "Base/Out State",
         'Triple' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '22'
  group by season, "state"
),
doubles as (
  select season as "Season",
         "state" as "Base/Out State",
         'Double' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '21'
  group by season, "state"
),
singles as (
  select season as "Season",
         "state" as "Base/Out State",
         'Single' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '20'
  group by season, "state"
),
errors as (
  select season as "Season",
         "state" as "Base/Out State",
         'Error' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '18'
  group by season, "state"
),
interference as (
  select season as "Season",
         "state" as "Base/Out State",
         'Interference' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '17'
  group by season, "state"
),
passed_ball as (
  select season as "Season",
         "state" as "Base/Out State",
         'Passed Ball' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '10'
  group by season, "state"
),
sac_bunt as (
  select season as "Season",
         "state" as "Base/Out State",
         'Sac Bunt' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where bunt_fl = 'T' and outs_ct < 2 and not bases in ('000')
  group by season, "state"
),
bunt as (
  select season as "Season",
         "state" as "Base/Out State",
         'Bunt' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where bunt_fl = 'T' and not (outs_ct < 2 and not bases in ('000'))
  group by season, "state"
),
wild_pitch as (
  select season as "Season",
         "state" as "Base/Out State",
         'Wild Pitch' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '9'
  group by season, "state"
),
balk as (
  select season as "Season",
         "state" as "Base/Out State",
         'Balk' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '11'
  group by season, "state"
),
bb as (
  select season as "Season",
         "state" as "Base/Out State",
         'Non-intentional Walk' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '14'
  group by season, "state"
),
ibb as (
  select season as "Season",
         "state" as "Base/Out State",
         'Intentional Walk' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '15'
  group by season, "state"
),
stolen_base as (
  select season as "Season",
         "state" as "Base/Out State",
         'Stolen Base' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '4'
  group by season, "state"
),
def_indifference as (
  select season as "Season",
         "state" as "Base/Out State",
         'Defensive Indifference' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '5'
  group by season, "state"
),
pickoff as (
  select season as "Season",
         "state" as "Base/Out State",
         'Pickoff' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '8'
  group by season, "state"
),
gen_out as (
  select season as "Season",
         "state" as "Base/Out State",
         'Out' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '2'
  group by season, "state"
),
strikeout as (
  select season as "Season",
         "state" as "Base/Out State",
         'Strikeout' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '3'
  group by season, "state"
),
caught_stealing as (
  select season as "Season",
         "state" as "Base/Out State",
         'Caught Stealing' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_cd = '6'
  group by season, "state"
),
events as (
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from homeruns
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from triples
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from doubles
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from singles
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from errors
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from interference
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from passed_ball
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from sac_bunt
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from bunt
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from wild_pitch
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from balk
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from bb
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from ibb
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from stolen_base
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from def_indifference
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from pickoff
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from gen_out
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from strikeout
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs"
  from caught_stealing
),
cleaned as (
  select "Season",
       "Base/Out State" as "Numeric B/O State",
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
         avg(rv_start) as rv_start
  from run_expectancy.full_rv_1912_2023
  group by season, "state"
),
cleaned_with_re as (
  select cl.*,
         r.rv_start as "Starting RE",
		 cl."Average Runs" - r.rv_start as "Run Value"
  from cleaned cl
  left join re r on cl."Season" = r.season and cl."Numeric B/O State" = r."state"
)
select *
from cleaned_with_re
order by "Season", bases_state_order;