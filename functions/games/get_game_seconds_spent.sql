CREATE OR REPLACE FUNCTION get_game_seconds_spent(p_user_id INTEGER, p_game_id INTEGER)
RETURNS INTEGER
LANGUAGE sql AS $$
    SELECT COALESCE(
        SUM(
            t.DurationInS -
            CASE t.State
                WHEN 'running' THEN t.RemainingTimeInS - CAST(EXTRACT(EPOCH FROM (NOW() - t.LastActionDate)) AS INTEGER)
                WHEN 'paused'  THEN t.RemainingTimeInS
                WHEN 'finished' THEN t.RemainingTimeInS
                ELSE t.DurationInS
            END
        ),
        0
    )
    FROM Timers t
    WHERE t.UserId = p_user_id
        AND t.GameId = p_game_id
$$;
