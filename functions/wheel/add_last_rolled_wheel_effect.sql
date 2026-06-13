CREATE OR REPLACE FUNCTION add_last_rolled_wheel_effect(p_user_id INTEGER, p_effect_id INTEGER, p_position INTEGER)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO LastWheelEffects (UserId, WheelEffectId, Position) VALUES (p_user_id, p_effect_id, p_position)
$$;
