CREATE OR REPLACE FUNCTION get_territory_points(_user_id INTEGER)
RETURNS TABLE(territorypoints INTEGER)
LANGUAGE sql AS $$
    SELECT TerritoryPoints FROM UserStats WHERE UserId = _user_id
$$;
