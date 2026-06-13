CREATE OR REPLACE FUNCTION add_wheel_effect_history(p_user_id INTEGER, p_wheel_effect_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO WheelEffectHistory (UserId, WheelEffectId) VALUES (p_user_id, p_wheel_effect_id)
$$;
