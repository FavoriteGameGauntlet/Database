CREATE OR REPLACE FUNCTION clear_last_wheel_effects(_user_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    DELETE FROM LastWheelEffects WHERE UserId = _user_id
$$;
