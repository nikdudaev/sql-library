-- Count of PLate Appearances

with retrosheet_pas as (
  select season,
         count(*) as retro_pas
  from run_expectancy.full_rv_1912_2023 fr 
  where bat_event_fl = 'T'  
  group by season
),
fangraphs_pas as (
  select cast("Season" as text) as season,
         "PA" as fg_pas
  from fangraphs.season_games_pas sgp 
  where "Season" < 2024
),
mlb_pas as (
  select cast(season_id as text) as season,
         "PA_CT" as big_query_pas
  from fangraphs.tango_pas tp
),
all_pas as (
  select rp.season,
         rp.retro_pas,
         fp.fg_pas,
         mp.big_query_pas
  from retrosheet_pas rp
  full join fangraphs_pas fp on rp.season = fp.season
  full join mlb_pas mp on rp.season = mp.season
  order by rp.season desc
)
select *,
       retro_pas - fg_pas as retro_minus_FG,
       retro_pas - big_query_pas as retro_minus_big_query_pas
from all_pas;