CREATE OR REPLACE FUNCTION get_available_rolls_count(p_user_id INTEGER)
RETURNS TABLE(availablerolls INTEGER)
LANGUAGE sql AS $$
    SELECT AvailableRolls FROM UserStats WHERE UserId = p_user_id
$$;

CREATE OR REPLACE FUNCTION get_available_effects(p_user_id INTEGER)
RETURNS TABLE(id INTEGER, name TEXT, description TEXT)
LANGUAGE sql AS $$
    SELECT we.Id, we.Name, we.Description
    FROM WheelEffects we
    WHERE NOT EXISTS (
        SELECT 1
        FROM WheelEffectHistory weh
        WHERE weh.WheelEffectId = we.Id
            AND weh.UserId = p_user_id)
        AND NOT EXISTS (
            SELECT 1
            FROM LastWheelEffects lwe
            WHERE lwe.WheelEffectId = we.Id
                AND lwe.UserId = p_user_id
                AND lwe.Position = 0)
$$;

CREATE OR REPLACE FUNCTION get_effect_history(p_user_id INTEGER)
RETURNS TABLE(name TEXT, description TEXT, roll_date TIMESTAMP)
LANGUAGE sql AS $$
    SELECT we.Name, we.Description, weh.RollDate
    FROM WheelEffectHistory weh
        INNER JOIN WheelEffects we ON weh.WheelEffectId = we.Id
    WHERE weh.UserId = p_user_id
$$;

CREATE OR REPLACE FUNCTION get_effect_history_by_name(p_user_id INTEGER, p_effect_name TEXT)
RETURNS TABLE(name TEXT, description TEXT, roll_date TIMESTAMP)
LANGUAGE sql AS $$
    SELECT we.Name, we.Description, weh.RollDate
    FROM WheelEffectHistory weh
        INNER JOIN WheelEffects we ON weh.WheelEffectId = we.Id
    WHERE weh.UserId = p_user_id
        AND we.Name = p_effect_name
    ORDER BY weh.RollDate DESC
    LIMIT 1
$$;

CREATE OR REPLACE FUNCTION make_effect_roll(p_user_id INTEGER)
RETURNS TABLE(id INTEGER, name TEXT, description TEXT)
LANGUAGE sql AS $$
    SELECT we.Id, we.Name, we.Description
    FROM WheelEffects we
    WHERE NOT EXISTS (
        SELECT 1
        FROM WheelEffectHistory weh
        WHERE weh.WheelEffectId = we.Id
            AND weh.UserId = p_user_id)
        AND NOT EXISTS (
            SELECT 1
            FROM LastWheelEffects lwe
            WHERE lwe.WheelEffectId = we.Id
                AND lwe.UserId = p_user_id
                AND lwe.Position = 0)
    ORDER BY RANDOM()
    LIMIT 5
$$;

CREATE OR REPLACE FUNCTION decrease_available_rolls(p_user_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET AvailableRolls = AvailableRolls - 1 WHERE UserId = p_user_id
$$;

CREATE OR REPLACE FUNCTION add_last_rolled_wheel_effect(p_user_id INTEGER, p_effect_id INTEGER, p_position INTEGER)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO LastWheelEffects (UserId, WheelEffectId, Position) VALUES (p_user_id, p_effect_id, p_position)
$$;

CREATE OR REPLACE FUNCTION get_last_rolled_wheel_effects(p_user_id INTEGER)
RETURNS TABLE(id INTEGER, name TEXT, description TEXT, roll_date TIMESTAMP, position INTEGER, is_applied INTEGER)
LANGUAGE sql AS $$
    SELECT we.Id, we.Name, we.Description, lwe.RollDate, lwe.Position, lwe.IsApplied
    FROM LastWheelEffects lwe
        INNER JOIN WheelEffects we ON we.Id = lwe.WheelEffectId
    WHERE lwe.UserId = p_user_id
$$;

CREATE OR REPLACE FUNCTION mark_last_wheel_effect_applied(p_user_id INTEGER, p_wheel_effect_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE LastWheelEffects SET IsApplied = 1
    WHERE UserId = p_user_id AND WheelEffectId = p_wheel_effect_id
$$;

CREATE OR REPLACE FUNCTION add_wheel_effect_history(p_user_id INTEGER, p_wheel_effect_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO WheelEffectHistory (UserId, WheelEffectId) VALUES (p_user_id, p_wheel_effect_id)
$$;
