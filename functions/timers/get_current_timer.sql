CREATE OR REPLACE FUNCTION get_current_timer(p_user_id INTEGER)
RETURNS TABLE(id INTEGER, state TEXT, duration_in_s INTEGER, last_action_date TIMESTAMP, remaining_time INTEGER)
LANGUAGE sql AS $$
    SELECT
        t.Id,
        t.State,
        t.DurationInS,
        t.LastActionDate,
        CASE WHEN t.State IN ('running', 'paused')
            THEN t.RemainingTimeInS
            ELSE t.DurationInS
        END AS RemainingTime
    FROM Timers t
    WHERE t.UserId = p_user_id
        AND t.State != 'finished'
$$;
