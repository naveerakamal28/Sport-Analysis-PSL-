use psl;
SELECT
    name,
    psl_session,
    -- win_loss_ratio,
    nrr,
    points,
    RANK() OVER(PARTITION BY psl_session ORDER BY nrr DESC, points DESC) AS performance_rank
FROM (
    SELECT
        t.name,
        s.PSL_session,
        pr.matches,
         pr.win,
        pr.loss,
         pr.tie,
        pr.no_result,
        pr.points,
        pr.nrr,
        pr.for,
        pr.against,
        pr.rank,
        CASE
            WHEN pr.loss = 0 THEN pr.win
            ELSE pr.win / pr.loss
        END AS win_loss_ratio
    FROM
        Team t
    JOIN
        Performance pr ON t.team_id = pr.team_id
    JOIN
        Season s ON pr.season_id = s.season_id
) AS team_performance
ORDER BY
    psl_session, performance_rank;