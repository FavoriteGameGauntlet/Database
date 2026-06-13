CREATE OR REPLACE FUNCTION get_user_by_email(p_email TEXT)
RETURNS TABLE(id INTEGER, login TEXT, displayname TEXT, email TEXT)
LANGUAGE sql AS $$
    SELECT Id, Login, DisplayName, Email FROM Users WHERE Email = p_email
$$;
