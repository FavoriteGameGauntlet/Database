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

CREATE OR REPLACE FUNCTION create_current_timer(p_user_id INTEGER, p_game_id INTEGER, p_duration_in_s INTEGER)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO Timers (UserId, GameId, DurationInS, RemainingTimeInS)
    VALUES (p_user_id, p_game_id, p_duration_in_s, p_duration_in_s)
$$;

CREATE OR REPLACE FUNCTION act_timer(p_timer_id INTEGER, p_state TEXT, p_remaining_time_in_s INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE Timers
    SET State = p_state, RemainingTimeInS = p_remaining_time_in_s, LastActionDate = NOW()
    WHERE Id = p_timer_id
$$;

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
