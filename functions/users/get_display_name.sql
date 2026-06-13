CREATE OR REPLACE FUNCTION get_display_name(p_user_id INTEGER)
RETURNS TABLE(displayname TEXT)
LANGUAGE sql AS $$
    SELECT DisplayName FROM Users WHERE Id = p_user_id
$$;
