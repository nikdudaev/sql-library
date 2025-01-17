-- Creating separate events source table joined with games logs to identify day/night games
create table gdp_article_2017_2024.events_source_2017_2024 as
with game_details as (
select gl.game_id ,
       gl.game_dy ,
       gl.daynight_park_cd 
from retrosheet.game_logs gl 
where cast(left(game_dt,4) as integer) > 2016
),
events as (
select game_id,
       away_team_id,
       home_team_id,
       inn_ct,
       bat_home_id,
       away_score_ct,
       home_score_ct,
       bat_id,
       bat_hand_cd,
       pit_hand_cd,
       event_tx,
       leadoff_fl,
       ph_fl,
       bat_lineup_id,
       event_cd,
       dp_fl,
       fld_cd,
       bunt_fl,
       bat_team_id,
       inn_end_fl,
       pit_start_fl,
       game_date,
       season,
       runs_scored,
       bases,
       state,
       new_bases,
       new_state,
       rv_start,
       rv_end,
       run_value
from run_expectancy.full_rv_1912_2024 fr
where cast(season as integer) > 2016
),
merged as (
  select ev.*,
         gd.game_dy,
         gd.daynight_park_cd
  from events ev
  left join game_details gd
  on ev.game_id = gd.game_id
)
select *
from merged;

-- Calculating GDP counts for all teams and for the Yankees separately: 
--   totals
--   day/night
--   week day
--   home/away
--   month
--   batters

-- GDP by day/night games
create table gdp_article_2017_2024.nya_gdps_in_day_night_games as
with gdp_count_day_night_long as (
  select season,
         bat_team_id,
         daynight_park_cd,
         count(*) day_night_offensive_gdps
  from gdp_article_2017_2024.events_source_2017_2024
  where event_tx like '%GDP%' and bat_team_id = 'NYA'
  group by season, bat_team_id, daynight_park_cd
),
gdp_count_day_night_wide as (
  select season,
         bat_team_id,
         max(case when daynight_park_cd = 'D' then day_night_offensive_gdps else 0 end) as day_games_offensive_gdps,
         max(case when daynight_park_cd = 'N' then day_night_offensive_gdps else 0 end) as night_games_offensive_gdps
  from gdp_count_day_night_long
  group by season, bat_team_id
),
away_games_daynight_counts_long as (
 select left(game_dt, 4) as season,
        away_team_id,
        daynight_park_cd,
        count(*) as away_games
 from retrosheet.game_logs
 where cast(left(game_dt, 4) as integer) > 2016 and away_team_id = 'NYA'
 group by left(game_dt, 4), away_team_id, daynight_park_cd
),
home_games_daynight_counts_long as (
 select left(game_dt, 4) as season,
        home_team_id,
        daynight_park_cd,
        count(*) as home_games
 from retrosheet.game_logs
 where cast(left(game_dt, 4) as integer) > 2016 and home_team_id = 'NYA'
 group by left(game_dt, 4), home_team_id, daynight_park_cd
),
away_games_daynight_counts_wide as (
 select season,
        away_team_id,
        max(case when daynight_park_cd = 'D' then away_games else 0 end) as away_day_games_count,
        max(case when daynight_park_cd = 'N' then away_games else 0 end) as away_night_games_count
 from away_games_daynight_counts_long
 group by season, away_team_id
),
home_games_daynight_counts_wide as (
 select season,
        home_team_id,
        max(case when daynight_park_cd = 'D' then home_games else 0 end) as home_day_games_count,
        max(case when daynight_park_cd = 'N' then home_games else 0 end) as home_night_games_count
 from home_games_daynight_counts_long
 group by season, home_team_id
),
final_tbl as (
  select gcdnw.season,
         round(cast(gcdnw.day_games_offensive_gdps as numeric) / cast((agdcw.away_day_games_count + hgdcw.home_day_games_count) as numeric),2) as gdps_per_day_game,
         round(cast(gcdnw.night_games_offensive_gdps as numeric) / cast((agdcw.away_night_games_count + hgdcw.home_night_games_count) as numeric),2) as gdps_per_night_game,
         round((cast(gcdnw.day_games_offensive_gdps as numeric) + cast(gcdnw.night_games_offensive_gdps as numeric)) / cast((agdcw.away_day_games_count + hgdcw.home_day_games_count + agdcw.away_night_games_count + hgdcw.home_night_games_count) as numeric),2) as gdps_per_game
  from gdp_count_day_night_wide gcdnw
  left join away_games_daynight_counts_wide agdcw
  on gcdnw.season = agdcw.season and gcdnw.bat_team_id = agdcw.away_team_id
  left join home_games_daynight_counts_wide hgdcw
  on gcdnw.season = hgdcw.season and gcdnw.bat_team_id = hgdcw.home_team_id
)
select *
from final_tbl
where season != '2020';



-- GDP Run Value statistics
create table gdp_article_2017_2024.gdp_rv_by_state as
with basis as (
  select *
  from run_expectancy.full_rv_1912_2024
  where inn_ct <= 9.0 and not (inn_ct = 9.0 and bat_home_id = '1') and cast(season as integer) > 2016
),
gdp as (
  select season as "Season",
         "state" as "Base/Out State",
		 event_cd,
         'GDP' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_tx like '%GDP%'
  group by season, "state", event_cd
),
events as (
  select "Season", "Base/Out State", event_cd, "Event", "N", "Runs to End of Inning", "Average Runs"
  from gdp
),
cleaned as (
  select "Season",
       "Base/Out State" as "Numeric B/O State",
	    event_cd,
       case
	    when "Base/Out State" = '000 0' THEN 1
	    when "Base/Out State" = '100 0' THEN 4
	    when "Base/Out State" = '010 0' THEN 7
	    when "Base/Out State" = '001 0' THEN 10
	    when "Base/Out State" = '110 0' THEN 13
	    when "Base/Out State" = '101 0' THEN 16
	    when "Base/Out State" = '011 0' THEN 19
	    when "Base/Out State" = '111 0' THEN 22
		when "Base/Out State" = '000 1' THEN 2
	    when "Base/Out State" = '100 1' THEN 5
	    when "Base/Out State" = '010 1' THEN 8
	    when "Base/Out State" = '001 1' THEN 11
	    when "Base/Out State" = '110 1' THEN 14
	    when "Base/Out State" = '101 1' THEN 17
	    when "Base/Out State" = '011 1' THEN 20
	    when "Base/Out State" = '111 1' THEN 23
		when "Base/Out State" = '000 2' THEN 3
	    when "Base/Out State" = '100 2' THEN 6
	    when "Base/Out State" = '010 2' THEN 9
	    when "Base/Out State" = '001 2' THEN 12
	    when "Base/Out State" = '110 2' THEN 15
	    when "Base/Out State" = '101 2' THEN 18
	    when "Base/Out State" = '011 2' THEN 21
	    when "Base/Out State" = '111 2' THEN 24
	   end as bases_state_order,
	   case
	    when "Base/Out State" = '000 0' THEN '-- -- -- 0 Outs'
	    when "Base/Out State" = '100 0' THEN '1B -- -- 0 Outs'
	    when "Base/Out State" = '010 0' THEN '-- 2B -- 0 Outs'
	    when "Base/Out State" = '001 0' THEN '-- -- 3B 0 Outs'
	    when "Base/Out State" = '110 0' THEN '1B 2B -- 0 Outs'
	    when "Base/Out State" = '101 0' THEN '1B -- 3B 0 Outs'
	    when "Base/Out State" = '011 0' THEN '-- 2B 3B 0 Outs'
	    when "Base/Out State" = '111 0' THEN '1B 2B 3B 0 Outs'
		when "Base/Out State" = '000 1' THEN '-- -- -- 1 Out'
	    when "Base/Out State" = '100 1' THEN '1B -- -- 1 Out'
	    when "Base/Out State" = '010 1' THEN '-- 2B -- 1 Out'
	    when "Base/Out State" = '001 1' THEN '-- -- 3B 1 Out'
	    when "Base/Out State" = '110 1' THEN '1B 2B -- 1 Out'
	    when "Base/Out State" = '101 1' THEN '1B -- 3B 1 Out'
	    when "Base/Out State" = '011 1' THEN '-- 2B 3B 1 Out'
	    when "Base/Out State" = '111 1' THEN '1B 2B 3B 1 Out'
		when "Base/Out State" = '000 2' THEN '-- -- -- 2 Outs'
	    when "Base/Out State" = '100 2' THEN '1B -- -- 2 Outs'
	    when "Base/Out State" = '010 2' THEN '-- 2B -- 2 Outs'
	    when "Base/Out State" = '001 2' THEN '-- -- 3B 2 Outs'
	    when "Base/Out State" = '110 2' THEN '1B 2B -- 2 Outs'
	    when "Base/Out State" = '101 2' THEN '1B -- 3B 2 Outs'
	    when "Base/Out State" = '011 2' THEN '-- 2B 3B 2 Outs'
	    when "Base/Out State" = '111 2' THEN '1B 2B 3B 2 Outs'
	   end as "Base/Out State",
	   "Event", 
	   "N", 
	   "Runs to End of Inning", 
	   "Average Runs"
  from events
),
re as (
  select season,
         "state",
		 event_cd,
		 avg(runs_scored) as runs_scored,
         avg(rv_start) as rv_start,
		 avg(rv_end) as rv_end,
		 avg(run_value) as run_value
  from run_expectancy.full_rv_1912_2024
  group by season, "state", event_cd
),
cleaned_with_re as (
  select cl.*,
		 "Average Runs" - r.rv_start as "Original RE (Avg Runs - Starting RE)",
		 r.runs_scored as "Runs Scored",
         r.rv_start as "Starting RE (overall B/O State)",
		 r.rv_end as "Ending RE (overall B/O State",
		 r.rv_start + r.runs_scored as "Ending RE (Event)",
		 r.run_value as "Run Value"
  from cleaned cl
  left join re r on cl."Season" = r.season and cl."Numeric B/O State" = r."state" and cl.event_cd = r.event_cd
)
select bases_state_order,
       event_cd,
       "Season",
       "Numeric B/O State",
	   "Base/Out State",
	   "Event", 
	   "N", 
	   "Runs to End of Inning", 
	   "Average Runs",
	   "Original RE (Avg Runs - Starting RE)",
	   "Runs Scored",
       "Starting RE (overall B/O State)",
	   "Ending RE (overall B/O State",
	   "Ending RE (Event)",
	   "Run Value"
from cleaned_with_re
order by "Season", bases_state_order;

create table gdp_article_2017_2024.gdp_rv_by_state as
with basis as (
  select *
  from run_expectancy.full_rv_1912_2024
  where inn_ct <= 9.0 and not (inn_ct = 9.0 and bat_home_id = '1') and cast(season as integer) > 2016
),
gdp as (
  select season as "Season",
         bat_team_id as "Batting Team",
         "state" as "Base/Out State",
		 event_cd,
         'GDP' as "Event",
         count(*) as "N",
		 sum(runs_roi) as "Runs to End of Inning",
		 round(avg(runs_roi), 3) as "Average Runs"
  from basis
  where event_tx like '%GDP%'
  group by season, bat_team_id, "state", event_cd
),
events as (
  select "Season", "Batting Team", "Base/Out State", event_cd, "Event", "N", "Runs to End of Inning", "Average Runs"
  from gdp
),
cleaned as (
  select "Season",
       "Batting Team",
       "Base/Out State" as "Numeric B/O State",
	    event_cd,
       case
	    when "Base/Out State" = '000 0' THEN 1
	    when "Base/Out State" = '100 0' THEN 4
	    when "Base/Out State" = '010 0' THEN 7
	    when "Base/Out State" = '001 0' THEN 10
	    when "Base/Out State" = '110 0' THEN 13
	    when "Base/Out State" = '101 0' THEN 16
	    when "Base/Out State" = '011 0' THEN 19
	    when "Base/Out State" = '111 0' THEN 22
		when "Base/Out State" = '000 1' THEN 2
	    when "Base/Out State" = '100 1' THEN 5
	    when "Base/Out State" = '010 1' THEN 8
	    when "Base/Out State" = '001 1' THEN 11
	    when "Base/Out State" = '110 1' THEN 14
	    when "Base/Out State" = '101 1' THEN 17
	    when "Base/Out State" = '011 1' THEN 20
	    when "Base/Out State" = '111 1' THEN 23
		when "Base/Out State" = '000 2' THEN 3
	    when "Base/Out State" = '100 2' THEN 6
	    when "Base/Out State" = '010 2' THEN 9
	    when "Base/Out State" = '001 2' THEN 12
	    when "Base/Out State" = '110 2' THEN 15
	    when "Base/Out State" = '101 2' THEN 18
	    when "Base/Out State" = '011 2' THEN 21
	    when "Base/Out State" = '111 2' THEN 24
	   end as bases_state_order,
	   case
	    when "Base/Out State" = '000 0' THEN '-- -- -- 0 Outs'
	    when "Base/Out State" = '100 0' THEN '1B -- -- 0 Outs'
	    when "Base/Out State" = '010 0' THEN '-- 2B -- 0 Outs'
	    when "Base/Out State" = '001 0' THEN '-- -- 3B 0 Outs'
	    when "Base/Out State" = '110 0' THEN '1B 2B -- 0 Outs'
	    when "Base/Out State" = '101 0' THEN '1B -- 3B 0 Outs'
	    when "Base/Out State" = '011 0' THEN '-- 2B 3B 0 Outs'
	    when "Base/Out State" = '111 0' THEN '1B 2B 3B 0 Outs'
		when "Base/Out State" = '000 1' THEN '-- -- -- 1 Out'
	    when "Base/Out State" = '100 1' THEN '1B -- -- 1 Out'
	    when "Base/Out State" = '010 1' THEN '-- 2B -- 1 Out'
	    when "Base/Out State" = '001 1' THEN '-- -- 3B 1 Out'
	    when "Base/Out State" = '110 1' THEN '1B 2B -- 1 Out'
	    when "Base/Out State" = '101 1' THEN '1B -- 3B 1 Out'
	    when "Base/Out State" = '011 1' THEN '-- 2B 3B 1 Out'
	    when "Base/Out State" = '111 1' THEN '1B 2B 3B 1 Out'
		when "Base/Out State" = '000 2' THEN '-- -- -- 2 Outs'
	    when "Base/Out State" = '100 2' THEN '1B -- -- 2 Outs'
	    when "Base/Out State" = '010 2' THEN '-- 2B -- 2 Outs'
	    when "Base/Out State" = '001 2' THEN '-- -- 3B 2 Outs'
	    when "Base/Out State" = '110 2' THEN '1B 2B -- 2 Outs'
	    when "Base/Out State" = '101 2' THEN '1B -- 3B 2 Outs'
	    when "Base/Out State" = '011 2' THEN '-- 2B 3B 2 Outs'
	    when "Base/Out State" = '111 2' THEN '1B 2B 3B 2 Outs'
	   end as "Base/Out State",
	   "Event", 
	   "N", 
	   "Runs to End of Inning", 
	   "Average Runs"
  from events
),
re as (
  select season,
         "state",
		 event_cd,
		 avg(runs_scored) as runs_scored,
         avg(rv_start) as rv_start,
		 avg(rv_end) as rv_end,
		 avg(run_value) as run_value
  from run_expectancy.full_rv_1912_2024
  group by season, "state", event_cd
),
cleaned_with_re as (
  select cl.*,
		 "Average Runs" - r.rv_start as "Original RE (Avg Runs - Starting RE)",
		 r.runs_scored as "Runs Scored",
         r.rv_start as "Starting RE (overall B/O State)",
		 r.rv_end as "Ending RE (overall B/O State",
		 r.rv_start + r.runs_scored as "Ending RE (Event)",
		 r.run_value as "Run Value"
  from cleaned cl
  left join re r on cl."Season" = r.season and cl."Batting Team" = bat_team_id and cl."Numeric B/O State" = r."state" and cl.event_cd = r.event_cd
)
select bases_state_order,
       event_cd,
       "Season",
       "Batting Team",
       "Numeric B/O State",
	   "Base/Out State",
	   "Event", 
	   "N", 
	   "Runs to End of Inning", 
	   "Average Runs",
	   "Original RE (Avg Runs - Starting RE)",
	   "Runs Scored",
       "Starting RE (overall B/O State)",
	   "Ending RE (overall B/O State",
	   "Ending RE (Event)",
	   "Run Value"
from cleaned_with_re
order by "Season", "Batting Team", bases_state_order;

create table gdp_article_2017_2024.gdps_count_by_season_team as
select season ,
       fr.bat_team_id ,
       count(*) as gdps
from run_expectancy.full_rv_1912_2024 fr 
where fr.event_tx like '%GDP%' and cast(season as integer) > 2016
group by season, fr.bat_team_id 
order by season, count(*) desc;

create table gdp_article_2017_2024.gdps_count_by_season_team_inning as
select season ,
       cast(inn_ct as text) as inn_ct,
       fr.bat_team_id ,
       count(*) as gdps
from run_expectancy.full_rv_1912_2024 fr 
where fr.event_tx like '%GDP%' and cast(season as integer) > 2016
group by season, cast(inn_ct as text), fr.bat_team_id 
order by season, cast(inn_ct as text), count(*) desc;

create table gdp_article_2017_2024.gdps_count_by_season_team_state as
select season ,
       fr.bat_team_id ,
       state ,
       count(*) as gdps
from run_expectancy.full_rv_1912_2024 fr 
where fr.event_tx like '%GDP%' and cast(season as integer) > 2016
group by season, state, fr.bat_team_id 
order by season, state, count(*) desc;

create table gdp_article_2017_2024.gdps_count_by_season_team_state_inning as
select season ,
       cast(inn_ct as text) as inn_ct,
       fr.bat_team_id ,
       state ,
       count(*) as gdps
from run_expectancy.full_rv_1912_2024 fr 
where fr.event_tx like '%GDP%' and cast(season as integer) > 2016
group by season, cast(inn_ct as text), state, fr.bat_team_id 
order by season, cast(inn_ct as text), state, count(*) desc;

create table gdp_article_2017_2024.avg_value_of_out as
select *
from run_expectancy.events_run_value erv 
where erv."Event" = 'Out' and cast("Season" as integer) > 2016;

create table gdp_article_2017_2024.avg_value_of_out_by_base_state as
select *
from run_expectancy.events_rv_by_bo_state erbbs 
where erbbs."Event" = 'Out' and cast("Season" as integer) > 2016;