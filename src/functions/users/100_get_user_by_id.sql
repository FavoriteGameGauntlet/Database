CREATE OR REPLACE FUNCTION get_user_by_id(_id INTEGER)
RETURNS TABLE(id INTEGER, login TEXT, displayname TEXT, email TEXT)
LANGUAGE sql AS $$
    SELECT Id, Login, DisplayName, Email FROM Users WHERE Id = _id
$$;
