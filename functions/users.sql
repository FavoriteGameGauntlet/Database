CREATE OR REPLACE FUNCTION get_display_name(p_user_id INTEGER)
RETURNS TABLE(displayname TEXT)
LANGUAGE sql AS $$
    SELECT DisplayName FROM Users WHERE Id = p_user_id
$$;

CREATE OR REPLACE FUNCTION get_all_user_names()
RETURNS TABLE(login TEXT, displayname TEXT)
LANGUAGE sql AS $$
    SELECT Login, DisplayName FROM Users
$$;

CREATE OR REPLACE FUNCTION change_display_name(p_user_id INTEGER, p_display_name TEXT)
RETURNS void
LANGUAGE sql AS $$
    UPDATE Users SET DisplayName = p_display_name WHERE Id = p_user_id
$$;
