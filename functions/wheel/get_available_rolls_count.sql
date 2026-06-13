CREATE OR REPLACE FUNCTION get_available_rolls_count(p_user_id INTEGER)
RETURNS TABLE(availablerolls INTEGER)
LANGUAGE sql AS $$
    SELECT AvailableRolls FROM UserStats WHERE UserId = p_user_id
$$;
