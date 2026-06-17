CREATE OR REPLACE FUNCTION create_current_timer(_user_id INTEGER, _game_id INTEGER, _duration_in_s INTEGER)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO Timers (UserId, GameId, DurationInS, RemainingTimeInS)
    VALUES (_user_id, _game_id, _duration_in_s, _duration_in_s)
$$;
