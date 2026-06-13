CREATE OR REPLACE FUNCTION mark_last_wheel_effect_applied(_user_id INTEGER, _wheel_effect_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE LastWheelEffects SET IsApplied = 1
    WHERE UserId = _user_id AND WheelEffectId = _wheel_effect_id
$$;
