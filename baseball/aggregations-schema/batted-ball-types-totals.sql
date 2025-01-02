-- Batted Ball Types total stats and rates
-- Calculations are reconciled with BR and BP numbers
-- Fangraphs numbers will be different because they use BIS data instead
create table aggregations.batted_ball_types_totals as
with flyballs as (
-- Total Flyballs
select season,
       count(*) as flyballs_total
from run_expectancy.full_rv_1912_2024 fr 
where battedball_cd = 'F'  and (ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3')
group by season
),
flyballs_excl_hr as (
-- Flyballs excluding Home runs
select season,
       count(*) as flyballs_excl_hr
from run_expectancy.full_rv_1912_2024 fr 
where battedball_cd = 'F'  and (ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3', '23')
group by season
),
flyballs_of as (
-- Flyballs to OF excluding Home runs
select season,
       count(*) as flyballs_of
from run_expectancy.full_rv_1912_2024 fr 
where battedball_cd = 'F' and fld_cd in ('7', '8', '9') and (ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3', '23')
group by season
),
linedrives as (
-- Total Linedrives
select season,
       count(*) as linedrives_total
from run_expectancy.full_rv_1912_2024 fr 
where battedball_cd = 'L'  and (ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3')
group by season
),
linedrives_excl_hr as (
-- Total Linedrives
select season,
       count(*) as linedrives_excl_hr
from run_expectancy.full_rv_1912_2024 fr 
where battedball_cd = 'L'  and (ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3', '23')
group by season
),
linedrives_of as (
-- Linedrives to OF
select season,
       count(*) as linedrives_of
from run_expectancy.full_rv_1912_2024 fr 
where battedball_cd = 'L' and fld_cd in ('7', '8', '9') and (ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3', '23')
group by season
),
groundballs as (
-- Total Groundballs
select season,
       count(*) as groundballs_total
from run_expectancy.full_rv_1912_2024 fr 
where battedball_cd = 'G'  and (ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3') and not bunt_fl = 'T'
group by season
),
popups as (
-- Total Popups
select season,
       count(*) as popups_total
from run_expectancy.full_rv_1912_2024 fr 
where battedball_cd = 'P'  and (ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3')
group by season
),
balls_in_play as (
-- Total Balls in Play
select season,
       count(*) as balls_in_play
from run_expectancy.full_rv_1912_2024 fr 
where (ab_fl = 'T' or sf_fl = 'T' or sh_fl = 'T') and not event_cd in ('3')
group by season
),
final_tbl as (
  select fb.season,
         fb.flyballs_total,
         ld.linedrives_total,
         gb.groundballs_total,
         p.popups_total,
         round(cast(fb.flyballs_total as numeric) / cast(bip.balls_in_play as numeric), 4) as flyballs_pct,
         round(cast(ld.linedrives_total as numeric) / cast(bip.balls_in_play as numeric), 4) as linedrives_pct,
         round(cast(gb.groundballs_total as numeric) / cast(bip.balls_in_play as numeric), 4) as groundballs_pct,
         round(cast(p.popups_total as numeric) / cast(fb.flyballs_total as numeric), 4) as popup_pct,
         fbehr.flyballs_excl_hr,
         ldehr.linedrives_excl_hr,
         fbof.flyballs_of,
         ldof.linedrives_of
  from flyballs fb
  left join linedrives ld
  on fb.season = ld.season
  left join groundballs gb
  on fb.season = gb.season
  left join popups p
  on fb.season = p.season
  left join balls_in_play bip
  on fb.season = bip.season
  left join flyballs_excl_hr fbehr
  on fb.season = fbehr.season
  left join linedrives_excl_hr ldehr
  on fb.season = ldehr.season
  left join flyballs_of fbof
  on fb.season = fbof.season
  left join linedrives_of ldof
  on fb.season = ldof.season
)
select *
from final_tbl;