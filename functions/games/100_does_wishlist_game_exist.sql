CREATE OR REPLACE FUNCTION does_wishlist_game_exist(_user_id INTEGER, _name TEXT)
RETURNS BOOLEAN
LANGUAGE sql AS $$
    SELECT EXISTS (
        SELECT 1
        FROM WishlistGames ug
            INNER JOIN Games g ON ug.GameId = g.Id
        WHERE ug.UserId = _user_id
            AND g.Name = _name
    )
$$;
