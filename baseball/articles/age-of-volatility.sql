-- Runs per Game
create table age_of_volatility.runs_per_game as
select rpg.season as "Season",
       rpg.runs_per_game as "Runs per Game"
from aggregations.runs_per_game rpg 
where cast(season as integer) >= 2003;
====================================================================
-- Singles, Doubles, Triples Flyballs shares of non-HR Flyballs
create table age_of_volatility.flyballs_to_of_shares as
with ball_types_totals as (
select bbtt.season,
       bbtt.flyballs_excl_hr,
       bbtt.linedrives_excl_hr 
from aggregations.batted_ball_types_totals bbtt 
where cast(bbtt.season as integer) >= 2003
),
flyball_stats as (
select fs2.season ,
       fs2.flyballs_singles_to_of ,
       fs2.flyballs_doubles_to_of ,
       fs2.flyballs_triples_to_of 
from aggregations.flyballs_stats fs2 
where cast(fs2.season as integer) >= 2003
),
singles as (
select bbtt.season as "Season",
       'Singles to OF' as "Hit and Location Type",
       round(cast(fs2.flyballs_singles_to_of as numeric) / cast(bbtt.flyballs_excl_hr as numeric), 6) as "% of non-HR"
from ball_types_totals bbtt
left join flyball_stats fs2
on bbtt.season = fs2.season
),
doubles as (
select bbtt.season as "Season",
       'Doubles to OF' as "Hit and Location Type",
       round(cast(fs2.flyballs_doubles_to_of as numeric) / cast(bbtt.flyballs_excl_hr as numeric), 6) as "% of non-HR"
from ball_types_totals bbtt
left join flyball_stats fs2
on bbtt.season = fs2.season
),
triples as (
select bbtt.season as "Season",
       'Triples to OF' as "Hit and Location Type",
       round(cast(fs2.flyballs_triples_to_of as numeric) / cast(bbtt.flyballs_excl_hr as numeric), 6) as "% of non-HR"
from ball_types_totals bbtt
left join flyball_stats fs2
on bbtt.season = fs2.season
),
final_tbl as (
select *
from singles
union all
select *
from doubles
union all
select *
from triples
)
select *
from final_tbl;
====================================================================
-- Singles, Doubles, Triples Linedrives shares of non-HR Linedrives
create table age_of_volatility.linedrives_to_of_shares as
with ball_types_totals as (
select bbtt.season,
       bbtt.linedrives_excl_hr 
from aggregations.batted_ball_types_totals bbtt 
where cast(bbtt.season as integer) >= 2003
),
linedrive_stats as (
select fs2.season ,
       fs2.linedrives_singles_to_of ,
       fs2.linedrives_doubles_to_of ,
       fs2.linedrives_triples_to_of 
from aggregations.linedrives_stats fs2 
where cast(fs2.season as integer) >= 2003
),
singles as (
select bbtt.season as "Season",
       'Singles to OF' as "Hit and Location Type",
       round(cast(fs2.linedrives_singles_to_of as numeric) / cast(bbtt.linedrives_excl_hr as numeric), 6) as "% of non-HR"
from ball_types_totals bbtt
left join linedrive_stats fs2
on bbtt.season = fs2.season
),
doubles as (
select bbtt.season as "Season",
       'Doubles to OF' as "Hit and Location Type",
       round(cast(fs2.linedrives_doubles_to_of as numeric) / cast(bbtt.linedrives_excl_hr as numeric), 6) as "% of non-HR"
from ball_types_totals bbtt
left join linedrive_stats fs2
on bbtt.season = fs2.season
),
triples as (
select bbtt.season as "Season",
       'Triples to OF' as "Hit and Location Type",
       round(cast(fs2.linedrives_triples_to_of as numeric) / cast(bbtt.linedrives_excl_hr as numeric), 6) as "% of non-HR"
from ball_types_totals bbtt
left join linedrive_stats fs2
on bbtt.season = fs2.season
),
final_tbl as (
select *
from singles
union all
select *
from doubles
union all
select *
from triples
)
select *
from final_tbl;
====================================================================
-- Singles, Doubles, Triples Flyballs Run Value of non-HR Flyballs + Outs Run Value
create table age_of_volatility.flyballs_to_of_run_value as
with outs_rv as (
select erv.season,
       erv.outs_rv 
from aggregations.events_run_value erv
where cast(erv.season as integer) >= 2003
),
flyball_stats as (
select fs2.season ,
       fs2.flyballs_singles_to_of_rv ,
       fs2.flyballs_doubles_to_of_rv ,
       fs2.flyballs_triples_to_of_rv 
from aggregations.flyballs_stats fs2 
where cast(fs2.season as integer) >= 2003
),
singles as (
select erv.season as "Season",
       'Singles to OF' as "Hit and Location Type",
       round(fs2.flyballs_singles_to_of_rv, 3) as "Run Value",
       round(erv.outs_rv, 3) as "Out Run Value",
       round(fs2.flyballs_singles_to_of_rv, 3) - round(erv.outs_rv, 3) as "Lost Run Value"
from outs_rv erv
left join flyball_stats fs2
on erv.season = fs2.season
),
doubles as (
select erv.season as "Season",
       'Doubles to OF' as "Hit and Location Type",
       round(fs2.flyballs_doubles_to_of_rv, 3) as "Run Value",
       round(erv.outs_rv, 3) as "Out Run Value",
       round(fs2.flyballs_doubles_to_of_rv, 3) - round(erv.outs_rv, 3) as "Lost Run Value"
from outs_rv erv
left join flyball_stats fs2
on erv.season = fs2.season
),
triples as (
select erv.season as "Season",
       'Triples to OF' as "Hit and Location Type",
       round(fs2.flyballs_triples_to_of_rv, 3) as "Run Value",
       round(erv.outs_rv, 3) as "Out Run Value",
       round(fs2.flyballs_triples_to_of_rv, 3) - round(erv.outs_rv, 3) as "Lost Run Value"
from outs_rv erv
left join flyball_stats fs2
on erv.season = fs2.season
),
final_tbl as (
select *
from singles
union all
select *
from doubles
union all
select *
from triples
)
select *
from final_tbl;
====================================================================
-- Singles, Doubles, Triples Linedrives Run Value of non-HR Linedrives + Outs Run Value
create table age_of_volatility.linedrives_to_of_run_value as
with outs_rv as (
select erv.season,
       erv.outs_rv 
from aggregations.events_run_value erv
where cast(erv.season as integer) >= 2003
),
linedrives_stats as (
select fs2.season ,
       fs2.linedrives_singles_to_of_rv ,
       fs2.linedrives_doubles_to_of_rv ,
       fs2.linedrives_triples_to_of_rv 
from aggregations.linedrives_stats fs2 
where cast(fs2.season as integer) >= 2003
),
singles as (
select erv.season as "Season",
       'Singles to OF' as "Hit and Location Type",
       round(fs2.linedrives_singles_to_of_rv, 3) as "Run Value",
       round(erv.outs_rv, 3) as "Out Run Value",
       round(fs2.linedrives_singles_to_of_rv, 3) - round(erv.outs_rv, 3) as "Lost Run Value"
from outs_rv erv
left join linedrives_stats fs2
on erv.season = fs2.season
),
doubles as (
select erv.season as "Season",
       'Doubles to OF' as "Hit and Location Type",
       round(fs2.linedrives_doubles_to_of_rv, 3) as "Run Value",
       round(erv.outs_rv, 3) as "Out Run Value",
       round(fs2.linedrives_doubles_to_of_rv, 3) - round(erv.outs_rv, 3) as "Lost Run Value"
from outs_rv erv
left join linedrives_stats fs2
on erv.season = fs2.season
),
triples as (
select erv.season as "Season",
       'Triples to OF' as "Hit and Location Type",
       round(fs2.linedrives_triples_to_of_rv, 3) as "Run Value",
       round(erv.outs_rv, 3) as "Out Run Value",
       round(fs2.linedrives_triples_to_of_rv, 3) - round(erv.outs_rv, 3) as "Lost Run Value"
from outs_rv erv
left join linedrives_stats fs2
on erv.season = fs2.season
),
final_tbl as (
select *
from singles
union all
select *
from doubles
union all
select *
from triples
)
select *
from final_tbl;
====================================================================
-- Flyballs per Game, total and to OF
create table age_of_volatility.flyballs_per_game as
with total_games as (
select rpg.season,
       rpg.total_games
from aggregations.runs_per_game rpg 
where cast(season as integer) >= 2003
),
ball_types_totals as (
select bbtt.season,
       bbtt.flyballs_total,
       bbtt.flyballs_of
from aggregations.batted_ball_types_totals bbtt 
where cast(bbtt.season as integer) >= 2003
),
final_tbl as (
select tg.season as "Season",
       round(cast(btt.flyballs_total as numeric) / cast(tg.total_games as numeric), 1) as "Flyballs per Game",
       round(cast(btt.flyballs_of as numeric) / cast(tg.total_games as numeric), 1) as "Flyballs to OF per Game"
from total_games tg
left join ball_types_totals btt
on tg.season = btt.season
)
select *
from final_tbl;
====================================================================
-- Linedrives per Game, total and to OF
create table age_of_volatility.linedrives_per_game as
with total_games as (
select rpg.season,
       rpg.total_games
from aggregations.runs_per_game rpg 
where cast(season as integer) >= 2003
),
ball_types_totals as (
select bbtt.season,
       bbtt.linedrives_total,
       bbtt.linedrives_of
from aggregations.batted_ball_types_totals bbtt 
where cast(bbtt.season as integer) >= 2003
),
final_tbl as (
select tg.season as "Season",
       round(cast(btt.linedrives_total as numeric) / cast(tg.total_games as numeric), 1) as "Linedrives per Game",
       round(cast(btt.linedrives_of as numeric) / cast(tg.total_games as numeric), 1) as "Linedrives to OF per Game"
from total_games tg
left join ball_types_totals btt
on tg.season = btt.season
)
select *
from final_tbl;
====================================================================
-- Run Value by Ball Type
select *
from aggregations.ball_type_run_values btrv ;
====================================================================
-- HR rate out of Flyballs
====================================================================
-- HR rate out of Linedrives
====================================================================
-- HR Run Values
====================================================================
-- HR Run Values on Flyballs, Flyballs Run Value on non-HR
====================================================================
-- HR Run Values on Linedrives, Linedrives Run Value on non-HR
====================================================================
