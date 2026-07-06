CREATE OR REPLACE FUNCTION get_point_info(_user_id INTEGER)
RETURNS TABLE(territorypoints INTEGER, freepoints INTEGER)
LANGUAGE sql AS $$
    SELECT TerritoryPoints, FreePoints
    FROM UserStats
    WHERE UserId = _user_id
$$;
