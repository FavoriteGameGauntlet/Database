CREATE OR REPLACE FUNCTION delete_wishlist_game(p_user_id INTEGER, p_game_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    DELETE FROM UnplayedGames WHERE UserId = p_user_id AND GameId = p_game_id
$$;
