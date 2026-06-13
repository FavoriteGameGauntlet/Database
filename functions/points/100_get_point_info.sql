CREATE OR REPLACE FUNCTION get_point_info(_user_id INTEGER)
RETURNS TABLE(territorypoints INTEGER, freepoints INTEGER, availablerolls INTEGER, territoryhours INTEGER, experiencepoints INTEGER)
LANGUAGE sql AS $$
    SELECT TerritoryPoints, FreePoints, AvailableRolls, TerritoryHours, ExperiencePoints
    FROM UserStats
    WHERE UserId = _user_id
$$;
