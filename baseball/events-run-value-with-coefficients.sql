create table run_expectancy.events_seasonal_rv_wcoeff as
with out_rv as (
  select "Season",
         sum("N" * "Run Value") / sum("N") as "Out RV"
  from run_expectancy.events_rv_by_bo_state
  where "Event" = 'Out'
  group by "Season"
),
events_rv as (
  select "Season",
         "Event",
         sum("N" * "Run Value") / sum("N") as "Overall Event RV"
  from run_expectancy.events_rv_by_bo_state
  group by "Season", "Event"
),
final_event_rv as (
  select er.*,
         orv."Out RV",
         er."Overall Event RV" + abs(orv."Out RV") as "Above the Out RV",
         (er."Overall Event RV" + abs(orv."Out RV")) + ((er."Overall Event RV" + abs(orv."Out RV")) * 0.15) as "wOBA Coefficient"
  from events_rv er
  left join out_rv orv on er."Season" = orv."Season"
)
select *
from final_event_rv
order by "Season", "Overall Event RV" desc;