create table yankees.win_loss_records as
with wins_losses as (
  select season,
       row_number() over (partition by season order by game_date) as game_number,
       game_id,
       game_date,
       away_team_id,
       home_team_id,
       away_score_ct,
       home_score_ct,
       case 
       	when not away_team_id = 'NYA' then away_team_id
       	when not home_team_id = 'NYA' then home_team_id
       end as opponent,
       case
       	when winner = 'NYA' then 1
       	else 0
       end as win,
       case
       	when loser = 'NYA' then 1
       	else 0
       end as loss
  from retrosheet.game_logs gl 
  where (away_team_id = 'NYA' or home_team_id = 'NYA')
  order by game_date
),
basic_calculations as (
  select season,
         game_number,
         game_date,
         opponent,
         sum(win) over (partition by season order by game_date, game_number) as wins,
         sum(loss) over (partition by season order by game_date, game_number) as losses,
         cast(sum(win) over (partition by season order by game_date, game_number) as numeric) / cast(game_number as numeric) as winning_pct
  from wins_losses
)
select *,
       avg(winning_pct) over (
          partition by season 
          order by game_number 
          rows between 10 preceding and current row
       ) as moving_winning_pct,
       avg(losses) over (
          partition by season 
          order by game_number 
          rows between 10 preceding and current row
       ) as moving_losses_avg,
       avg(wins) over (
          partition by season 
          order by game_number 
          rows between 10 preceding and current row
       ) as moving_wins_avg,
       case
       	when lag(winning_pct) over (partition by season order by game_number) = 0 then null
       	else (winning_pct - 
         lag(winning_pct) over (partition by season order by game_number)) /
         lag(winning_pct) over (partition by season order by game_number)
       end as winning_pct_rate_change,
       case
       	when lag(cast(wins as numeric)) over (partition by season order by game_number) = 0 then null
       	else (cast(wins as numeric) - 
         lag(cast(wins as numeric)) over (partition by season order by game_number)) /
         lag(cast(wins as numeric)) over (partition by season order by game_number)
       end as wins_pct_rate_change,
       case
       	when lag(cast(losses as numeric)) over (partition by season order by game_number) = 0 then null
       	else (cast(losses as numeric) - 
         lag(cast(losses as numeric)) over (partition by season order by game_number)) /
         lag(cast(losses as numeric)) over (partition by season order by game_number)
       end as losses_pct_rate_change
from basic_calculations;