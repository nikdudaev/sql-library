--By using the filter() function from the dplyr package, we focus on plays where there is a change in the state or in the number of runs scored. 
--By another application of filter(), we restrict attention to complete innings where there are three outs and where there is a batting event; 
--the new dataset is called retro2016_complete. Here non-batting plays such as steals, caught stealing, wild pitches, and passed balls are ignored. 
--There is obviously some consequence of removing these non-batting plays from the viewpoint of run production, and this issue is discussed later in this chapter.
--In our definition of the new_state variable, we recorded the runner locations when there were three outs. 
--The runner locations don’t matter, so we recode new_state to always have the value 3 when the number of outs is equal to 3. 
--The str_replace() function replaces the regular expression [0-1]{3} 3—which matches any three character binary string followed by a space and a 3—with 3.
create table simulations.full_transition_matrix_2016 as
with retro2016 as (
  select *,
         case 
         	when new_state like '% 3' then '3'
            else new_state
         end as new_state_mod
  from run_expectancy.full_rv_1912_2023 fr 
  where season = '2016' and 
        (state != new_state or runs_scored > 0) and 
        (outs_inning = 3 and bat_event_fl = 'T')
),
--Computing transition matrix
init_transitions as (
  select state,
         new_state_mod as new_state,
         count(*) as n_transitions
  from retro2016 
  group by state, new_state_mod
),
long_transitions as (
   select state,
       max(case when new_state = '000 0' then n_transitions else 0 end) as "000 0",
       max(case when new_state = '000 1' then n_transitions else 0 end) as "000 1",
       max(case when new_state = '000 2' then n_transitions else 0 end) as "000 2",
       max(case when new_state = '100 0' then n_transitions else 0 end) as "100 0",
       max(case when new_state = '100 1' then n_transitions else 0 end) as "100 1",
       max(case when new_state = '100 2' then n_transitions else 0 end) as "100 2",
       max(case when new_state = '010 0' then n_transitions else 0 end) as "010 0",
       max(case when new_state = '010 1' then n_transitions else 0 end) as "010 1",
       max(case when new_state = '010 2' then n_transitions else 0 end) as "010 2",
       max(case when new_state = '001 0' then n_transitions else 0 end) as "001 0",
       max(case when new_state = '001 1' then n_transitions else 0 end) as "001 1",
       max(case when new_state = '001 2' then n_transitions else 0 end) as "001 2",
       max(case when new_state = '110 0' then n_transitions else 0 end) as "110 0",
       max(case when new_state = '110 1' then n_transitions else 0 end) as "110 1",
       max(case when new_state = '110 2' then n_transitions else 0 end) as "110 2",
       max(case when new_state = '101 0' then n_transitions else 0 end) as "101 0",
       max(case when new_state = '101 1' then n_transitions else 0 end) as "101 1",
       max(case when new_state = '101 2' then n_transitions else 0 end) as "101 2",
       max(case when new_state = '011 0' then n_transitions else 0 end) as "011 0",
       max(case when new_state = '011 1' then n_transitions else 0 end) as "011 1",
       max(case when new_state = '011 2' then n_transitions else 0 end) as "011 2",
       max(case when new_state = '111 0' then n_transitions else 0 end) as "111 0",
       max(case when new_state = '111 1' then n_transitions else 0 end) as "111 1",
       max(case when new_state = '111 2' then n_transitions else 0 end) as "111 2",
       max(case when new_state = '3' then n_transitions else 0 end) as "3"
from init_transitions
group by state
),
total_transitions as (
  select *,
       "000 0" + "000 1" + "000 2" + "100 0" + "100 1" + "100 2" + "010 0" + "010 1" + "010 2" + 
       "001 0" + "001 1" + "001 2" + "110 0" + "110 1" + "110 2" + "101 0" + "101 1" + 
       "101 2" + "011 0" + "011 1" + "011 2" + "111 0" + "111 1" + "111 2" + "3" as total_state_transitions
  from long_transitions
  ),
final_probabilities as (
  select state,
         total_state_transitions,
         "000 0",
         "000 1",
         "000 2",
         "100 0",
         "100 1",
         "100 2",
         "010 0",
         "010 1",
         "010 2", 
         "001 0",
         "001 1",
         "001 2",
         "110 0",
         "110 1",
         "110 2",
         "101 0",
         "101 1", 
         "101 2",
         "011 0",
         "011 1",
         "011 2",
         "111 0",
         "111 1",
         "111 2",
         "3",
         cast("000 0" as numeric) / cast(total_state_transitions as numeric) as "Pct 000 0",
         cast("000 1" as numeric) / cast(total_state_transitions as numeric) as "Pct 000 1",
         cast("000 2" as numeric) / cast(total_state_transitions as numeric) as "Pct 000 2",
         cast("100 0" as numeric) / cast(total_state_transitions as numeric) as "Pct 100 0",
         cast("100 1" as numeric) / cast(total_state_transitions as numeric) as "Pct 100 1",
         cast("100 2" as numeric) / cast(total_state_transitions as numeric) as "Pct 100 2",
         cast("010 0" as numeric) / cast(total_state_transitions as numeric) as "Pct 010 0",
         cast("010 1" as numeric) / cast(total_state_transitions as numeric) as "Pct 010 1",
         cast("010 2" as numeric) / cast(total_state_transitions as numeric) as "Pct 010 2", 
         cast("001 0" as numeric) / cast(total_state_transitions as numeric) as "Pct 001 0",
         cast("001 1" as numeric) / cast(total_state_transitions as numeric) as "Pct 001 1",
         cast("001 2" as numeric) / cast(total_state_transitions as numeric) as "Pct 001 2",
         cast("110 0" as numeric) / cast(total_state_transitions as numeric) as "Pct 110 0",
         cast("110 1" as numeric) / cast(total_state_transitions as numeric) as "Pct 110 1",
         cast("110 2" as numeric) / cast(total_state_transitions as numeric) as "Pct 110 2",
         cast("101 0" as numeric) / cast(total_state_transitions as numeric) as "Pct 101 0",
         cast("101 1" as numeric) / cast(total_state_transitions as numeric) as "Pct 101 1", 
         cast("101 2" as numeric) / cast(total_state_transitions as numeric) as "Pct 101 2",
         cast("011 0" as numeric) / cast(total_state_transitions as numeric) as "Pct 011 0",
         cast("011 1" as numeric) / cast(total_state_transitions as numeric) as "Pct 011 1",
         cast("011 2" as numeric) / cast(total_state_transitions as numeric) as "Pct 011 2",
         cast("111 0" as numeric) / cast(total_state_transitions as numeric) as "Pct 111 0",
         cast("111 1" as numeric) / cast(total_state_transitions as numeric) as "Pct 111 1",
         cast("111 2" as numeric) / cast(total_state_transitions as numeric) as "Pct 111 2",
         cast("3" as numeric) / cast(total_state_transitions as numeric) as "Pct 3"
  from total_transitions
  )
select *
from final_probabilities
union all
select *
from run_expectancy.state_3_outs so ;

create table simulations.prob_matrix_2016 as
select state,
       "Pct 000 0",
       "Pct 000 1",
       "Pct 000 2",
       "Pct 100 0",
       "Pct 100 1",
       "Pct 100 2",
       "Pct 010 0",
       "Pct 010 1",
       "Pct 010 2", 
       "Pct 001 0",
       "Pct 001 1",
       "Pct 001 2",
       "Pct 110 0",
       "Pct 110 1",
       "Pct 110 2",
        "Pct 101 0",
       "Pct 101 1", 
       "Pct 101 2",
       "Pct 011 0",
       "Pct 011 1",
       "Pct 011 2",
        "Pct 111 0",
        "Pct 111 1",
        "Pct 111 2",
        "Pct 3"
from simulations.full_transition_matrix_2016 ftm ;

create table simulations.runs_matrix_2016 as
with runs_before as (
  select distinct state,
         cast(substring(state from 1 for 1) as integer) +
         cast(substring(state from 2 for 1) as integer) +
         cast(substring(state from 3 for 1) as integer) +
         cast(substring(state from 5 for 1) as integer) + 1 as runs_before
  from run_expectancy.full_rv_1912_2023 fr 
  where season = '2016' and 
        (state != new_state or runs_scored > 0) and 
        (outs_inning = 3 and bat_event_fl = 'T')
),
runs_after as (
  select distinct new_state,
         cast(substring(new_state from 1 for 1) as integer) +
         cast(substring(new_state from 2 for 1) as integer) +
         cast(substring(new_state from 3 for 1) as integer) +
         cast(substring(new_state from 5 for 1) as integer) as runs_after
  from run_expectancy.full_rv_1912_2023 fr 
  where season = '2016' and 
        (state != new_state or runs_scored > 0) and 
        (outs_inning = 3 and bat_event_fl = 'T')
),
runs as (
  select rb.*,
         ra.*
  from runs_before rb
  cross join runs_after ra
)
select state,
       max(case when new_state = '000 0' then runs_before - runs_after else 0 end) as "000 0",
max(case when new_state = '000 1' then runs_before - runs_after else 0 end) as "000 1",
max(case when new_state = '000 2' then runs_before - runs_after else 0 end) as "000 2",
max(case when new_state = '100 0' then runs_before - runs_after else 0 end) as "100 0",
max(case when new_state = '100 1' then runs_before - runs_after else 0 end) as "100 1",
max(case when new_state = '100 2' then runs_before - runs_after else 0 end) as "100 2",
max(case when new_state = '010 0' then runs_before - runs_after else 0 end) as "010 0",
max(case when new_state = '010 1' then runs_before - runs_after else 0 end) as "010 1",
max(case when new_state = '010 2' then runs_before - runs_after else 0 end) as "010 2",
max(case when new_state = '001 0' then runs_before - runs_after else 0 end) as "001 0",
max(case when new_state = '001 1' then runs_before - runs_after else 0 end) as "001 1",
max(case when new_state = '001 2' then runs_before - runs_after else 0 end) as "001 2",
max(case when new_state = '110 0' then runs_before - runs_after else 0 end) as "110 0",
max(case when new_state = '110 1' then runs_before - runs_after else 0 end) as "110 1",
max(case when new_state = '110 2' then runs_before - runs_after else 0 end) as "110 2",
max(case when new_state = '101 0' then runs_before - runs_after else 0 end) as "101 0",
max(case when new_state = '101 1' then runs_before - runs_after else 0 end) as "101 1",
max(case when new_state = '101 2' then runs_before - runs_after else 0 end) as "101 2",
max(case when new_state = '011 0' then runs_before - runs_after else 0 end) as "011 0",
max(case when new_state = '011 1' then runs_before - runs_after else 0 end) as "011 1",
max(case when new_state = '011 2' then runs_before - runs_after else 0 end) as "011 2",
max(case when new_state = '111 0' then runs_before - runs_after else 0 end) as "111 0",
max(case when new_state = '111 1' then runs_before - runs_after else 0 end) as "111 1",
max(case when new_state = '111 2' then runs_before - runs_after else 0 end) as "111 2",
0 as "3"
from runs
group by state;