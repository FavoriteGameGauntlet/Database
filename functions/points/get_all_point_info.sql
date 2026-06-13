CREATE OR REPLACE FUNCTION get_all_point_info()
RETURNS TABLE(login TEXT, territorypoints INTEGER, freepoints INTEGER, availablerolls INTEGER, territoryhours INTEGER, experiencepoints INTEGER)
LANGUAGE sql AS $$
    SELECT u.Login, us.TerritoryPoints, us.FreePoints, us.AvailableRolls, us.TerritoryHours, us.ExperiencePoints
    FROM Users u
        INNER JOIN UserStats us ON us.UserId = u.Id
$$;
