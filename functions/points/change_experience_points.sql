CREATE OR REPLACE FUNCTION change_experience_points(p_user_id INTEGER, p_change_value INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET ExperiencePoints = ExperiencePoints + p_change_value WHERE UserId = p_user_id
$$;
