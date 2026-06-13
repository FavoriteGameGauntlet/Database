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
