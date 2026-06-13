CREATE OR REPLACE FUNCTION get_effect_history(p_user_id INTEGER)
RETURNS TABLE(name TEXT, description TEXT, roll_date TIMESTAMP)
LANGUAGE sql AS $$
    SELECT we.Name, we.Description, weh.RollDate
    FROM WheelEffectHistory weh
        INNER JOIN WheelEffects we ON weh.WheelEffectId = we.Id
    WHERE weh.UserId = p_user_id
$$;
