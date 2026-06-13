CREATE OR REPLACE FUNCTION act_timer(p_timer_id INTEGER, p_state TEXT, p_remaining_time_in_s INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE Timers
    SET State = p_state, RemainingTimeInS = p_remaining_time_in_s, LastActionDate = NOW()
    WHERE Id = p_timer_id
$$;
