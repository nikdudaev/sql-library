-- BABIP numerator and denominator
create table aggregations.babip as
with babip_numerator as (
-- Total hits excluding Home runs or BABIP numerator
select season,
       count(*) as babip_numerator
from run_expectancy.full_rv_1912_2024 fr 
where event_cd in ('20', '21', '22')
group by season
),
babip_denominator as (
-- AB - K - HR + SF or BABIP denominator
select season,
       count(*) as babip_denominator
from run_expectancy.full_rv_1912_2024 fr 
where ((ab_fl = 'T' and not event_cd in ('3', '23')) or sf_fl = 'T')
group by season
),
final_tbl as (
  select bn.season,
         bn.babip_numerator,
         bd.babip_denominator,
         round(cast(bn.babip_numerator as numeric) / cast(bd.babip_denominator as numeric),3) as babip
  from babip_numerator bn
  left join babip_denominator bd
  on bn.season = bd.season
)
select *
from final_tbl;