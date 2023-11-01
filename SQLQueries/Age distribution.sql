
SELECT 
    CASE
        WHEN pt.age BETWEEN 0 AND 18 THEN '0-18'
        WHEN pt.age BETWEEN 19 AND 25 THEN '19-25'
        WHEN pt.age BETWEEN 26 AND 35 THEN '26-35'
        WHEN pt.age > 35 THEN 'Above 35'
        ELSE 'Unknown'
    END AS age_group,
    COUNT(*) AS player_count
FROM PlayerTeam pt
GROUP BY age_group
ORDER BY age_group;