CREATE OR REPLACE FUNCTION get_current_game(p_user_id INTEGER)
RETURNS TABLE(id INTEGER, name TEXT, state TEXT, finish_date TIMESTAMP)
LANGUAGE sql AS $$
    SELECT g.Id, g.Name, gh.State, gh.FinishDate
    FROM GameHistory gh
        INNER JOIN Games g ON gh.GameId = g.Id
    WHERE gh.UserId = p_user_id
        AND gh.State NOT IN ('finished', 'cancelled')
$$;
