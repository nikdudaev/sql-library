create table run_expectancy.events_run_value as
with basis as (
  select *
  from run_expectancy.full_rv_1912_2024
  where inn_ct <= 9.0 and not (inn_ct = 9.0 and bat_home_id = '1')
),
homeruns as (
  select season as "Season",
         'Home Run' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '23'
  group by season
),
triples as (
  select season as "Season",
         'Triple' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '22'
  group by season
),
doubles as (
  select season as "Season",
         'Double' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '21'
  group by season
),
singles as (
  select season as "Season",
         'Single' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '20'
  group by season
),
errors as (
  select season as "Season",
         'Error' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '18'
  group by season
),
interference as (
  select season as "Season",
         'Interference' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '17'
  group by season
),
passed_ball as (
  select season as "Season",
         'Passed Ball' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '10'
  group by season
),
sac_bunt as (
  select season as "Season",
         'Sac Bunt' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where bunt_fl = 'T' and outs_ct < 2 and not bases in ('000')
  group by season
),
bunt as (
  select season as "Season",
         'Bunt' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where bunt_fl = 'T' and not (outs_ct < 2 and not bases in ('000'))
  group by season
),
wild_pitch as (
  select season as "Season",
         'Wild Pitch' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '9'
  group by season
),
balk as (
  select season as "Season",
         'Balk' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '11'
  group by season
),
bb as (
  select season as "Season",
         'Non-intentional Walk' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '14'
  group by season
),
ibb as (
  select season as "Season",
         'Intentional Walk' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '15'
  group by season
),
stolen_base as (
  select season as "Season",
         'Stolen Base' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '4'
  group by season
),
def_indifference as (
  select season as "Season",
         'Defensive Indifference' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '5'
  group by season
),
pickoff as (
  select season as "Season",
         'Pickoff' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '8'
  group by season
),
gen_out as (
  select season as "Season",
         'Out' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '2'
  group by season
),
strikeout as (
  select season as "Season",
         'Strikeout' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '3'
  group by season
),
caught_stealing as (
  select season as "Season",
         'Caught Stealing' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '6'
  group by season
),
events as (
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from homeruns
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from triples
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from doubles
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from singles
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from errors
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from interference
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from passed_ball
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from sac_bunt
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from bunt
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from wild_pitch
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from balk
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from bb
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from ibb
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from stolen_base
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from def_indifference
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from pickoff
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from gen_out
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from strikeout
  union all
  select "Season", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from caught_stealing
)
select *,
       "Average Runs" - "Starting RE" as "Run Value"
from events
order by "Season", "Average Runs" - "Starting RE" desc;