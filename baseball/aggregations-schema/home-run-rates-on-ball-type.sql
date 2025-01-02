create table aggregations.home_run_rates_on_ball_type as
with flyballs_homeruns as (
-- Flyball Home runs
select season,
       count(*) as flyball_homeruns,
       avg(run_value) as flyball_homeruns_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'F' and event_cd = '23')
group by season
),
linedrives_homeruns as (
-- Linedrive Home runs
select season,
       count(*) as linedrive_homeruns,
       avg(run_value) as linedrive_homeruns_rv
from run_expectancy.full_rv_1912_2024 fr 
where (battedball_cd = 'L' and event_cd = '23')
group by season
),
ball_type_total as (
-- Ball Types Totals
select bbtt.season,
       bbtt.flyballs_total,
       bbtt.linedrives_total,
       bbtt.popups_total
from aggregations.batted_ball_types_totals bbtt 
),
final_tbl as (
select btt.season,
       btt.flyballs_total,
       btt.linedrives_total,
       btt.popups_total,
       fbhr.flyball_homeruns,
       ldhr.linedrive_homeruns,
       cast(fbhr.flyball_homeruns as numeric) / (cast(btt.flyballs_total as numeric) + cast(btt.popups_total as numeric)) as hr_rate_on_flyballs_popups,
       cast(fbhr.flyball_homeruns as numeric) / cast(btt.flyballs_total as numeric) as hr_rate_on_flyballs,
       cast(ldhr.linedrive_homeruns as numeric) / cast(btt.linedrives_total as numeric) as hr_rate_on_linedrives,
       fbhr.flyball_homeruns_rv,
       ldhr.linedrive_homeruns_rv
from ball_type_total btt
left join flyballs_homeruns fbhr
on btt.season = fbhr.season
left join linedrives_homeruns ldhr
on btt.season = ldhr.season
)
select *
from final_tbl;