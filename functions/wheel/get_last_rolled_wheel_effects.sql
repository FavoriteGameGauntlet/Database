CREATE OR REPLACE FUNCTION get_last_rolled_wheel_effects(p_user_id INTEGER)
RETURNS TABLE(id INTEGER, name TEXT, description TEXT, roll_date TIMESTAMP, effect_position INTEGER, is_applied INTEGER)
LANGUAGE sql AS $$
    SELECT we.Id, we.Name, we.Description, lwe.RollDate, lwe.Position, lwe.IsApplied
    FROM LastWheelEffects lwe
        INNER JOIN WheelEffects we ON we.Id = lwe.WheelEffectId
    WHERE lwe.UserId = p_user_id
$$;
