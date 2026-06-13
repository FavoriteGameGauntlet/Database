CREATE OR REPLACE FUNCTION get_user_by_login_and_password(_login TEXT, _password TEXT)
RETURNS TABLE(id INTEGER, login TEXT, displayname TEXT, email TEXT)
LANGUAGE sql AS $$
    SELECT Id, Login, DisplayName, Email FROM Users WHERE Login = _login AND Password = _password
$$;
