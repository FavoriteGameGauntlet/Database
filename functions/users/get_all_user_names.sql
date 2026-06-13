CREATE OR REPLACE FUNCTION get_all_user_names()
RETURNS TABLE(login TEXT, displayname TEXT)
LANGUAGE sql AS $$
    SELECT Login, DisplayName FROM Users
$$;
