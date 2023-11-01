-- Which player has the highest bowling average? 
WITH PlayerPerformance AS (
    SELECT
        p.name,
        AVG(pb.runs) AS avg_runs,
        AVG(pbl.wickets/pbl.matches) AS avg_wickets
    FROM Players p
    LEFT JOIN Batting pb ON p.player_id = pb.player_id
    LEFT JOIN Bowling pbl ON p.player_id = pbl.player_id
    GROUP BY p.name
)
SELECT
    name,
    AVG(avg_wickets) AS avg_bowling
FROM PlayerPerformance
GROUP BY name
ORDER BY  avg_bowling desc
 LIMIT 5;
