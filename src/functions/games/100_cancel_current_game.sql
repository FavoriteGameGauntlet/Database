CREATE OR REPLACE FUNCTION cancel_current_game(_user_id INTEGER, _game_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE GameHistory
    SET State = 'cancelled', FinishDate = NOW()
    WHERE UserId = _user_id AND GameId = _game_id
$$;
