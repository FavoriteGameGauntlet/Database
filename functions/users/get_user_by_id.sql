CREATE OR REPLACE FUNCTION get_user_by_id(p_id INTEGER)
RETURNS TABLE(id INTEGER, login TEXT, displayname TEXT, email TEXT)
LANGUAGE sql AS $$
    SELECT Id, Login, DisplayName, Email FROM Users WHERE Id = p_id
$$;
