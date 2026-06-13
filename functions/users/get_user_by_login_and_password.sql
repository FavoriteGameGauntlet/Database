CREATE OR REPLACE FUNCTION get_user_by_login_and_password(p_login TEXT, p_password TEXT)
RETURNS TABLE(id INTEGER, login TEXT, displayname TEXT, email TEXT)
LANGUAGE sql AS $$
    SELECT Id, Login, DisplayName, Email FROM Users WHERE Login = p_login AND Password = p_password
$$;
