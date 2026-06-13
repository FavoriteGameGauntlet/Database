CREATE OR REPLACE FUNCTION does_game_exist(p_name TEXT)
RETURNS BOOLEAN
LANGUAGE sql AS $$
    SELECT EXISTS (SELECT 1 FROM Games WHERE Name = p_name)
$$;

CREATE OR REPLACE FUNCTION create_game(p_name TEXT)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO Games (Name) VALUES (p_name)
$$;

CREATE OR REPLACE FUNCTION get_wishlist_game(p_name TEXT)
RETURNS TABLE(id INTEGER, name TEXT)
LANGUAGE sql AS $$
    SELECT Id, Name FROM Games WHERE Name = p_name
$$;

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

CREATE OR REPLACE FUNCTION create_wishlist_game(p_user_id INTEGER, p_game_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO UnplayedGames (UserId, GameId) VALUES (p_user_id, p_game_id)
$$;

CREATE OR REPLACE FUNCTION delete_wishlist_game(p_user_id INTEGER, p_game_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    DELETE FROM UnplayedGames WHERE UserId = p_user_id AND GameId = p_game_id
$$;

CREATE OR REPLACE FUNCTION get_wishlist_games(p_user_id INTEGER)
RETURNS TABLE(id INTEGER, game_id INTEGER, name TEXT)
LANGUAGE sql AS $$
    SELECT ug.Id, g.Id, g.Name
    FROM UnplayedGames ug
        INNER JOIN Games g ON ug.GameId = g.Id
    WHERE ug.UserId = p_user_id
$$;

CREATE OR REPLACE FUNCTION create_current_game(p_user_id INTEGER, p_game_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO GameHistory (UserId, GameId) VALUES (p_user_id, p_game_id)
$$;

CREATE OR REPLACE FUNCTION get_current_game(p_user_id INTEGER)
RETURNS TABLE(id INTEGER, name TEXT, state TEXT, finish_date TIMESTAMP)
LANGUAGE sql AS $$
    SELECT g.Id, g.Name, gh.State, gh.FinishDate
    FROM GameHistory gh
        INNER JOIN Games g ON gh.GameId = g.Id
    WHERE gh.UserId = p_user_id
        AND gh.State NOT IN ('finished', 'cancelled')
$$;

CREATE OR REPLACE FUNCTION get_game_seconds_spent(p_user_id INTEGER, p_game_id INTEGER)
RETURNS INTEGER
LANGUAGE sql AS $$
    SELECT COALESCE(
        SUM(
            t.DurationInS -
            CASE t.State
                WHEN 'running' THEN t.RemainingTimeInS - CAST(EXTRACT(EPOCH FROM (NOW() - t.LastActionDate)) AS INTEGER)
                WHEN 'paused'  THEN t.RemainingTimeInS
                WHEN 'finished' THEN t.RemainingTimeInS
                ELSE t.DurationInS
            END
        ),
        0
    )
    FROM Timers t
    WHERE t.UserId = p_user_id
        AND t.GameId = p_game_id
$$;

CREATE OR REPLACE FUNCTION cancel_current_game(p_user_id INTEGER, p_game_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE GameHistory
    SET State = 'cancelled', FinishDate = NOW()
    WHERE UserId = p_user_id AND GameId = p_game_id
$$;

CREATE OR REPLACE FUNCTION finish_current_game(p_user_id INTEGER, p_game_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE GameHistory
    SET State = 'finished', FinishDate = NOW()
    WHERE UserId = p_user_id AND GameId = p_game_id
$$;

CREATE OR REPLACE FUNCTION get_game_history(p_user_id INTEGER)
RETURNS TABLE(id INTEGER, name TEXT, state TEXT, finish_date TIMESTAMP)
LANGUAGE sql AS $$
    SELECT g.Id, g.Name, gh.State, gh.FinishDate
    FROM GameHistory gh
        INNER JOIN Games g ON gh.GameId = g.Id
    WHERE gh.UserId = p_user_id
        AND gh.State IN ('finished', 'cancelled')
    ORDER BY gh.FinishDate NULLS FIRST
$$;

CREATE OR REPLACE FUNCTION get_all_current_games()
RETURNS TABLE(id INTEGER, name TEXT, state TEXT, finish_date TIMESTAMP, login TEXT)
LANGUAGE sql AS $$
    SELECT g.Id, g.Name, gh.State, gh.FinishDate, u.Login
    FROM GameHistory gh
        INNER JOIN Games g ON gh.GameId = g.Id
        INNER JOIN Users u ON gh.UserId = u.Id
    WHERE gh.State NOT IN ('finished', 'cancelled')
$$;
