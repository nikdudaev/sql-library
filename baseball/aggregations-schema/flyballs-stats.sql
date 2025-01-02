-- Detailed Flyballs stats
create table aggregations.flyballs_stats as
with flyballs_singles as (
-- Flyballs Singles
select season,
       count(*) as flyballs_singles,
       avg(run_value) as flyballs_singles_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'F' and event_cd = '20') and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
flyballs_singles_inf as (
-- Flyballs Singles to Infield
-- These do not include Pitcher or Catcher fielding
select season,
       count(*) as flyballs_singles_to_inf,
       avg(run_value) as flyballs_singles_to_inf_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'F' and event_cd = '20' and fld_cd in ('3', '4', '5', '6')) and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
flyballs_singles_of as (
-- Flyballs Singles to Infield
-- These do not include Pitcher or Catcher fielding
select season,
       count(*) as flyballs_singles_to_of,
       avg(run_value) as flyballs_singles_to_of_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'F' and event_cd = '20' and fld_cd in ('7', '8', '9')) and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
flyballs_doubles as (
-- Flyballs Doubles
select season,
       count(*) as flyballs_doubles,
       avg(run_value) as flyballs_doubles_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'F' and event_cd = '21') and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
flyballs_doubles_inf as (
-- Flyballs Doubles to Infield
-- These do not include Pitcher or Catcher fielding
select season,
       count(*) as flyballs_doubles_to_inf,
       avg(run_value) as flyballs_doubles_to_inf_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'F' and event_cd = '21' and fld_cd in ('3', '4', '5', '6')) and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
flyballs_doubles_of as (
-- Flyballs Doubles to Infield
-- These do not include Pitcher or Catcher fielding
select season,
       count(*) as flyballs_doubles_to_of,
       avg(run_value) as flyballs_doubles_to_of_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'F' and event_cd = '21' and fld_cd in ('7', '8', '9')) and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
flyballs_triples as (
-- Flyballs Triples
select season,
       count(*) as flyballs_triples,
       avg(run_value) as flyballs_triples_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'F' and event_cd = '22') and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
flyballs_triples_inf as (
-- Flyballs Triples to Infield
-- These do not include Pitcher or Catcher fielding
select season,
       count(*) as flyballs_triples_to_inf,
       avg(run_value) as flyballs_triples_to_inf_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'F' and event_cd = '22' and fld_cd in ('3', '4', '5', '6')) and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
flyballs_triples_of as (
-- Flyballs Triples to Infield
-- These do not include Pitcher or Catcher fielding
select season,
       count(*) as flyballs_triples_to_of,
       avg(run_value) as flyballs_triples_to_of_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'F' and event_cd = '22' and fld_cd in ('7', '8', '9')) and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
flyballs_homeruns as (
-- Flyballs Homeruns
select season,
       count(*) as flyballs_homeruns,
       avg(run_value) as flyballs_homeruns_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'F' and event_cd = '23') and ((ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3'))
group by season
),
final_tbl as (
select fbs.season,
       coalesce(fbs.flyballs_singles, 0) as flyballs_singles,
       coalesce(fbs.flyballs_singles_rv, 0.0) as flyballs_singles_rv,
       coalesce(fbsinf.flyballs_singles_to_inf, 0) as flyballs_singles_to_inf,
       coalesce(fbsinf.flyballs_singles_to_inf_rv, 0.0) as flyballs_singles_to_inf_rv,
       coalesce(fbsof.flyballs_singles_to_of, 0) as flyballs_singles_to_of,
       coalesce(fbsof.flyballs_singles_to_of_rv, 0.0) as flyballs_singles_to_of_rv,
       coalesce(fbd.flyballs_doubles, 0) as flyballs_doubles,
       coalesce(fbd.flyballs_doubles_rv, 0.0) as flyballs_doubles_rv,
       coalesce(fbdinf.flyballs_doubles_to_inf, 0) as flyballs_doubles_to_inf,
       coalesce(fbdinf.flyballs_doubles_to_inf_rv, 0.0) as flyballs_doubles_to_inf_rv,
       coalesce(fbdof.flyballs_doubles_to_of, 0) as flyballs_doubles_to_of,
       coalesce(fbdof.flyballs_doubles_to_of_rv, 0.0) as flyballs_doubles_to_of_rv,
       coalesce(fbt.flyballs_triples, 0) as flyballs_triples,
       coalesce(fbt.flyballs_triples_rv, 0.0) as flyballs_triples_rv,
       coalesce(fbtinf.flyballs_triples_to_inf, 0) as flyballs_triples_to_inf,
       coalesce(fbtinf.flyballs_triples_to_inf_rv, 0.0) as flyballs_triples_to_inf_rv,
       coalesce(fbtof.flyballs_triples_to_of, 0) as flyballs_triples_to_of,
       coalesce(fbtof.flyballs_triples_to_of_rv, 0.0) as flyballs_triples_to_of_rv
from flyballs_singles fbs
left join flyballs_singles_inf fbsinf  on fbs.season = fbsinf.season
left join flyballs_singles_of fbsof  on fbs.season = fbsof.season 
left join flyballs_doubles fbd on fbs.season = fbd.season
left join flyballs_doubles_inf fbdinf on fbs.season = fbdinf.season
left join flyballs_doubles_of fbdof on fbs.season = fbdof.season
left join flyballs_triples fbt on fbs.season = fbt.season
left join flyballs_triples_inf fbtinf  on fbs.season = fbtinf.season
left join flyballs_triples_of fbtof on fbs.season = fbtof.season
left join flyballs_homeruns fbhr on fbs.season = fbhr.season
)
select *
from final_tbl;