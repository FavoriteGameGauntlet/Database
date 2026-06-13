CREATE OR REPLACE FUNCTION get_territory_hours(p_user_id INTEGER)
RETURNS TABLE(territoryhours INTEGER)
LANGUAGE sql AS $$
    SELECT TerritoryHours FROM UserStats WHERE UserId = p_user_id
$$;
