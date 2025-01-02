-- Detailed Linedrives stats
create table aggregations.linedrives_stats as
with linedrives_singles as (
-- Linedrives Singles
select season,
       count(*) as linedrives_singles,
       avg(run_value) as linedrives_singles_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'L' and event_cd = '20') and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
linedrives_singles_inf as (
-- Linedrives Singles to Infield
-- These do not include Pitcher or Catcher fielding
select season,
       count(*) as linedrives_singles_to_inf,
       avg(run_value) as linedrives_singles_to_inf_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'L' and event_cd = '20' and fld_cd in ('3', '4', '5', '6')) and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
linedrives_singles_of as (
-- Linedrives Singles to Infield
-- These do not include Pitcher or Catcher fielding
select season,
       count(*) as linedrives_singles_to_of,
       avg(run_value) as linedrives_singles_to_of_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'L' and event_cd = '20' and fld_cd in ('7', '8', '9')) and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
linedrives_doubles as (
-- Linedrives Doubles
select season,
       count(*) as linedrives_doubles,
       avg(run_value) as linedrives_doubles_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'L' and event_cd = '21') and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
linedrives_doubles_inf as (
-- Linedrives Doubles to Infield
-- These do not include Pitcher or Catcher fielding
select season,
       count(*) as linedrives_doubles_to_inf,
       avg(run_value) as linedrives_doubles_to_inf_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'L' and event_cd = '21' and fld_cd in ('3', '4', '5', '6')) and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
linedrives_doubles_of as (
-- Linedrives Doubles to Infield
-- These do not include Pitcher or Catcher fielding
select season,
       count(*) as linedrives_doubles_to_of,
       avg(run_value) as linedrives_doubles_to_of_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'L' and event_cd = '21' and fld_cd in ('7', '8', '9')) and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
linedrives_triples as (
-- Linedrives Triples
select season,
       count(*) as linedrives_triples,
       avg(run_value) as linedrives_triples_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'L' and event_cd = '22') and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
linedrives_triples_inf as (
-- Linedrives Triples to Infield
-- These do not include Pitcher or Catcher fielding
select season,
       count(*) as linedrives_triples_to_inf,
       avg(run_value) as linedrives_triples_to_inf_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'L' and event_cd = '22' and fld_cd in ('3', '4', '5', '6')) and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
linedrives_triples_of as (
-- Linedrives Triples to Infield
-- These do not include Pitcher or Catcher fielding
select season,
       count(*) as linedrives_triples_to_of,
       avg(run_value) as linedrives_triples_to_of_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'L' and event_cd = '22' and fld_cd in ('7', '8', '9')) and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
final_tbl as (
select lds.season,
       coalesce(lds.linedrives_singles, 0) as linedrives_singles,
       coalesce(lds.linedrives_singles_rv, 0.0) as linedrives_singles_rv,
       coalesce(ldsinf.linedrives_singles_to_inf, 0) as linedrives_singles_to_inf,
       coalesce(ldsinf.linedrives_singles_to_inf_rv, 0.0) as linedrives_singles_to_inf_rv,
       coalesce(ldsof.linedrives_singles_to_of, 0) as linedrives_singles_to_of,
       coalesce(ldsof.linedrives_singles_to_of_rv, 0.0) as linedrives_singles_to_of_rv,
       coalesce(ldd.linedrives_doubles, 0) as linedrives_doubles,
       coalesce(ldd.linedrives_doubles_rv, 0.0) as linedrives_doubles_rv,
       coalesce(lddinf.linedrives_doubles_to_inf, 0) as linedrives_doubles_to_inf,
       coalesce(lddinf.linedrives_doubles_to_inf_rv, 0.0) as linedrives_doubles_to_inf_rv,
       coalesce(lddof.linedrives_doubles_to_of, 0) as linedrives_doubles_to_of,
       coalesce(lddof.linedrives_doubles_to_of_rv, 0.0) as linedrives_doubles_to_of_rv,
       coalesce(ldt.linedrives_triples, 0) as linedrives_triples,
       coalesce(ldt.linedrives_triples_rv, 0.0) as linedrives_triples_rv,
       coalesce(ldtinf.linedrives_triples_to_inf, 0) as linedrives_triples_to_inf,
       coalesce(ldtinf.linedrives_triples_to_inf_rv, 0.0) as linedrives_triples_to_inf_rv,
       coalesce(ldtof.linedrives_triples_to_of, 0) as linedrives_triples_to_of,
       coalesce(ldtof.linedrives_triples_to_of_rv, 0.0) as linedrives_triples_to_of_rv
from linedrives_singles lds
left join linedrives_singles_inf ldsinf  on lds.season = ldsinf.season
left join linedrives_singles_of ldsof  on lds.season = ldsof.season 
left join linedrives_doubles ldd on lds.season = ldd.season
left join linedrives_doubles_inf lddinf on lds.season = lddinf.season
left join linedrives_doubles_of lddof on lds.season = lddof.season
left join linedrives_triples ldt on lds.season = ldt.season
left join linedrives_triples_inf ldtinf  on lds.season = ldtinf.season
left join linedrives_triples_of ldtof on lds.season = ldtof.season
)
select *
from final_tbl;