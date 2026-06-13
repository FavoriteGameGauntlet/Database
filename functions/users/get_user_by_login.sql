CREATE OR REPLACE FUNCTION get_user_by_login(p_login TEXT)
RETURNS TABLE(id INTEGER, login TEXT, displayname TEXT, email TEXT)
LANGUAGE sql AS $$
    SELECT Id, Login, DisplayName, Email FROM Users WHERE Login = p_login
$$;
