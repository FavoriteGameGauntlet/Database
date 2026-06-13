CREATE OR REPLACE FUNCTION get_point_info(p_user_id INTEGER)
RETURNS TABLE(territorypoints INTEGER, freepoints INTEGER, availablerolls INTEGER, territoryhours INTEGER, experiencepoints INTEGER)
LANGUAGE sql AS $$
    SELECT TerritoryPoints, FreePoints, AvailableRolls, TerritoryHours, ExperiencePoints
    FROM UserStats
    WHERE UserId = p_user_id
$$;
