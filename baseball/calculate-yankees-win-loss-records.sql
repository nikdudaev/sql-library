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
)
select season,
       game_number,
       game_date,
       opponent,
       sum(win) over (partition by season order by game_date, game_number) as wins,
       sum(loss) over (partition by season order by game_date, game_number) as losses,
       cast(sum(win) over (partition by season order by game_date, game_number) as numeric) / cast(game_number as numeric) as winning_pct
from wins_losses;