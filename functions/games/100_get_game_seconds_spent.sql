CREATE OR REPLACE FUNCTION get_game_seconds_spent(_user_id INTEGER, _game_id INTEGER)
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
    WHERE t.UserId = _user_id
        AND t.GameId = _game_id
$$;
