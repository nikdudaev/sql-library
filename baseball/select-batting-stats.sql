-- Events
SELECT season,
       inn_ct,
	   base_out_state,
	   base_out_state_tx,
	   base_situation,
	   base_situation_with_outs,
	   event_runs_scored,
	   pa_s,
	   at_bats,
	   hits,
	   walks,
	   hit_by_pitch,
	   sac_fly,
	   singles,
	   doubles,
	   triples,
	   homeruns,
	   strikeouts
FROM re_batting.batting_stats_per_inning_base_out_state
order by season, inn_ct, base_out_state;
-- Batted balls
SELECT season,
       inn_ct,
	   base_out_state,
	   base_out_state_tx,
	   base_situation,
	   base_situation_with_outs,
	   event_runs_scored,
	   pa_s,
	   at_bats,
	   flyballs,
	   groundballs,
	   linedrives,
	   popups
FROM re_batting.batting_stats_per_inning_base_out_state
order by season, inn_ct, base_out_state;
-- Batting stats
SELECT season,
       inn_ct,
	   base_out_state,
	   base_out_state_tx,
	   base_situation,
	   base_situation_with_outs,
	   event_runs_scored,
	   at_bats,
	   hits,
	   avg,
	   obp,
	   slg,
	   babip,
	   ops,
	   iso,
	   strikeouts_pct,
	   walks_pct
FROM re_batting.batting_stats_per_inning_base_out_state
order by season, inn_ct, base_out_state;