CREATE OR REPLACE FUNCTION does_wishlist_game_exist(p_user_id INTEGER, p_name TEXT)
RETURNS BOOLEAN
LANGUAGE sql AS $$
    SELECT EXISTS (
        SELECT 1
        FROM UnplayedGames ug
            INNER JOIN Games g ON ug.GameId = g.Id
        WHERE ug.UserId = p_user_id
            AND g.Name = p_name
    )
$$;
