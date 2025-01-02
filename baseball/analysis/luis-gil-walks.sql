create table luis_gil.walks_by_state_inn_count as
select event_cd ,
       state,
       inn_ct ,
       cast(balls_ct as text) || '-' || cast(strikes_ct as text) as strikes_ball_count,
       count(*) as count_event ,
       round(avg(rv_start), 3) as run_value_start,
       round(avg(rv_end), 3) as run_value_end,
       round(avg(rv_end), 3) - round(avg(rv_start), 3) as change_in_rv
from luis_gil.events_2024 e 
where event_cd = '14'
group by event_cd, state, inn_ct, cast(balls_ct as text) || '-' || cast(strikes_ct as text)
order by count(*) desc ;

create table luis_gil.walks_by_state_and_count as
select event_cd ,
       state,
       cast(balls_ct as text) || '-' || cast(strikes_ct as text) as strikes_ball_count,
       count(*) as count_event ,
       round(avg(rv_start), 3) as run_value_start,
       round(avg(rv_end), 3) as run_value_end,
       round(avg(rv_end), 3) - round(avg(rv_start), 3) as change_in_rv
from luis_gil.events_2024 e 
where event_cd = '14'
group by event_cd, state, cast(balls_ct as text) || '-' || cast(strikes_ct as text)
order by count(*) desc ;

create table luis_gil.walks_by_pitch_seq as
select event_cd ,
       pitch_seq_tx ,
       cast(balls_ct as text) || '-' || cast(strikes_ct as text) as strikes_ball_count,
       count(*) as count_event ,
       round(avg(rv_start), 3) as run_value_start,
       round(avg(rv_end), 3) as run_value_end,
       round(avg(rv_end), 3) - round(avg(rv_start), 3) as change_in_rv
from luis_gil.events_2024 e 
where event_cd = '14'
group by event_cd, pitch_seq_tx , cast(balls_ct as text) || '-' || cast(strikes_ct as text)
order by count(*) desc ;

create table luis_gil.walks_by_count as
select event_cd ,
       cast(balls_ct as text) || '-' || cast(strikes_ct as text) as strikes_ball_count,
       count(*) as count_event ,
       round(avg(rv_start), 3) as run_value_start,
       round(avg(rv_end), 3) as run_value_end,
       round(avg(rv_end), 3) - round(avg(rv_start), 3) as change_in_rv
from luis_gil.events_2024 e 
where event_cd = '14'
group by event_cd, cast(balls_ct as text) || '-' || cast(strikes_ct as text)
order by count(*) desc ;

create table luis_gil.walks_with_bases_empty as
select event_cd ,
       state,
       cast(balls_ct as text) || '-' || cast(strikes_ct as text) as strikes_ball_count,
       count(*) as count_event ,
       round(avg(rv_start), 3) as run_value_start,
       round(avg(rv_end), 3) as run_value_end,
       round(avg(rv_end), 3) - round(avg(rv_start), 3) as change_in_rv
from luis_gil.events_2024 e 
where event_cd = '14' and state like '000%'
group by event_cd, state, cast(balls_ct as text) || '-' || cast(strikes_ct as text)
order by count(*) desc ;