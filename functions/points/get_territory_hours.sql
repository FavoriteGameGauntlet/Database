CREATE OR REPLACE FUNCTION get_territory_hours(_user_id INTEGER)
RETURNS TABLE(territoryhours INTEGER)
LANGUAGE sql AS $$
    SELECT TerritoryHours FROM UserStats WHERE UserId = _user_id
$$;
