CREATE OR REPLACE FUNCTION get_territory_points(p_user_id INTEGER)
RETURNS TABLE(territorypoints INTEGER)
LANGUAGE sql AS $$
    SELECT TerritoryPoints FROM UserStats WHERE UserId = p_user_id
$$;
