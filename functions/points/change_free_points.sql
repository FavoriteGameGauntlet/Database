CREATE OR REPLACE FUNCTION change_free_points(p_user_id INTEGER, p_change_value INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET FreePoints = FreePoints + p_change_value WHERE UserId = p_user_id
$$;
