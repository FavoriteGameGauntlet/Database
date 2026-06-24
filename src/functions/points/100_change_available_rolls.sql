CREATE OR REPLACE FUNCTION change_available_rolls(_user_id INTEGER, _change_value INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET AvailableRolls = AvailableRolls + _change_value WHERE UserId = _user_id
$$;
