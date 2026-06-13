CREATE OR REPLACE FUNCTION change_display_name(_user_id INTEGER, _display_name TEXT)
RETURNS void
LANGUAGE sql AS $$
    UPDATE Users SET DisplayName = _display_name WHERE Id = _user_id
$$;
