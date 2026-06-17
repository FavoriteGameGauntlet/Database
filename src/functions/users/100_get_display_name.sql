CREATE OR REPLACE FUNCTION get_display_name(_user_id INTEGER)
RETURNS TABLE(displayname TEXT)
LANGUAGE sql AS $$
    SELECT DisplayName FROM Users WHERE Id = _user_id
$$;
