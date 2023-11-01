 /* Which team performed higher number of fifties season wise?*/
      SELECT 
   b.player_batting_id, t.name,
   b.Name,
   s.psl_session,
      subquery.total_fifties
FROM (
    SELECT 
       player_batting_id,t.name,
       s.PSL_SESSION,
       sum(fifties) as total_fifties,
       RANK() OVER (PARTITION BY s.PSL_SESSION ORDER BY sum(fifties) DESC) AS row_num
    FROM psl.batting b
    JOIN season s ON s.Season_Id = b.season_id
    join team t on t.team_id = b.Team_Id
    GROUP BY player_batting_id, s.PSL_SESSION
) subquery
JOIN psl.batting b ON b.player_batting_id = subquery.player_batting_id
JOIN season s ON s.Season_Id = b.season_id
join team t on t.team_id = b.Team_Id
WHERE subquery.row_num <= 1;
