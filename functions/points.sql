CREATE OR REPLACE FUNCTION get_experience_points(p_user_id INTEGER)
RETURNS TABLE(experiencepoints INTEGER)
LANGUAGE sql AS $$
    SELECT ExperiencePoints FROM UserStats WHERE UserId = p_user_id
$$;

CREATE OR REPLACE FUNCTION change_experience_points(p_user_id INTEGER, p_change_value INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET ExperiencePoints = ExperiencePoints + p_change_value WHERE UserId = p_user_id
$$;

CREATE OR REPLACE FUNCTION get_territory_hours(p_user_id INTEGER)
RETURNS TABLE(territoryhours INTEGER)
LANGUAGE sql AS $$
    SELECT TerritoryHours FROM UserStats WHERE UserId = p_user_id
$$;

CREATE OR REPLACE FUNCTION change_territory_hours(p_user_id INTEGER, p_change_value INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET TerritoryHours = TerritoryHours + p_change_value WHERE UserId = p_user_id
$$;

CREATE OR REPLACE FUNCTION increase_territory_hours(p_user_id INTEGER, p_change_value INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET TerritoryHours = TerritoryHours + p_change_value WHERE UserId = p_user_id
$$;

CREATE OR REPLACE FUNCTION get_territory_points(p_user_id INTEGER)
RETURNS TABLE(territorypoints INTEGER)
LANGUAGE sql AS $$
    SELECT TerritoryPoints FROM UserStats WHERE UserId = p_user_id
$$;

CREATE OR REPLACE FUNCTION change_territory_points(p_user_id INTEGER, p_change_value INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET TerritoryPoints = TerritoryPoints + p_change_value WHERE UserId = p_user_id
$$;

CREATE OR REPLACE FUNCTION get_free_points(p_user_id INTEGER)
RETURNS TABLE(freepoints INTEGER)
LANGUAGE sql AS $$
    SELECT FreePoints FROM UserStats WHERE UserId = p_user_id
$$;

CREATE OR REPLACE FUNCTION change_free_points(p_user_id INTEGER, p_change_value INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET FreePoints = FreePoints + p_change_value WHERE UserId = p_user_id
$$;

CREATE OR REPLACE FUNCTION increase_available_rolls(p_user_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET AvailableRolls = AvailableRolls + 1 WHERE UserId = p_user_id
$$;

CREATE OR REPLACE FUNCTION get_point_info(p_user_id INTEGER)
RETURNS TABLE(territorypoints INTEGER, freepoints INTEGER, availablerolls INTEGER, territoryhours INTEGER, experiencepoints INTEGER)
LANGUAGE sql AS $$
    SELECT TerritoryPoints, FreePoints, AvailableRolls, TerritoryHours, ExperiencePoints
    FROM UserStats
    WHERE UserId = p_user_id
$$;

CREATE OR REPLACE FUNCTION get_all_point_info()
RETURNS TABLE(login TEXT, territorypoints INTEGER, freepoints INTEGER, availablerolls INTEGER, territoryhours INTEGER, experiencepoints INTEGER)
LANGUAGE sql AS $$
    SELECT u.Login, us.TerritoryPoints, us.FreePoints, us.AvailableRolls, us.TerritoryHours, us.ExperiencePoints
    FROM Users u
        INNER JOIN UserStats us ON us.UserId = u.Id
$$;

CREATE OR REPLACE FUNCTION get_territory_point_history(p_user_id INTEGER)
RETURNS TABLE(actualchangevalue INTEGER, changedate TIMESTAMP, changesource TEXT, changevalue INTEGER, finalvalue INTEGER, login TEXT)
LANGUAGE sql AS $$
    SELECT tph.ActualChangeValue, tph.ChangeDate, tph.ChangeSource, tph.ChangeValue, tph.FinalValue, u.Login
    FROM TerritoryPointHistory tph
        LEFT JOIN Users u ON u.Id = tph.SourceUserId
    WHERE tph.UserId = p_user_id
    ORDER BY tph.ChangeDate DESC
$$;

CREATE OR REPLACE FUNCTION add_territory_point_history(
    p_user_id INTEGER,
    p_source_user_id INTEGER,
    p_change_source TEXT,
    p_change_value INTEGER,
    p_actual_change_value INTEGER,
    p_final_value INTEGER
)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO TerritoryPointHistory (UserId, SourceUserId, ChangeSource, ChangeValue, ActualChangeValue, FinalValue)
    VALUES (p_user_id, p_source_user_id, p_change_source, p_change_value, p_actual_change_value, p_final_value)
$$;

CREATE OR REPLACE FUNCTION get_free_point_history(p_user_id INTEGER)
RETURNS TABLE(actualchangevalue INTEGER, changedate TIMESTAMP, changesource TEXT, changevalue INTEGER, finalvalue INTEGER, login TEXT, wheeleffectname TEXT)
LANGUAGE sql AS $$
    SELECT fph.ActualChangeValue, fph.ChangeDate, fph.ChangeSource, fph.ChangeValue, fph.FinalValue, u.Login, we.Name
    FROM FreePointHistory fph
        LEFT JOIN Users u ON u.Id = fph.SourceUserId
        LEFT JOIN WheelEffects we ON we.Id = fph.WheelEffectId
    WHERE fph.UserId = p_user_id
    ORDER BY fph.ChangeDate DESC
$$;

CREATE OR REPLACE FUNCTION add_free_point_history(
    p_user_id INTEGER,
    p_source_user_id INTEGER,
    p_change_source TEXT,
    p_change_value INTEGER,
    p_actual_change_value INTEGER,
    p_final_value INTEGER,
    p_wheel_effect_id INTEGER
)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO FreePointHistory (UserId, SourceUserId, ChangeSource, ChangeValue, ActualChangeValue, FinalValue, WheelEffectId)
    VALUES (p_user_id, p_source_user_id, p_change_source, p_change_value, p_actual_change_value, p_final_value, p_wheel_effect_id)
$$;
