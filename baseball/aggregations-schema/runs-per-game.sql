-- The Aggregation schema contains most used ready-made aggregations that can be used easily

-- Runs per Game
create table aggregations.runs_per_game as
select season,
       count(distinct game_id) * 2 as total_games,
       sum(runs_scored) as runs_scored,
       round(cast(sum(runs_scored) as numeric) / (cast(count(distinct game_id) * 2 as numeric)),2) as runs_per_game
from run_expectancy.full_rv_1912_2024 fr 
group by season;