create table aggregations.events_run_value as
with basis as (
  select *
  from run_expectancy.full_rv_1912_2024
  where inn_ct <= 9.0 and not (inn_ct = 9.0 and bat_home_id = '1')
),
homeruns as (
  select season,
         count(*) as homeruns,
         round(avg(run_value), 3) as homeruns_rv
  from basis
  where event_cd = '23'
  group by season
),
triples as (
  select season,
         count(*) as triples,
         round(avg(run_value), 3) as triples_rv
  from basis
  where event_cd = '22'
  group by season
),
doubles as (
  select season,
         count(*) as doubles,
         round(avg(run_value), 3) as doubles_rv
  from basis
  where event_cd = '21'
  group by season
),
singles as (
  select season,
         count(*) as singles,
         round(avg(run_value), 3) as singles_rv
  from basis
  where event_cd = '20'
  group by season
),
errors as (
  select season,
         count(*) as errors,
         round(avg(run_value), 3) as errors_rv
  from basis
  where event_cd = '18'
  group by season
),
interference as (
  select season,
         count(*) as interference,
         round(avg(run_value), 3) as interference_rv
  from basis
  where event_cd = '17'
  group by season
),
passed_ball as (
  select season,
         count(*) as passed_balls,
         round(avg(run_value), 3) as passed_balls_rv
  from basis
  where event_cd = '10'
  group by season
),
sac_bunt as (
  select season,
         count(*) as sac_bunts,
         round(avg(run_value), 3) as sac_bunts_rv
  from basis
  where bunt_fl = 'T' and outs_ct < 2 and not bases in ('000')
  group by season
),
bunt as (
  select season,
         count(*) as bunts,
         round(avg(run_value), 3) as bunts_rv
  from basis
  where bunt_fl = 'T' and not (outs_ct < 2 and not bases in ('000'))
  group by season
),
wild_pitch as (
  select season,
         count(*) as wild_pitches,
         round(avg(run_value), 3) as wild_pitches_rv
  from basis
  where event_cd = '9'
  group by season
),
balk as (
  select season,
         count(*) as balks,
         round(avg(run_value), 3) as balks_rv
  from basis
  where event_cd = '11'
  group by season
),
walk as (
  select season,
         count(*) as walks,
         round(avg(run_value), 3) as walks_rv
  from basis
  where event_cd = '14'
  group by season
),
intentional_walk as (
  select season,
         count(*) as intentional_walks,
         round(avg(run_value), 3) as intentional_walks_rv
  from basis
  where event_cd = '15'
  group by season
),
stolen_base as (
  select season,
         count(*) as stolen_bases,
         round(avg(run_value), 3) as stolen_bases_rv
  from basis
  where event_cd = '4'
  group by season
),
def_indifference as (
  select season,
         count(*) as def_indiff,
         round(avg(run_value), 3) as def_indiff_rv
  from basis
  where event_cd = '5'
  group by season
),
pickoff as (
  select season,
         count(*) as pickoffs,
         round(avg(run_value), 3) as pickoffs_rv
  from basis
  where event_cd = '8'
  group by season
),
gen_out as (
  select season,
         count(*) as outs,
         round(avg(run_value), 3) as outs_rv
  from basis
  where event_cd = '2'
  group by season
),
strikeout as (
  select season,
         count(*) as strikeouts,
         round(avg(run_value), 3) as strikeouts_rv
  from basis
  where event_cd = '3'
  group by season
),
caught_stealing as (
  select season,
         count(*) as caught_stealing,
         round(avg(run_value), 3) as caught_stealing_rv
  from basis
  where event_cd = '6'
  group by season
),
final_tbl as (
  select s.season,
         s.singles,
         s.singles_rv,
         db.doubles,
         db.doubles_rv,
         tr.triples,
         tr.triples_rv,
         hor.homeruns,
         hor.homeruns_rv,
         bb.walks,
         bb.walks_rv,
         ibb.intentional_walks,
         ibb.intentional_walks_rv,
         err.errors,
         err.errors_rv,
         intf.interference,
         intf.interference_rv,
         psb.passed_balls,
         psb.passed_balls_rv,
         sb.sac_bunts,
         sb.sac_bunts_rv,
         bnt.bunts,
         bnt.bunts_rv,
         wp.wild_pitches,
         wp.wild_pitches_rv,
         blk.balks,
         blk.balks_rv,
         stb.stolen_bases,
         stb.stolen_bases_rv,
         defind.def_indiff,
         defind.def_indiff_rv,
         pko.pickoffs,
         pko.pickoffs_rv,
         gout.outs,
         gout.outs_rv,
         sko.strikeouts,
         sko.strikeouts_rv,
         cs.caught_stealing,
         cs.caught_stealing_rv
  from singles s
  left join doubles db 
  on s.season = db.season
  left join triples tr 
  on s.season = tr.season
  left join homeruns hor 
  on s.season = hor.season
  left join walk bb
  on s.season = bb.season
  left join intentional_walk ibb
  on s.season = ibb.season
  left join errors err
  on s.season = err.season
  left join interference intf
  on s.season = intf.season
  left join passed_ball psb
  on s.season = psb.season
  left join sac_bunt  sb
  on s.season = sb.season
  left join bunt bnt
  on s.season = bnt.season
  left join wild_pitch wp
  on s.season = wp.season
  left join balk blk
  on s.season = blk.season
  left join stolen_base stb
  on s.season = stb.season
  left join def_indifference defind
  on s.season = defind.season
  left join pickoff pko
  on s.season = pko.season
  left join gen_out gout
  on s.season = gout.season
  left join strikeout sko
  on s.season = sko.season
  left join caught_stealing cs
  on s.season = cs.season
)
select *
from final_tbl;