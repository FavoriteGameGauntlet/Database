CREATE OR REPLACE FUNCTION add_last_rolled_wheel_effect(_user_id INTEGER, _effect_id INTEGER, _position INTEGER)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO LastWheelEffects (UserId, WheelEffectId, Position) VALUES (_user_id, _effect_id, _position)
$$;
