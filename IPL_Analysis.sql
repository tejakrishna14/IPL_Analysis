CREATE DATABASE IPL;
USE IPL;
SELECT COUNT(*) AS Total FROM matches;

-- 01 team win percentage
WITH match_counts AS (
    SELECT team1 AS team FROM matches UNION ALL SELECT team2 FROM matches
),
total_matches AS (
    SELECT team, COUNT(*) as matches_played FROM match_counts GROUP BY team
),
wins AS (
    SELECT winner, COUNT(*) as matches_won FROM matches WHERE winner IS NOT NULL GROUP BY winner
)
SELECT
    tm.team,
    tm.matches_played,
    w.matches_won,
    (w.matches_won * 100.0 / tm.matches_played) AS win_percentage
FROM total_matches tm
JOIN wins w ON tm.team = w.winner
ORDER BY win_percentage DESC;


-- 02 toss impact analysis
SELECT
    toss_winner,
    COUNT(*) as total_toss_wins,
    SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) as matches_won_after_toss_win,
    (SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) as toss_win_to_match_win_percentage
FROM matches
WHERE winner IS NOT NULL
GROUP BY toss_winner
ORDER BY total_toss_wins DESC;


-- 03 top batsman strike rate
WITH BatsmanStats AS (
    SELECT
        batter,
        SUM(batsman_runs) as total_runs,
        COUNT(CASE WHEN extras_type != 'wides' THEN 1 END) as balls_faced
    FROM deliveries
    GROUP BY batter
)
SELECT
    batter,
    total_runs,
    balls_faced,
    (total_runs * 100.0 / balls_faced) as strike_rate
FROM BatsmanStats
WHERE balls_faced >= 500
ORDER BY strike_rate DESC
LIMIT 10;


-- 04 top bowler economy
WITH BowlerStats AS (
    SELECT
        bowler,
        SUM(total_runs - extra_runs) as runs_conceded,
        COUNT(*) as balls_bowled
    FROM deliveries
    GROUP BY bowler
)
SELECT
    bowler,
    runs_conceded,
    balls_bowled,
    (runs_conceded * 6.0 / balls_bowled) AS economy_rate
FROM BowlerStats
WHERE balls_bowled >= (50 * 6) -- 50 overs
ORDER BY economy_rate ASC
LIMIT 10;


-- 05 season orange cap
WITH SeasonRuns AS (
    SELECT
        m.season,
        d.batter,
        SUM(d.batsman_runs) as total_season_runs
    FROM matches m
    JOIN deliveries d ON m.id = d.match_id
    GROUP BY m.season, d.batter
),
RankedRuns AS (
    SELECT
        season,
        batter,
        total_season_runs,
        RANK() OVER(PARTITION BY season ORDER BY total_season_runs DESC) as rank_num
    FROM SeasonRuns
)
SELECT
    season,
    batter,
    total_season_runs
FROM RankedRuns
WHERE rank_num = 1
ORDER BY season;


-- 06 death over specialists
WITH DeathOverStats AS (
    SELECT
        batter,
        SUM(batsman_runs) as runs_in_death,
        COUNT(CASE WHEN extras_type != 'wides' THEN 1 END) as balls_in_death
    FROM deliveries
    WHERE `over` >= 16
    GROUP BY batter
)
SELECT
    batter,
    runs_in_death,
    balls_in_death,
    (runs_in_death * 100.0 / balls_in_death) as death_over_strike_rate
FROM DeathOverStats
WHERE balls_in_death >= 100
ORDER BY death_over_strike_rate DESC
LIMIT 10;


