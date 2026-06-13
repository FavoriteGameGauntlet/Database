CREATE OR REPLACE FUNCTION decrease_available_rolls(p_user_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET AvailableRolls = AvailableRolls - 1 WHERE UserId = p_user_id
$$;
