create table re_batting.events_run_value_by_base_out_state_1912_2023 as
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where bunt_fl = 'T' and sh_fl = 'T'
  group by season, "state"
),
bunt as (
  select season as "Season",
         "state" as "Base/Out State",
         'Bunt' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where bunt_fl = 'T'
  group by season, "state"
),
wild_pitch as (
  select season as "Season",
         "state" as "Base/Out State",
         'Wild Pitch' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
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
		 round(avg(runs_roi), 3) as "Average Runs",
         round(avg(rv_start), 3) as "Starting RE"
  from basis
  where event_cd = '6'
  group by season, "state"
),
events as (
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from homeruns
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from triples
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from doubles
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from singles
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from errors
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from interference
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from passed_ball
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from sac_bunt
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from bunt
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from wild_pitch
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from balk
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from bb
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from ibb
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from stolen_base
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from def_indifference
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from pickoff
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from gen_out
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from strikeout
  union all
  select "Season", "Base/Out State", "Event", "N", "Runs to End of Inning", "Average Runs", "Starting RE"
  from caught_stealing
)
select *,
       "Average Runs" - "Starting RE" as "Run Value"
from events
order by "Season", "Base/Out State", "Average Runs" - "Starting RE" desc;