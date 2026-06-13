CREATE OR REPLACE FUNCTION get_wishlist_games(_user_id INTEGER)
RETURNS TABLE(id INTEGER, game_id INTEGER, name TEXT)
LANGUAGE sql AS $$
    SELECT ug.Id, g.Id, g.Name
    FROM WishlistGames ug
        INNER JOIN Games g ON ug.GameId = g.Id
    WHERE ug.UserId = _user_id
$$;
