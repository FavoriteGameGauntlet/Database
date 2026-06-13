CREATE OR REPLACE FUNCTION get_available_rolls_count(_user_id INTEGER)
RETURNS TABLE(availablerolls INTEGER)
LANGUAGE sql AS $$
    SELECT AvailableRolls FROM UserStats WHERE UserId = _user_id
$$;
