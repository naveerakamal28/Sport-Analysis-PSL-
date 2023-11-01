/* Which players have the most catches and stumpings in a season */


/*
SELECT
    p.name AS player_name,
    s.psl_session,
    SUM(b.catches) AS total_catches,
    SUM(b.stumps) AS total_stumps
FROM
    Bowling b
JOIN
    Players p ON b.player_id = p.player_id
JOIN
    Season s ON b.season_id = s.Season_id
GROUP BY
    b.season_id, p.player_id
ORDER BY
    b.season_id, total_catches DESC, total_stumps DESC 
    */
    
    
    SELECT
    ranked_data.player_name,
    ranked_data.season_name,
   -- ranked_data.season_id,
    ranked_data.total_catches,
    ranked_data.total_stumps,
    ranked_data.catches_rank,
    ranked_data.stumps_rank
FROM (
    SELECT
        p.name AS player_name,
        s.psl_session as Season_name,
        b.season_id,
        SUM(b.catches) AS total_catches,
        SUM(b.stumps) AS total_stumps,
        ROW_NUMBER() OVER (PARTITION BY b.season_id ORDER BY SUM(b.catches) DESC) AS catches_rank,
        ROW_NUMBER() OVER (PARTITION BY b.season_id ORDER BY SUM(b.stumps) DESC) AS stumps_rank
    FROM
        Bowling b
    JOIN
        Players p ON b.player_id = p.player_id
    JOIN
        Season s ON b.season_id = s.Season_id
    GROUP BY
        b.season_id, p.player_id, p.name, s.psl_session
) AS ranked_data

ORDER BY
    ranked_data.season_id, 
    ranked_data.catches_rank, 
    ranked_data.stumps_rank 







