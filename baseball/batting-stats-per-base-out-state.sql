create table run_expectancy.batting_stats_base_out_state as
with basis as (
  select *
  from run_expectancy.full_rv_1912_2024
  --where inn_ct <= 9.0 and not (inn_ct = 9.0 and bat_home_id = '1')
),
event_runs_scored as (
  select season,
         "state" as base_out_state,
         cast(sum(event_runs_ct) as int) as event_runs_scored
  from basis
  group by season, "state"
),
plate_appearances as (
  select season,
         "state" as base_out_state,
         count(*) as pa_s
  from basis
  group by season, "state"
),
at_bats as (
  select season,
         "state" as base_out_state,
         count(*) as at_bats
  from basis
  where ab_fl = 'T'
  group by season, "state"
),
-- Hits
hits as (
  select season,
         "state" as base_out_state,
         count(*) as hits
  from basis
  where event_cd in ('20', '21', '22', '23')
  group by season, "state"
),
-- Walks (Includes IBB)
walks as (
  select season,
         "state" as base_out_state,
         count(*) as walks
  from basis
  where event_cd in ('14', '15')
  group by season, "state"
),
-- Hit by pitch
hit_by_pitch as (
  select season,
         "state" as base_out_state,
         count(*) as hit_by_pitch
  from basis
  where event_cd = '16'
  group by season, "state"
),
-- Sacrifice Fly
sac_fly as (
  select season,
         "state" as base_out_state,
         count(*) as sac_fly
  from basis
  where sf_fl = 'T'
  group by season, "state"
),
-- Singles
singles as (
  select season,
         "state" as base_out_state,
		 count(*) as singles
  from basis
  where event_cd in ('20')
  group by season, "state"
),
-- Doubles
doubles as (
  select season,
         "state" as base_out_state,
	     count(*) as doubles
  from basis
  where event_cd in ('21')
  group by season, "state"
),
-- Triples
triples as (
  select season,
         "state" as base_out_state,
		 count(*) as triples
  from basis
  where event_cd in ('22')
  group by season, "state"
),
-- Homeruns
homeruns as (
  select season,
         "state" as base_out_state,
		 count(*) as homeruns
  from basis
  where event_cd in ('23')
  group by season, "state"
),
-- Strikeouts
strikeouts as (
  select season,
         "state" as base_out_state,
         count(*) as strikeouts
  from basis
  where event_cd = '3'
  group by season, "state"
),
-- Fly Balls
flyballs as (
  select season,
         "state" as base_out_state,
         count(*) as flyballs
  from basis
  where battedball_cd = 'F'
  group by season, "state"
),
-- GroundBalls
groundballs as (
  select season,
         "state" as base_out_state,
         count(*) as groundballs
  from basis
  where battedball_cd = 'G'
  group by season, "state"
),
-- Line drives
linedrives as (
  select season,
         "state" as base_out_state,
         count(*) as linedrives
  from basis
  where battedball_cd = 'L'
  group by season, "state"
),
-- Popups
popups as (
  select season,
         "state" as base_out_state,
         count(*) as popups
  from basis
  where battedball_cd = 'P'
  group by season, "state"
),
-- Wild Pitch
wild_pitch as (
  select season,
         "state" as base_out_state,
         count(*) as wild_pitch
  from basis
  where event_cd = '9'
  group by season, "state"
),
-- Passed ball
passed_ball as (
  select season,
         "state" as base_out_state,
         count(*) as passed_ball
  from basis
  where event_cd = '10'
  group by season, "state"
),
-- Stolen Base
stolen_base as (
  select season,
         "state" as base_out_state,
         count(*) as stolen_base
  from basis
  where event_cd = '4'
  group by season, "state"
),
-- Error
error as (
  select season,
         "state" as base_out_state,
         count(*) as error
  from basis
  where event_cd = '18'
  group by season, "state"
),
-- Event Outs
event_outs as (
  select season,
         "state" as base_out_state,
         sum(cast(event_outs_ct as int)) as event_outs
  from basis
  group by season, "state"
),
-- Double Plays
double_plays as (
  select season,
         "state" as base_out_state,
         count(*) as double_plays
  from basis
  where dp_fl = 'T'
  group by season, "state"
),
-- Triple Plays
triple_plays as (
  select season,
         "state" as base_out_state,
         count(*) as triple_plays
  from basis
  where tp_fl = 'T'
  group by season, "state"
),
for_calculations as (
  select ab.season,
         ab.base_out_state,
         coalesce(ers.event_runs_scored, 0) as event_runs_scored,
		     coalesce(pa.pa_s, 0) as pa_s,
         coalesce(ab.at_bats, 0) as at_bats,
	     coalesce(h.hits, 0) as hits,
	     coalesce(w.walks, 0) as walks,
	     coalesce(hbp.hit_by_pitch, 0) as hit_by_pitch,
	     coalesce(sf.sac_fly, 0) as sac_fly,
	     coalesce(s.singles, 0) as singles,
	     coalesce(d.doubles, 0) as doubles,
	     coalesce(tr.triples, 0) as triples,
	     coalesce(hr.homeruns, 0) as homeruns,
         coalesce(str.strikeouts, 0) as strikeouts,
		 coalesce(fb.flyballs, 0) as flyballs,
	     coalesce(gb.groundballs, 0) as groundballs,
	     coalesce(ld.linedrives, 0) as linedrives,
         coalesce(pp.popups, 0) as popups,
		 coalesce(wp.wild_pitch, 0) as wild_pitch,
	     coalesce(sb.stolen_base, 0) as stolen_base,
         coalesce(pb.passed_ball, 0) as passed_ball,
		 coalesce(err.error, 0) as error,
     coalesce(eo.event_outs, 0) as event_outs,
     coalesce(dp.double_plays, 0) as double_plays,
     coalesce(tp.triple_plays, 0) as triple_plays
  from at_bats ab
  left join plate_appearances pa on ab.season = pa.season and ab.base_out_state = pa.base_out_state
  left join event_runs_scored ers on ab.season = ers.season and ab.base_out_state = ers.base_out_state
  left join hits h on ab.season = h.season and ab.base_out_state = h.base_out_state
  left join walks w on ab.season = w.season and ab.base_out_state = w.base_out_state
  left join hit_by_pitch hbp on ab.season = hbp.season and ab.base_out_state = hbp.base_out_state
  left join sac_fly sf on ab.season = sf.season and ab.base_out_state = sf.base_out_state
  left join singles s on ab.season = s.season and ab.base_out_state = s.base_out_state
  left join doubles d on ab.season = d.season and ab.base_out_state = d.base_out_state
  left join triples tr on ab.season = tr.season and ab.base_out_state = tr.base_out_state
  left join homeruns hr on ab.season = hr.season and ab.base_out_state = hr.base_out_state
  left join strikeouts str on ab.season = str.season and ab.base_out_state = str.base_out_state
  left join flyballs fb on ab.season = fb.season and ab.base_out_state = fb.base_out_state
  left join groundballs gb on ab.season = gb.season and ab.base_out_state = gb.base_out_state
  left join linedrives ld on ab.season = ld.season and ab.base_out_state = ld.base_out_state
  left join popups pp on ab.season = pp.season and ab.base_out_state = pp.base_out_state
  left join wild_pitch wp on ab.season = wp.season and ab.base_out_state = wp.base_out_state
  left join stolen_base sb on ab.season = sb.season and ab.base_out_state = sb.base_out_state
  left join passed_ball pb on ab.season = pb.season and ab.base_out_state = pb.base_out_state
  left join error err on ab.season = err.season and ab.base_out_state = err.base_out_state
  left join event_outs eo on ab.season = eo.season and ab.base_out_state = eo.base_out_state
  left join double_plays dp on ab.season = dp.season and ab.base_out_state = dp.base_out_state
  left join triple_plays tp on ab.season = tp.season and ab.base_out_state = tp.base_out_state
)
select *,
       round(cast(hits as numeric) / 
	   cast(at_bats as numeric),3) as "avg",
       round((cast(hits as numeric) + 
		cast(walks as numeric) + 
		cast(hit_by_pitch as numeric)) / 
	   (cast(at_bats as numeric) + 
		cast(walks as numeric) + 
		cast(hit_by_pitch as numeric) + 
		cast(sac_fly as numeric)),3) as obp,
        round((cast(singles as numeric) +
	          2 * cast(doubles as numeric) +
			  3 * cast(triples as numeric) +
			  4 * cast(homeruns as numeric)) / cast(at_bats as numeric),3) as slg,
        round((cast(hits as numeric) -cast(homeruns as numeric)) / 
	   (cast(at_bats as numeric) -
	    cast(strikeouts as numeric) - 
		cast(homeruns as numeric) +
		cast(sac_fly as numeric)),3) as babip,
		round(cast(strikeouts as numeric) / cast(pa_s as numeric), 3) as strikeouts_pct,
		round(cast(walks as numeric) / cast(pa_s as numeric), 3) as walks_pct,
		(round((cast(hits as numeric) + 
		cast(walks as numeric) + 
		cast(hit_by_pitch as numeric)) / 
	   (cast(at_bats as numeric) + 
		cast(walks as numeric) + 
		cast(hit_by_pitch as numeric) + 
		cast(sac_fly as numeric)),3)) + 
		(round((cast(singles as numeric) +
	          2 * cast(doubles as numeric) +
			  3 * cast(triples as numeric) +
			  4 * cast(homeruns as numeric)) / cast(at_bats as numeric),3)) as ops,
		(round((cast(singles as numeric) +
	          2 * cast(doubles as numeric) +
			  3 * cast(triples as numeric) +
			  4 * cast(homeruns as numeric)) / cast(at_bats as numeric),3)) -
		(round(cast(hits as numeric) / 
	   cast(at_bats as numeric),3)) as iso,
	   case
                     when cast(season as int) >= 1912 and cast(season as int) <= 1919 then 'Dead-Ball Era'
					 when cast(season as int) >= 1920 and cast(season as int) <= 1941 then 'Live-Ball Era'
					 when cast(season as int) >= 1942 and cast(season as int) <= 1960 then 'Integration Era'
					 when cast(season as int) >= 1961 and cast(season as int) <= 1976 then 'Expansion Era'
					 when cast(season as int) >= 1977 and cast(season as int) <= 1993 then 'Free Agency Era'
					 when cast(season as int) >= 1994 and cast(season as int) <= 2005 then 'Steroid Era'
					 when cast(season as int) >= 2006 then 'Modern Era'
				   end as baseball_era
from for_calculations;