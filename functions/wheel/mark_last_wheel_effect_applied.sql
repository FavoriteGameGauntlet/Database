CREATE OR REPLACE FUNCTION mark_last_wheel_effect_applied(p_user_id INTEGER, p_wheel_effect_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE LastWheelEffects SET IsApplied = 1
    WHERE UserId = p_user_id AND WheelEffectId = p_wheel_effect_id
$$;
