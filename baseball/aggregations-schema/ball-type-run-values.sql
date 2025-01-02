create table aggregations.ball_type_run_values as
with basis as (
  select *
  from run_expectancy.full_rv_1912_2024
  where inn_ct <= 9.0 and not (inn_ct = 9.0 and bat_home_id = '1')
),
flyballs_total_rv as (
  select season as "Season",
         'Flyballs/Popups' as "Ball Type",
         round(avg(run_value), 6) as "Run Value"
  from basis
  where battedball_cd in ('F', 'P')
  group by season
),
linedrives_total_rv as (
  select season as "Season",
         'Linedrives' as "Ball Type",
         round(avg(run_value), 6) as "Run Value"
  from basis
  where battedball_cd = 'L'
  group by season
),
groundballs_total_rv as (
  select season as "Season",
         'Groundballs' as "Ball Type",
         round(avg(run_value), 6) as "Run Value"
  from basis
  where battedball_cd = 'G'
  group by season
),
final_tbl as (
  select *
  from flyballs_total_rv
  union all
  select *
  from linedrives_total_rv
  union all
  select *
  from groundballs_total_rv
)
select *
from final_tbl;