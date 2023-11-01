-- best average performance of all rounder
WITH RankedPlayers AS (
    SELECT
        p.name,
        bat.runs,
        bow.Wickets,
        s.PSL_SESSION,
        ROW_NUMBER() OVER (PARTITION BY p.name ORDER BY (bat.runs + bow.Wickets) DESC) AS rn
    FROM playerteam pt
    JOIN psl.players p ON p.Player_Id = pt.Player_Id
    JOIN psl.batting bat ON pt.player_id = bat.player_id
    JOIN psl.bowling bow ON pt.player_id = bow.player_id
    JOIN psl.season s ON s.Season_Id = pt.Season_Id
    WHERE bat.runs > 100 AND bow.Wickets > 5
)
SELECT name, AVG(runs) AS avg_runs, AVG(Wickets) AS avg_wickets
FROM RankedPlayers
WHERE rn = 1
GROUP BY name
order by (avg_runs + avg_wickets) desc;
