CREATE OR REPLACE FUNCTION get_free_points(_user_id INTEGER)
RETURNS TABLE(freepoints INTEGER)
LANGUAGE sql AS $$
    SELECT FreePoints FROM UserStats WHERE UserId = _user_id
$$;
