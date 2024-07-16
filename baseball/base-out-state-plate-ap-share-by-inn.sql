with pa_s_inn_bo as (
  select season,
         inn_ct,
         base_out_state,
         sum(pa_s) as pa_s
  from re_batting.batting_stats_per_inning_base_out_state bspibos
  group by season, inn_ct, base_out_state
  order by season, inn_ct, base_out_state
),
total_pa_inn as (
  select season,
         inn_ct,
         sum(pa_s) as total_pa_s
  from re_batting.batting_stats_per_inning_base_out_state bspibos 
  group by season, inn_ct
  order by season, inn_ct
),
combined as (
  select psib.*,
         tpi.total_pa_s,
         round(psib.pa_s / tpi.total_pa_s * 100, 2) as bo_state_pa_pct
  from pa_s_inn_bo psib
  left join total_pa_inn tpi on psib.season = tpi.season and psib.inn_ct = tpi.inn_ct
)
select season,
       inn_ct,
       max(case when base_out_state = '000 0' then bo_state_pa_pct else 0 end) as "-- -- -- 0 outs",
       max(case when base_out_state = '000 1' then bo_state_pa_pct else 0 end) as "-- -- -- 1 outs",
       max(case when base_out_state = '000 2' then bo_state_pa_pct else 0 end) as "-- -- -- 2 outs",
       max(case when base_out_state = '001 0' then bo_state_pa_pct else 0 end) as "-- -- 3B 0 outs",
       max(case when base_out_state = '001 1' then bo_state_pa_pct else 0 end) as "-- -- 3B 1 outs",
       max(case when base_out_state = '001 2' then bo_state_pa_pct else 0 end) as "-- -- 3B 2 outs",
       max(case when base_out_state = '010 0' then bo_state_pa_pct else 0 end) as "-- 2B -- 0 outs",
       max(case when base_out_state = '010 1' then bo_state_pa_pct else 0 end) as "-- 2B -- 1 outs",
       max(case when base_out_state = '010 2' then bo_state_pa_pct else 0 end) as "-- 2B -- 2 outs",
       max(case when base_out_state = '011 0' then bo_state_pa_pct else 0 end) as "-- 2B 3B 0 outs",
       max(case when base_out_state = '011 1' then bo_state_pa_pct else 0 end) as "-- 2B 3B 1 outs",
       max(case when base_out_state = '011 2' then bo_state_pa_pct else 0 end) as "-- 2B 3B 2 outs",
       max(case when base_out_state = '100 0' then bo_state_pa_pct else 0 end) as "1B -- -- 0 outs",
       max(case when base_out_state = '100 1' then bo_state_pa_pct else 0 end) as "1B -- -- 1 outs",
       max(case when base_out_state = '100 2' then bo_state_pa_pct else 0 end) as "1B -- -- 2 outs",
       max(case when base_out_state = '101 0' then bo_state_pa_pct else 0 end) as "1B -- 3B 0 outs",
       max(case when base_out_state = '101 1' then bo_state_pa_pct else 0 end) as "1B -- 3B 1 outs",
       max(case when base_out_state = '101 2' then bo_state_pa_pct else 0 end) as "1B -- 3B 2 outs",
       max(case when base_out_state = '110 0' then bo_state_pa_pct else 0 end) as "1B 2B -- 0 outs",
       max(case when base_out_state = '110 1' then bo_state_pa_pct else 0 end) as "1B 2B -- 1 outs",
       max(case when base_out_state = '110 2' then bo_state_pa_pct else 0 end) as "1B 2B -- 2 outs",
       max(case when base_out_state = '111 0' then bo_state_pa_pct else 0 end) as "1B 2B 3B 0 outs",
       max(case when base_out_state = '111 1' then bo_state_pa_pct else 0 end) as "1B 2B 3B 1 outs",
       max(case when base_out_state = '111 2' then bo_state_pa_pct else 0 end) as "1B 2B 3B 2 outs"
from combined
group by season, inn_ct;

alter table re_batting.batting_stats_per_inning_base_out_state
add column "Base/Out Situation" text;

update re_batting.batting_stats_per_inning_base_out_state
set "Base/Out Situation" = case 
  when base_out_state_tx = '-- -- -- 0 outs' then 'Bases Empty'
  when base_out_state_tx = '-- -- -- 1 outs' then 'Bases Empty'
  when base_out_state_tx = '-- -- -- 2 outs' then 'Bases Empty'
  when base_out_state_tx = '-- -- 3B 0 outs' then 'RISP (excl. Bases Loaded)'
  when base_out_state_tx = '-- -- 3B 1 outs' then 'RISP (excl. Bases Loaded)'
  when base_out_state_tx = '-- -- 3B 2 outs' then 'RISP (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B -- 0 outs' then 'RISP (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B -- 1 outs' then 'RISP (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B -- 2 outs' then 'RISP (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B 3B 0 outs' then 'RISP (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B 3B 1 outs' then 'RISP (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B 3B 2 outs' then 'RISP (excl. Bases Loaded)'
  when base_out_state_tx = '1B -- -- 0 outs' then 'Runner on 1B'
  when base_out_state_tx = '1B -- -- 1 outs' then 'Runner on 1B'
  when base_out_state_tx = '1B -- -- 2 outs' then 'Runner on 1B'
  when base_out_state_tx = '1B -- 3B 0 outs' then 'RISP (excl. Bases Loaded)'
  when base_out_state_tx = '1B -- 3B 1 outs' then 'RISP (excl. Bases Loaded)'
  when base_out_state_tx = '1B -- 3B 2 outs' then 'RISP (excl. Bases Loaded)'
  when base_out_state_tx = '1B 2B -- 0 outs' then 'RISP (excl. Bases Loaded)'
  when base_out_state_tx = '1B 2B -- 1 outs' then 'RISP (excl. Bases Loaded)'
  when base_out_state_tx = '1B 2B -- 2 outs' then 'RISP (excl. Bases Loaded)'
  when base_out_state_tx = '1B 2B 3B 0 outs' then 'Bases Loaded'
  when base_out_state_tx = '1B 2B 3B 1 outs' then 'Bases Loaded'
  when base_out_state_tx = '1B 2B 3B 2 outs' then 'Bases Loaded'
end;

alter table re_batting.batting_stats_per_inning_base_out_state
rename column "Base/Out Situation" to "Base Situation";

alter table re_batting.batting_stats_per_inning_base_out_state
add column "Base Situation w/Outs" text,
add column "Threat Level" text;

update re_batting.batting_stats_per_inning_base_out_state
set "Base Situation w/Outs" = case 
  when base_out_state_tx = '-- -- -- 0 outs' then 'Bases Empty w/less than 2 Outs'
  when base_out_state_tx = '-- -- -- 1 outs' then 'Bases Empty w/less than 2 Outs'
  when base_out_state_tx = '-- -- -- 2 outs' then 'Bases Empty, 2 Outs'
  when base_out_state_tx = '-- -- 3B 0 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '-- -- 3B 1 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '-- -- 3B 2 outs' then 'RISP, 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B -- 0 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B -- 1 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B -- 2 outs' then 'RISP, 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B 3B 0 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B 3B 1 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B 3B 2 outs' then 'RISP, 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '1B -- -- 0 outs' then 'Runner on 1B w/less than 2 Outs'
  when base_out_state_tx = '1B -- -- 1 outs' then 'Runner on 1B w/less than 2 Outs'
  when base_out_state_tx = '1B -- -- 2 outs' then 'Runner on 1B, 2 Outs'
  when base_out_state_tx = '1B -- 3B 0 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '1B -- 3B 1 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '1B -- 3B 2 outs' then 'RISP, 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '1B 2B -- 0 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '1B 2B -- 1 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '1B 2B -- 2 outs' then 'RISP, 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '1B 2B 3B 0 outs' then 'Bases Loaded w/less than 2 Outs'
  when base_out_state_tx = '1B 2B 3B 1 outs' then 'Bases Loaded w/less than 2 Outs'
  when base_out_state_tx = '1B 2B 3B 2 outs' then 'Bases Loaded, 2 Outs'
end;

update re_batting.batting_stats_per_inning_base_out_state
set "Threat Level" = case 
  when base_out_state_tx = '-- -- -- 0 outs' then 'No threat'
  when base_out_state_tx = '-- -- -- 1 outs' then '0'
  when base_out_state_tx = '-- -- -- 2 outs' then '0'
  when base_out_state_tx = '-- -- 3B 0 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '-- -- 3B 1 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '-- -- 3B 2 outs' then 'RISP, 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B -- 0 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B -- 1 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B -- 2 outs' then 'RISP, 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B 3B 0 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B 3B 1 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '-- 2B 3B 2 outs' then 'RISP, 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '1B -- -- 0 outs' then 'Very Low'
  when base_out_state_tx = '1B -- -- 1 outs' then 'Very Low'
  when base_out_state_tx = '1B -- -- 2 outs' then 'Very Low'
  when base_out_state_tx = '1B -- 3B 0 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '1B -- 3B 1 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '1B -- 3B 2 outs' then 'RISP, 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '1B 2B -- 0 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '1B 2B -- 1 outs' then 'RISP w/less than 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '1B 2B -- 2 outs' then 'RISP, 2 Outs (excl. Bases Loaded)'
  when base_out_state_tx = '1B 2B 3B 0 outs' then 'Bases Loaded w/less than 2 Outs'
  when base_out_state_tx = '1B 2B 3B 1 outs' then 'Bases Loaded w/less than 2 Outs'
  when base_out_state_tx = '1B 2B 3B 2 outs' then 'Bases Loaded, 2 Outs'
end;