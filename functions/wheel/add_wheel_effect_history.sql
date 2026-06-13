CREATE OR REPLACE FUNCTION add_wheel_effect_history(_user_id INTEGER, _wheel_effect_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO WheelEffectHistory (UserId, WheelEffectId) VALUES (_user_id, _wheel_effect_id)
$$;
