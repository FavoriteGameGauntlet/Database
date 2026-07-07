CREATE OR REPLACE FUNCTION get_game_history(_user_id INTEGER)
RETURNS TABLE(id INTEGER, name TEXT, state TEXT, start_date TIMESTAMP, finish_date TIMESTAMP)
LANGUAGE sql AS $$
    SELECT g.Id, g.Name, gh.State, gh.StartDate, gh.FinishDate
    FROM GameHistory gh
        INNER JOIN Games g ON gh.GameId = g.Id
    WHERE gh.UserId = _user_id
        AND gh.State IN ('finished', 'cancelled')
    ORDER BY gh.FinishDate NULLS FIRST
$$;
