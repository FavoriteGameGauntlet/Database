CREATE OR REPLACE FUNCTION get_completed_timer_users()
RETURNS TABLE(user_id INTEGER)
LANGUAGE sql AS $$
    SELECT DISTINCT t.UserId
    FROM Timers t
    WHERE t.State NOT IN ('created', 'finished')
        AND CASE t.State
            WHEN 'running' THEN t.RemainingTimeInS - CAST(EXTRACT(EPOCH FROM (NOW() - t.LastActionDate)) AS INTEGER)
            WHEN 'paused'  THEN t.RemainingTimeInS
            ELSE t.DurationInS
        END <= 0
$$;
