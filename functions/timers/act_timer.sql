CREATE OR REPLACE FUNCTION act_timer(_timer_id INTEGER, _state TEXT, _remaining_time_in_s INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE Timers
    SET State = _state, RemainingTimeInS = _remaining_time_in_s, LastActionDate = NOW()
    WHERE Id = _timer_id
$$;
