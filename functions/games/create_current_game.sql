CREATE OR REPLACE FUNCTION create_current_game(_user_id INTEGER, _game_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO GameHistory (UserId, GameId) VALUES (_user_id, _game_id)
$$;
