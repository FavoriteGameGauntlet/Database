CREATE OR REPLACE FUNCTION create_current_timer(p_user_id INTEGER, p_game_id INTEGER, p_duration_in_s INTEGER)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO Timers (UserId, GameId, DurationInS, RemainingTimeInS)
    VALUES (p_user_id, p_game_id, p_duration_in_s, p_duration_in_s)
$$;
