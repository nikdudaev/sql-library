create table yankees.wl_2024_raw (
  season text,
  game_number int,
  game_date date,
  opponent text,
  wins int,
  losses int,
  winning_pct numeric
);

insert into yankees.wl_2024_raw (season, game_number, game_date, opponent, wins, losses, winning_pct)
values 
   ('2024',	1,	'2024-03-28',	'HOU',	1,	0,	1.000000),
   ('2024',	2,	'2024-03-29',	'HOU',	2,	0,	1.000000),
   ('2024',	3,	'2024-03-30',	'HOU',	3,	0,	1.000000),
   ('2024',	4,	'2024-03-31',	'HOU',	4,	0,	1.000000),
   ('2024',	5,	'2024-04-01',	'ARI',	5,	0,	1.000000),
   ('2024',	6,	'2024-04-02',	'ARI',	5,	1,	0.833333),
   ('2024',	7,	'2024-04-03',	'ARI',	6,	1,	0.857143),
   ('2024',	8,	'2024-04-05',	'TOR',	6,	2,	0.750000),
   ('2024',	9,	'2024-04-06',	'TOR',	7,	2,	0.777778),
   ('2024',	10,	'2024-04-07',	'TOR',	8,	2,	0.800000),
   ('2024',	11,	'2024-04-08',	'MIA',	9,	2,	0.818182),
   ('2024',	12,	'2024-04-09',	'MIA',	10,	2,	0.833333),
   ('2024',	13,	'2024-04-10',	'MIA',	10,	3,	0.769231),
   ('2024',	14,	'2024-04-13',	'CLE',	11,	3,	0.785714),
   ('2024',	15,	'2024-04-13',	'CLE',	12,	3,	0.800000),
   ('2024',	16,	'2024-04-14',	'CLE',	12,	4,	0.750000),
   ('2024',	17,	'2024-04-15',	'TOR',	12,	5,	0.705882),
   ('2024',	18,	'2024-04-16',	'TOR',	12,	6,	0.666667),
   ('2024',	19,	'2024-04-17',	'TOR',	13,	6,	0.684211),
   ('2024',	20,	'2024-04-19',	'TBR',	14,	6,	0.700000),
   ('2024',	21,	'2024-04-20',	'TBR',	14,	7,	0.666667),
   ('2024',	22,	'2024-04-21',	'TBR',	15,	7,	0.681818),
   ('2024',	23,	'2024-04-22',	'OAK',	15,	8,	0.652174),
   ('2024',	24,	'2024-04-23',	'OAK',	16,	8,	0.666667),
   ('2024',	25,	'2024-04-24',	'OAK',	17,	8,	0.680000),
   ('2024',	26,	'2024-04-25',	'OAK',	17,	9,	0.653846),
   ('2024',	27,	'2024-04-26',	'MIL',	17,	10,	0.629630),
   ('2024',	28,	'2024-04-27',	'MIL',	18,	10,	0.642857),
   ('2024',	29,	'2024-04-28',	'MIL',	19,	10,	0.655172),
   ('2024',	30,	'2024-04-29',	'BAL',	19,	11,	0.633333),
   ('2024',	31,	'2024-04-30',	'BAL',	19,	12,	0.612903),
   ('2024',	32,	'2024-05-01',	'BAL',	20,	12,	0.625000),
   ('2024',	33,	'2024-05-02',	'BAL',	20,	13,	0.606061),
   ('2024',	34,	'2024-05-03',	'DET',	21,	13,	0.617647),
   ('2024',	35,	'2024-05-04',	'DET',	22,	13,	0.628571),
   ('2024',	36,	'2024-05-05',	'DET',	23,	13,	0.638889),
   ('2024',	37,	'2024-05-07',	'HOU',	24,	13,	0.648649),
   ('2024',	38,	'2024-05-08',	'HOU',	25,	13,	0.657895),
   ('2024',	39,	'2024-05-09',	'HOU',	25,	14,	0.641026),
   ('2024',	40,	'2024-05-10',	'TBR',	26,	14,	0.650000),
   ('2024',	41,	'2024-05-11',	'TBR',	26,	15,	0.634146),
   ('2024',	42,	'2024-05-12',	'TBR',	27,	15,	0.642857),
   ('2024',	43,	'2024-05-14',	'MIN',	28,	15,	0.651163),
   ('2024',	44,	'2024-05-15',	'MIN',	29,	15,	0.659091),
   ('2024',	45,	'2024-05-16',	'MIN',	30,	15,	0.666667),
   ('2024',	46,	'2024-05-17',	'CHW',	31,	15,	0.673913),
   ('2024',	47,	'2024-05-18',	'CHW',	32,	15,	0.680851),
   ('2024',	48,	'2024-05-19',	'CHW',	33,	15,	0.687500),
   ('2024',	49,	'2024-05-20',	'SEA',	33,	16,	0.673469),
   ('2024',	50,	'2024-05-21',	'SEA',	33,	17,	0.660000),
   ('2024',	51,	'2024-05-22',	'SEA',	34,	17,	0.666667),
   ('2024',	52,	'2024-05-23',	'SEA',	35,	17,	0.673077),
   ('2024',	53,	'2024-05-24',	'SDP',	36,	17,	0.679245),
   ('2024',	54,	'2024-05-25',	'SDP',	37,	17,	0.685185),
   ('2024',	55,	'2024-05-26',	'SDP',	37,	18,	0.672727),
   ('2024',	56,	'2024-05-28',	'LAA',	37,	19,	0.660714),
   ('2024',	57,	'2024-05-29',	'LAA',	38,	19,	0.666667),
   ('2024',	58,	'2024-05-30',	'LAA',	39,	19,	0.672414),
   ('2024',	59,	'2024-05-31',	'SFG',	40,	19,	0.677966),
   ('2024',	60,	'2024-06-01',	'SFG',	41,	19,	0.683333),
   ('2024',	61,	'2024-06-02',	'SFG',	42,	19,	0.688525),
   ('2024',	62,	'2024-06-04',	'MIN',	43,	19,	0.693548),
   ('2024',	63,	'2024-06-05',	'MIN',	44,	19,	0.698413),
   ('2024',	64,	'2024-06-06',	'MIN',	45,	19,	0.703125),
   ('2024',	65,	'2024-06-07',	'LAD',	45,	20,	0.692308),
   ('2024',	66,	'2024-06-08',	'LAD',	45,	21,	0.681818),
   ('2024',	67,	'2024-06-09',	'LAD',	46,	21,	0.686567),
   ('2024',	68,	'2024-06-10',	'KCR',	47,	21,	0.691176),
   ('2024',	69,	'2024-06-11',	'KCR',	48,	21,	0.695652),
   ('2024',	70,	'2024-06-12',	'KCR',	49,	21,	0.700000),
   ('2024',	71,	'2024-06-13',	'KCR',	49,	22,	0.690141),
   ('2024',	72,	'2024-06-14',	'BOS',	50,	22,	0.694444),
   ('2024',	73,	'2024-06-15',	'BOS',	50,	23,	0.684932),
   ('2024',	74,	'2024-06-16',	'BOS',	50,	24,	0.675676),
   ('2024',	75,	'2024-06-18',	'BAL',	51,	24,	0.680000),
   ('2024',	76,	'2024-06-19',	'BAL',	51,	25,	0.671053),
   ('2024',	77,	'2024-06-20',	'BAL',	51,	26,	0.662338),
   ('2024',	78,	'2024-06-21',	'ATL',	51,	27,	0.653846),
   ('2024',	79,	'2024-06-22',	'ATL',	52,	27,	0.658228),
   ('2024',	80,	'2024-06-23',	'ATL',	52,	28,	0.650000),
   ('2024',	81,	'2024-06-25',	'NYM',	52,	29,	0.641975),
   ('2024',	82,	'2024-06-26',	'NYM',	52,	30,	0.634146),
   ('2024',	83,	'2024-06-27',	'TOR',	52,	31,	0.626506),
   ('2024',	84,	'2024-06-28',	'TOR',	53,	31,	0.630952),
   ('2024',	85,	'2024-06-29',	'TOR',	53,	32,	0.623529),
   ('2024',	86,	'2024-06-30',	'TOR',	54,	32,	0.627907),
   ('2024',	87,	'2024-07-02',	'CIN',	54,	33,	0.620690),
   ('2024',	88,	'2024-07-03',	'CIN',	54,	34,	0.613636),
   ('2024',	89,	'2024-07-04',	'CIN',	54,	35,	0.606742),
   ('2024',	90,	'2024-07-05',	'BOS',	54,	36,	0.600000),
   ('2024',	91,	'2024-07-06',	'BOS',	55,	36,	0.604396),
   ('2024',	92,	'2024-07-07',	'BOS',	55,	37,	0.597826);

create table yankees.wl_2024_processed as
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
from yankees.wl_2024_raw;

drop table yankees.wl_2024_raw cascade;

insert into yankees.win_loss_records (season, game_number, game_date, opponent, wins, losses, winning_pct, moving_winning_pct, moving_losses_avg,
        moving_wins_avg, winning_pct_rate_change, wins_pct_rate_change, losses_pct_rate_change)
select season, 
       game_number, 
       game_date, 
       opponent, 
       wins, 
       losses, 
       winning_pct, 
       moving_winning_pct, 
       moving_losses_avg,
       moving_wins_avg, 
       winning_pct_rate_change, 
       wins_pct_rate_change, 
       losses_pct_rate_change
from yankees.wl_2024_processed;

drop table yankees.wl_2024_processed;