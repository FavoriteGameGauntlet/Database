CREATE OR REPLACE FUNCTION get_free_points(p_user_id INTEGER)
RETURNS TABLE(freepoints INTEGER)
LANGUAGE sql AS $$
    SELECT FreePoints FROM UserStats WHERE UserId = p_user_id
$$;
