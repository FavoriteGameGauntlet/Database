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
