SELECT 
    subquery.player_name,
    subquery.team_name,
    subquery.Season_name,
    subquery.runs,
    subquery.innings ,
    subquery.averages
FROM (
    SELECT 
        p.name AS player_name,b.innings as innings,b.average as averages,
        t.name AS team_name,
        s.PSL_SESSION AS Season_name,
        b.runs,
        ROW_NUMBER() OVER (PARTITION BY s.PSL_SESSION ORDER BY b.runs DESC) AS row_num
    FROM Players AS p
    JOIN Batting AS b ON p.player_id = b.player_id
    JOIN PlayerTeam AS pt ON p.player_id = pt.player_id AND b.season_id = pt.season_id
    JOIN Team AS t ON pt.team_id = t.team_id
    JOIN Season AS s ON b.season_id = s.Season_id
    
    WHERE b.runs != " "
) subquery
WHERE subquery.row_num <= 1;