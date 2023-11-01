/* Which player has the highest batting average? */

WITH PlayerPerformance AS (
    SELECT
        p.name,
        AVG(pb.runs) AS avg_runs
        -- AVG(pbl.wickets) AS avg_wickets
    FROM Players p
    LEFT JOIN Batting pb ON p.player_id = pb.player_id
    -- LEFT JOIN Bowling pbl ON p.player_id = pbl.player_id
    GROUP BY p.name
)
SELECT
    name,
     AVG(avg_runs) AS avg_batting
FROM PlayerPerformance
GROUP BY name
ORDER BY avg_batting desc
 LIMIT 5;


