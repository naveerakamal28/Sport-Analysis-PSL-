/*     What age of team player performed well season wise */
/*Impact of Player Age on Performance in Each Season */

SELECT
    pt.season_id,
    s.psl_session,
    pt.age AS player_age,
    AVG(b.runs) AS avg_runs,
    AVG(bo.wickets) AS avg_wickets
FROM
    PlayerTeam pt
JOIN
    Batting b ON pt.player_id = b.player_id AND pt.season_id = b.season_id
JOIN
    Bowling bo ON pt.player_id = bo.player_id AND pt.season_id = bo.season_id
JOIN
    Season s ON pt.season_id = s.Season_id
GROUP BY
    pt.season_id, s.psl_session, pt.age
ORDER BY
    pt.season_id, pt.age;