CREATE OR REPLACE FUNCTION change_display_name(p_user_id INTEGER, p_display_name TEXT)
RETURNS void
LANGUAGE sql AS $$
    UPDATE Users SET DisplayName = p_display_name WHERE Id = p_user_id
$$;
