CREATE OR REPLACE FUNCTION cancel_current_game(p_user_id INTEGER, p_game_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE GameHistory
    SET State = 'cancelled', FinishDate = NOW()
    WHERE UserId = p_user_id AND GameId = p_game_id
$$;
