CREATE OR REPLACE FUNCTION create_wishlist_game(p_user_id INTEGER, p_game_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO UnplayedGames (UserId, GameId) VALUES (p_user_id, p_game_id)
$$;
