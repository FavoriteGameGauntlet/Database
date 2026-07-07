CREATE OR REPLACE FUNCTION get_all_current_games()
RETURNS TABLE(id INTEGER, name TEXT, state TEXT, start_date TIMESTAMP, finish_date TIMESTAMP, login TEXT)
LANGUAGE sql AS $$
    SELECT g.Id, g.Name, gh.State, gh.StartDate, gh.FinishDate, u.Login
    FROM GameHistory gh
        INNER JOIN Games g ON gh.GameId = g.Id
        INNER JOIN Users u ON gh.UserId = u.Id
    WHERE gh.State NOT IN ('finished', 'cancelled')
$$;
