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
       max(case when base_out_state = '000 0' then bo_state_pa_pct else 0 end) as "000 0",
       max(case when base_out_state = '000 1' then bo_state_pa_pct else 0 end) as "000 1",
       max(case when base_out_state = '000 2' then bo_state_pa_pct else 0 end) as "000 2",
       max(case when base_out_state = '001 0' then bo_state_pa_pct else 0 end) as "001 0",
       max(case when base_out_state = '001 1' then bo_state_pa_pct else 0 end) as "001 1",
       max(case when base_out_state = '001 2' then bo_state_pa_pct else 0 end) as "001 2",
       max(case when base_out_state = '010 0' then bo_state_pa_pct else 0 end) as "010 0",
       max(case when base_out_state = '010 1' then bo_state_pa_pct else 0 end) as "010 1",
       max(case when base_out_state = '010 2' then bo_state_pa_pct else 0 end) as "010 2",
       max(case when base_out_state = '011 0' then bo_state_pa_pct else 0 end) as "011 0",
       max(case when base_out_state = '011 1' then bo_state_pa_pct else 0 end) as "011 1",
       max(case when base_out_state = '011 2' then bo_state_pa_pct else 0 end) as "011 2",
       max(case when base_out_state = '100 0' then bo_state_pa_pct else 0 end) as "100 0",
       max(case when base_out_state = '100 1' then bo_state_pa_pct else 0 end) as "100 1",
       max(case when base_out_state = '100 2' then bo_state_pa_pct else 0 end) as "100 2",
       max(case when base_out_state = '101 0' then bo_state_pa_pct else 0 end) as "101 0",
       max(case when base_out_state = '101 1' then bo_state_pa_pct else 0 end) as "101 1",
       max(case when base_out_state = '101 2' then bo_state_pa_pct else 0 end) as "101 2",
       max(case when base_out_state = '110 0' then bo_state_pa_pct else 0 end) as "110 0",
       max(case when base_out_state = '110 1' then bo_state_pa_pct else 0 end) as "110 1",
       max(case when base_out_state = '110 2' then bo_state_pa_pct else 0 end) as "110 2",
       max(case when base_out_state = '111 0' then bo_state_pa_pct else 0 end) as "111 0",
       max(case when base_out_state = '111 1' then bo_state_pa_pct else 0 end) as "111 1",
       max(case when base_out_state = '111 2' then bo_state_pa_pct else 0 end) as "111 2"

from combined
group by season, inn_ct;