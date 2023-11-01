-- highest wicket taker per season 
SELECT 
    subquery.player_name,
    subquery.team_name,
    subquery.Season,
    subquery.wickets
FROM (
    SELECT 
        p.name AS player_name,
        t.name AS team_name,
        s.PSL_session AS Season,
        bw.wickets,
        ROW_NUMBER() OVER (PARTITION BY s.PSL_session ORDER BY bw.wickets DESC) AS row_num
    FROM Players AS p
    JOIN Bowling AS bw ON p.player_id = bw.player_id
    JOIN PlayerTeam AS pt ON p.player_id = pt.player_id AND bw.season_id = pt.season_id
    JOIN Team AS t ON pt.team_id = t.team_id
    JOIN Season AS s ON bw.season_id = s.Season_id
) subquery
WHERE subquery.row_num = 1 -- Only get the highest wicket taker for each season
ORDER BY subquery.Season, subquery.wickets DESC;