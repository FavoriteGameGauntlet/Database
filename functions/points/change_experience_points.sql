CREATE OR REPLACE FUNCTION change_experience_points(_user_id INTEGER, _change_value INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET ExperiencePoints = ExperiencePoints + _change_value WHERE UserId = _user_id
$$;
