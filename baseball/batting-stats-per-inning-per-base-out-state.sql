create table re_batting.batting_stats_per_inning_base_out_state as
with basis as (
  select *
  from run_expectancy.full_rv_1912_2023
  where inn_ct <= 9.0 and not (inn_ct = 9.0 and bat_home_id = '1')
),
plate_appearances as (
  select season,
         cast(cast(inn_ct as int) as text) as inn_ct,
         "state" as base_out_state,
         count(*) as pa_s
  from basis
  group by season, "state", inn_ct
),
at_bats as (
  select season,
         cast(cast(inn_ct as int) as text) as inn_ct,
         "state" as base_out_state,
         count(*) as at_bats
  from basis
  where ab_fl = 'T'
  group by season, "state", inn_ct
),
-- Hits
hits as (
  select season,
         cast(cast(inn_ct as int) as text) as inn_ct,
         "state" as base_out_state,
         count(*) as hits
  from basis
  where event_cd in ('20', '21', '22', '23')
  group by season, "state", inn_ct
),
-- Walks (Includes IBB)
walks as (
  select season,
         cast(cast(inn_ct as int) as text) as inn_ct,
         "state" as base_out_state,
         count(*) as walks
  from basis
  where event_cd in ('14', '15')
  group by season, "state", inn_ct
),
-- Hit by pitch
hit_by_pitch as (
  select season,
         cast(cast(inn_ct as int) as text) as inn_ct,
         "state" as base_out_state,
         count(*) as hit_by_pitch
  from basis
  where event_cd = '16'
  group by season, "state", inn_ct
),
-- Sacrifice Fly
sac_fly as (
  select season,
         cast(cast(inn_ct as int) as text) as inn_ct,
         "state" as base_out_state,
         count(*) as sac_fly
  from basis
  where sf_fl = 'T'
  group by season, "state", inn_ct
),
-- Singles
singles as (
  select season,
         cast(cast(inn_ct as int) as text) as inn_ct,
         "state" as base_out_state,
		 count(*) as singles
  from basis
  where event_cd in ('20')
  group by season, "state", inn_ct
),
-- Doubles
doubles as (
  select season,
         cast(cast(inn_ct as int) as text) as inn_ct,
         "state" as base_out_state,
	     count(*) as doubles
  from basis
  where event_cd in ('21')
  group by season, "state", inn_ct
),
-- Triples
triples as (
  select season,
         cast(cast(inn_ct as int) as text) as inn_ct,
         "state" as base_out_state,
		 count(*) as triples
  from basis
  where event_cd in ('22')
  group by season, "state", inn_ct
),
-- Homeruns
homeruns as (
  select season,
         cast(cast(inn_ct as int) as text) as inn_ct,
         "state" as base_out_state,
		 count(*) as homeruns
  from basis
  where event_cd in ('23')
  group by season, "state", inn_ct
),
-- Strikeouts
strikeouts as (
  select season,
         cast(cast(inn_ct as int) as text) as inn_ct,
         "state" as base_out_state,
         count(*) as strikeouts
  from basis
  where event_cd = '3'
  group by season, "state", inn_ct
),
-- Fly Balls
flyballs as (
  select season,
         cast(cast(inn_ct as int) as text) as inn_ct,
         "state" as base_out_state,
         count(*) as flyballs
  from basis
  where battedball_cd = 'F'
  group by season, "state", inn_ct
),
-- GroundBalls
groundballs as (
  select season,
         cast(cast(inn_ct as int) as text) as inn_ct,
         "state" as base_out_state,
         count(*) as groundballs
  from basis
  where battedball_cd = 'G'
  group by season, "state", inn_ct
),
-- Line drives
linedrives as (
  select season,
         cast(cast(inn_ct as int) as text) as inn_ct,
         "state" as base_out_state,
         count(*) as linedrives
  from basis
  where battedball_cd = 'L'
  group by season, "state", inn_ct
),
-- Popups
popups as (
  select season,
         cast(cast(inn_ct as int) as text) as inn_ct,
         "state" as base_out_state,
         count(*) as popups
  from basis
  where battedball_cd = 'P'
  group by season, "state", inn_ct
),
for_calculations as (
  select ab.season,
         ab.inn_ct,
         ab.base_out_state,
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
         coalesce(pp.popups, 0) as popups
  from at_bats ab
  left join plate_appearances pa on ab.season = pa.season and ab.base_out_state = pa.base_out_state and ab.inn_ct = pa.inn_ct
  left join hits h on ab.season = h.season and ab.base_out_state = h.base_out_state and ab.inn_ct = h.inn_ct 
  left join walks w on ab.season = w.season and ab.base_out_state = w.base_out_state and ab.inn_ct = w.inn_ct
  left join hit_by_pitch hbp on ab.season = hbp.season and ab.base_out_state = hbp.base_out_state and ab.inn_ct = hbp.inn_ct
  left join sac_fly sf on ab.season = sf.season and ab.base_out_state = sf.base_out_state and ab.inn_ct = sf.inn_ct
  left join singles s on ab.season = s.season and ab.base_out_state = s.base_out_state and ab.inn_ct = s.inn_ct
  left join doubles d on ab.season = d.season and ab.base_out_state = d.base_out_state and ab.inn_ct = d.inn_ct
  left join triples tr on ab.season = tr.season and ab.base_out_state = tr.base_out_state and ab.inn_ct = tr.inn_ct
  left join homeruns hr on ab.season = hr.season and ab.base_out_state = hr.base_out_state and ab.inn_ct = hr.inn_ct
  left join strikeouts str on ab.season = str.season and ab.base_out_state = str.base_out_state and ab.inn_ct = str.inn_ct
  left join flyballs fb on ab.season = fb.season and ab.base_out_state = fb.base_out_state and ab.inn_ct = fb.inn_ct
  left join groundballs gb on ab.season = gb.season and ab.base_out_state = gb.base_out_state and ab.inn_ct = gb.inn_ct
  left join linedrives ld on ab.season = ld.season and ab.base_out_state = ld.base_out_state and ab.inn_ct = ld.inn_ct
  left join popups pp on ab.season = pp.season and ab.base_out_state = pp.base_out_state and ab.inn_ct = pp.inn_ct
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
	   cast(at_bats as numeric),3)) as iso
from for_calculations;