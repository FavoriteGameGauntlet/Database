CREATE OR REPLACE FUNCTION increase_available_rolls(_user_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET AvailableRolls = AvailableRolls + 1 WHERE UserId = _user_id
$$;
