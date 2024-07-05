create table if not exists lahman.all_star_full (
    playerID text,
    yearID text,
    game_num int,
    gameID text,
    teamID text,
    leagueID text,
    played text,
    startingPos int
);

create table if not exists lahman.appearances (
    yearID text,         -- Year
    teamID text,         -- Team
    lgID text,           -- League
    playerID text,       -- Player ID code
    total_games int,     -- Total games played
    games_started int,   -- Games started
    games_batted int,    -- Games in which player batted
    games_in_defense int,-- Games in which player appeared on defense
    games_as_pitcher int,-- Games as pitcher
    games_as_catcher int,-- Games as catcher
    games_at_1b int,     -- Games as first baseman
    games_at_2b int,     -- Games as second baseman
    games_at_3b int,     -- Games as third baseman
    games_at_ss int,     -- Games as shortstop
    games_at_lf int,     -- Games as left fielder
    games_at_cf int,     -- Games as center fielder
    games_at_rf int,     -- Games as right fielder
    games_at_of int,     -- Games as outfielder
    games_at_dh int,     -- Games as designated hitter
    games_at_ph int,     -- Games as pinch hitter
    games_at_pr int     -- Games as pinch runner
);

create table if not exists lahman.awards_managers (
    playerID text,       -- Manager ID code
    awardID  text,       -- Name of award won
    yearID   text,       -- Year
    lgID     text,       -- League
    tie      text,       -- Award was a tie (Y or N)
    notes    text        -- Notes about the award
);

create table if not exists lahman.awards_players (
    playerID text,       -- Manager ID code
    awardID  text,       -- Name of award won
    yearID   text,       -- Year
    lgID     text,       -- League
    tie      text,       -- Award was a tie (Y or N)
    notes    text        -- Notes about the award
);

create table if not exists lahman.awards_share_managers (
    awardID    text,   -- Name of award votes were received for
    yearID     text,   -- Year
    lgID       text,   -- League
    playerID   text,   -- Manager ID code
    pointsWon  int,    -- Number of points received
    pointsMax  int,    -- Maximum number of points possible
    votesFirst int     -- Number of first place votes
);

create table if not exists lahman.awards_share_players (
    awardID    text,   -- Name of award votes were received for
    yearID     text,   -- Year
    lgID       text,   -- League
    playerID   text,   -- Manager ID code
    pointsWon  int,    -- Number of points received
    pointsMax  int,    -- Maximum number of points possible
    votesFirst int     -- Number of first place votes
);

create table if not exists lahman.batting (
    playerID text,    -- Player ID code
    yearID   text,    -- Year
    stint    text,    -- player's stint (order of appearances within a season)
    teamID   text,    -- Team
    lgID     text,    -- League
    G        int,     -- Games
    AB       int,     -- At Bats
    R        int,     -- Runs
    H        int,     -- Hits
    x2B       int,     -- Doubles
    x3B       int,     -- Triples
    HR       int,     -- Homeruns
    RBI      int,     -- Runs Batted In
    SB       int,     -- Stolen Bases
    CS       int,     -- Caught Stealing
    BB       int,     -- Base on Balls
    SO       int,     -- Strikeouts
    IBB      int,     -- Intentional walks
    HBP      int,     -- Hit by pitch
    SH       int,     -- Sacrifice hits
    SF       int,     -- Sacrifice flies
    GIDP     int      -- Grounded into double plays
);

create table if not exists lahman.batting_postseason (
    yearID   text,     -- Year
    postseason_round    text,     -- Level of playoffs 
    playerID text,     -- Player ID code
    teamID   text,     -- Team
    lgID     text,     -- League
    G        int,     -- Games
    AB       int,     -- At Bats
    R        int,     -- Runs
    H        int,     -- Hits
    x2B       int,     -- Doubles
    x3B       int,     -- Triples
    HR       int,     -- Homeruns
    RBI      int,     -- Runs Batted In
    SB       int,     -- Stolen Bases
    CS       int,     -- Caught stealing
    BB       int,     -- Base on Balls
    SO       int,     -- Strikeouts
    IBB      int,     -- Intentional walks
    HBP      int,     -- Hit by pitch
    SH       int,     -- Sacrifices
    SF       int,     -- Sacrifice flies
    GIDP     int     -- Grounded into double plays
);

create table if not exists lahman.college_playing (
    playerid text,     -- Player ID code
    schoolID text,     -- School ID code
    year     text     -- Year
);

create table if not exists lahman.fielding (
    playerID  text,    -- Player ID code
    yearID    text,    -- Year
    stint     text,    -- player's stint (order of appearances within a season)
    teamID    text,    -- Team
    lgID      text,    -- League
    Pos       text,    -- Position
    G         int,    -- Games 
    GS        int,    -- Games Started
    InnOuts   int,    -- Time played in the field expressed as outs 
    PO        int,    -- Putouts
    A         int,    -- Assists
    E         int,    -- Errors
    DP        int,    -- Double Plays
    PB        int,    -- Passed Balls (by catchers)
    WP        int,    -- Wild Pitches (by catchers)
    SB        int,    -- Opponent Stolen Bases (by catchers)
    CS        int,    -- Opponents Caught Stealing (by catchers)
    ZR        int    -- Zone Rating
);

create table if not exists lahman.fielding_outfield (
    playerID  text,    -- Player ID code
    yearID    text,    -- Year
    stint     int,    -- Player's stint (order of appearances within a season)
    Glf       int,    -- Games played in left field
    Gcf       int,    -- Games played in center field
    Grf       int    -- Games played in right field
);

create table if not exists lahman.fielding_outfield_split (
    playerID text,     -- Player ID code
    yearID   text,     -- Year
    stint    text,     -- Player's stint (order of appearances within a season)
    teamID   text,     -- Team
    lgID     text,     -- League
    Pos      text,     -- Position
    G        int,     -- Games 
    GS       int,     -- Games Started
    InnOuts  int,     -- Time played in the field expressed as outs 
    PO       int,     -- Putouts
    A        int,     -- Assists
    E        int,     -- Errors
    DP       int     -- Double Plays
);

create table if not exists lahman.fielding_postseason (
    playerID          text,       -- Player ID code
    yearID            text,       -- Year
    teamID            text,       -- Team
    lgID              text,       -- League
    postseason_round  text,       -- Level of playoffs 
    Pos               text,       -- Position
    G                 int,       -- Games 
    GS                int,       -- Games Started
    InnOuts           int,       -- Time played in the field expressed as outs 
    PO                int,       -- Putouts
    A                 int,       -- Assists
    E                 int,       -- Errors
    DP                int,       -- Double Plays
    TP                int,       -- Triple Plays
    PB                int,       -- Passed Balls
    SB                int,       -- Stolen Bases allowed (by catcher)
    CS                int       -- Caught Stealing (by catcher)
);

create table if not exists lahman.hall_of_fame (
    playerID    text,  -- Player ID code
    yearID      text,  -- Year of ballot
    votedBy     text,  -- Method by which player was voted upon
    ballots     int,  -- Total ballots cast in that year
    needed      int,  -- Number of votes needed for selection in that year
    votes       int,  -- Total votes received
    inducted    text,  -- Whether player was inducted by that vote or not (Y or N)
    category    text,  -- Category in which candidate was honored
    needed_note text  -- Explanation of qualifiers for special elections, revised in 2023 to include important notes about the record.
);

create table if not exists lahman.home_games (
    yearkey    text,   -- Year
    leaguekey  text,   -- League
    teamkey    text,   -- Team ID
    parkkey    text,   -- Ballpark ID
    spanfirst  date,   -- Date of first game played
    spanlast   date,   -- Date of last game played
    games      int,    -- Total number of games
    openings   int,    -- Total number of paid dates played (games with attendance)
    attendance int     -- Total attendance
);

create table if not exists lahman.managers (
    playerID  text,    -- Player ID Number
    yearID    text,    -- Year
    teamID    text,    -- Team
    lgID      text,    -- League
    inseason  int,    -- Managerial order, in order of appearance during the year.  One if the individual managed the team the entire year. 
    G         int,    -- Games managed
    W         int,    -- Wins
    L         int,    -- Losses
    team_rank int,    -- Team's final position in standings that year
    plyrMgr   text    -- Player Manager (denoted by 'Y')
);

create table if not exists lahman.managers_half (
    playerID  text,    -- Manager ID code
    yearID    text,    -- Year
    teamID    text,    -- Team
    lgID      text,    -- League
    inseason  int,    -- Managerial order, in order of appearance during the year.  One if the individual managed the team the entire year. 
    half      int,    -- First or second half of season
    G         int,    -- Games managed
    W         int,    -- Wins
    L         int,    -- Losses
    team_rank      int    -- Team's position in standings for the half
);

create table if not exists lahman.parks (
    parkkey   text,    -- Ballpark ID code
    parkname  text,    -- Name of ballpark
    parkalias text,    -- Alternate names of ballpark, separated by semicolon
    city      text,    -- City
    state     text,    -- State 
    country   text    -- Country
);

create table if not exists lahman.people (
    playerID     text, -- A unique code assigned to each player.  The playerID links the data in this file with records in the other files.
    birthYear    text, -- Year player was born
    birthMonth   text, -- Month player was born
    birthDay     text, -- Day player was born
    birthCountry text, -- Country where player was born
    birthState   text, -- State where player was born
    birthCity    text, -- City where player was born
    deathYear    text, -- Year player died
    deathMonth   text, -- Month player died
    deathDay     text, -- Day player died
    deathCountry text, -- Country where player died
    deathState   text, -- State where player died
    deathCity    text, -- City where player died
    nameFirst    text, -- Player's first name
    nameLast     text, -- Player's last name
    nameGiven    text, -- Player's given name (typically first and middle)
    weight       numeric, -- Player's weight in pounds
    height       numeric, -- Player's height in inches
    bats         text, -- Player's batting hand (left, right, or both)         
    throws       text, -- Player's throwing hand (left or right)
    debut        date, -- Date that player made first major league appearance
    bbrefID      text, -- ID used by Baseball Reference website
    finalGame    date, -- Date that player made first major league appearance (includes date of last played game even if still active)
    retroID      text -- ID used by Retrosheet
);

create table if not exists lahman.pitching (
    playerID  text,    -- Player ID code
    yearID    text,    -- Year
    stint     int,    -- player's stint (order of appearances within a season)
    teamID    text,    -- Team
    lgID      text,    -- League
    W         int,    -- Wins
    L         int,    -- Losses
    G         int,    -- Games
    GS        int,    -- Games Started
    CG        int,    -- Complete Games 
    SHO       int,    -- Shutouts
    SV        int,    -- Saves
    IPOuts    int,    -- Outs Pitched (innings pitched x 3)
    H         int,    -- Hits
    ER        int,    -- Earned Runs
    HR        int,    -- Homeruns
    BB        int,    -- Walks
    SO        int,    -- Strikeouts
    BAOpp     numeric,    -- Opponent's Batting Average
    ERA       numeric,    -- Earned Run Average
    IBB       int,    -- Intentional Walks
    WP        int,    -- Wild Pitches
    HBP       int,    -- Batters Hit By Pitch
    BK        int,    -- Balks
    BFP       int,    -- Batters faced by Pitcher
    GF        int,    -- Games Finished
    R         int,    -- Runs Allowed
    SH        int,    -- Sacrifices by opposing batters
    SF        int,    -- Sacrifice flies by opposing batters
    GIDP      int    -- Grounded into double plays by opposing batter
);

create table if not exists lahman.pitching_postseason (
    playerID          text,       -- Player ID code
    yearID            text,       -- Year
    postseason_round  text,       -- Level of playoffs 
    teamID            text,       -- Team
    lgID              text,       -- League
    W                 int,       -- Wins
    L                 int,       -- Losses
    G                 int,       -- Games
    GS                int,       -- Games Started
    CG                int,       -- Complete Games
    SHO               int,       -- Shutouts 
    SV                int,       -- Saves
    IPOuts            int,       -- Outs Pitched (innings pitched x 3)
    H                 int,       -- Hits
    ER                int,       -- Earned Runs
    HR                int,       -- Homeruns
    BB                int,       -- Walks
    SO                int,       -- Strikeouts
    BAOpp             numeric,       -- Opponents' batting average
    ERA               numeric,       -- Earned Run Average
    IBB               int,       -- Intentional Walks
    WP                int,       -- Wild Pitches
    HBP               int,       -- Batters Hit By Pitch
    BK                int,       -- Balks
    BFP               int,       -- Batters faced by Pitcher
    GF                int,       -- Games Finished
    R                 int,       -- Runs Allowed
    SH                int,       -- Sacrifice Hits allowed
    SF                int,       -- Sacrifice Flies allowed
    GIDP              int       -- Grounded into Double Plays
);

create table if not exists lahman.salaries (
    yearID     text,   -- Year
    teamID     text,   -- Team
    lgID       text,   -- League
    playerID   text,   -- Player ID code
    salary     numeric   -- Salary
);

create table if not exists lahman.schools (
    schoolID    text,  -- School ID code
    schoolName  text,  -- School name
    schoolCity  text,  -- City where school is located
    schoolState text,  -- State where school's city is located
    schoolNick  text  -- Nickname for school's baseball team
);

create table if not exists lahman.series_postseason (
    yearID            text,       -- Year
    postseason_round  text,       -- Level of playoffs 
    teamIDwinner      text,       -- Team ID of the team that won the series
    lgIDwinner        text,       -- League ID of the team that won the series
    teamIDloser       text,       -- Team ID of the team that lost the series
    lgIDloser         text,       -- League ID of the team that lost the series 
    wins              int,       -- Wins by team that won the series
    losses            int,       -- Losses by team that won the series
    ties              int       -- Tie games
);

create table if not exists lahman.teams (
    yearID     text,   -- Year
    lgID       text,   -- League
    teamID     text,   -- Team
    franchID   text,   -- Franchise (links to TeamsFranchise table)
    divID      text,   -- Team's division
    team_rank  int,        -- Position in final standings
    G          int,   -- Games played
    GHome      int,   -- Games played at home
    W          int,   -- Wins
    L          int,   -- Losses
    DivWin     text,   -- Division Winner (Y or N)
    WCWin      text,   -- Wild Card Winner (Y or N)
    LgWin      text,   -- League Champion(Y or N)
    WSWin      text,   -- World Series Winner (Y or N)
    R          int,   -- Runs scored
    AB         int,   -- At bats
    H          int,   -- Hits by batters
    x2B         int,   -- Doubles
    x3B         int,   -- Triples
    HR         int,   -- Homeruns by batters
    BB         int,   -- Walks by batters
    SO         int,   -- Strikeouts by batters
    SB         int,   -- Stolen bases
    CS         int,   -- Caught stealing
    HBP        int,   -- Batters hit by pitch
    SF         int,   -- Sacrifice flies
    RA         int,   -- Opponents runs scored
    ER         int,   -- Earned runs allowed
    ERA        numeric,   -- Earned run average
    CG         int,   -- Complete games
    SHO        int,   -- Shutouts
    SV         int,   -- Saves
    IPOuts     int,   -- Outs Pitched (innings pitched x 3)
    HA         int,   -- Hits allowed
    HRA        int,   -- Homeruns allowed
    BBA        int,   -- Walks allowed
    SOA        int,   -- Strikeouts by pitchers
    E          int,   -- Errors
    DP         int,   -- Double Plays
    FP         numeric,   -- Fielding  percentage
    team_name  text,        -- Team's full name
    park       text,   -- Name of team's home ballpark
    attendance int,   -- Home attendance total
    BPF        int,   -- Three-year park factor for batters
    PPF        int,   -- Three-year park factor for pitchers
    teamIDBR       text,-- Team ID used by Baseball Reference website
    teamIDlahman45 text,-- Team ID used in Lahman database version 4.5
    teamIDretro    text-- Team ID used by Retrosheet
);

create table if not exists lahman.teams_franchises (
    franchID   text,   -- Franchise ID
    franchName text,   -- Franchise name
    active     text,   -- Whether team is currently active or not (Y or N)
    NAassoc    text   -- ID of National Association team franchise played as
);

create table if not exists lahman.teams_half (
    yearID    text,    -- Year
    lgID      text,    -- League
    teamID    text,    -- Team
    half      int,    -- First or second half of season
    divID     text,    -- Division
    DivWin    text,    -- Won Division (Y or N)
    team_rank int,    --      Team's position in standings for the half
    G         int,    -- Games played
    W         int,    -- Wins
    L         int    -- Losses
);