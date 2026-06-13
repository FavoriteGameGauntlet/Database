CREATE OR REPLACE FUNCTION create_user_stats(p_login TEXT)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO UserStats (UserId) SELECT Id FROM Users WHERE Login = p_login
$$;
