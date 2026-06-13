CREATE OR REPLACE FUNCTION finish_current_game(p_user_id INTEGER, p_game_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE GameHistory
    SET State = 'finished', FinishDate = NOW()
    WHERE UserId = p_user_id AND GameId = p_game_id
$$;
