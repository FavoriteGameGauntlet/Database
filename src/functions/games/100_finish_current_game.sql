CREATE OR REPLACE FUNCTION finish_current_game(_user_id INTEGER, _game_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE GameHistory
    SET State = 'finished', FinishDate = NOW()
    WHERE UserId = _user_id AND GameId = _game_id
$$;
