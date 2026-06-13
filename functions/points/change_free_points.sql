CREATE OR REPLACE FUNCTION change_free_points(_user_id INTEGER, _change_value INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET FreePoints = FreePoints + _change_value WHERE UserId = _user_id
$$;
