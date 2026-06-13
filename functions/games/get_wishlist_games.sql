CREATE OR REPLACE FUNCTION get_wishlist_games(p_user_id INTEGER)
RETURNS TABLE(id INTEGER, game_id INTEGER, name TEXT)
LANGUAGE sql AS $$
    SELECT ug.Id, g.Id, g.Name
    FROM UnplayedGames ug
        INNER JOIN Games g ON ug.GameId = g.Id
    WHERE ug.UserId = p_user_id
$$;
