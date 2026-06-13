CREATE OR REPLACE FUNCTION get_experience_points(p_user_id INTEGER)
RETURNS TABLE(experiencepoints INTEGER)
LANGUAGE sql AS $$
    SELECT ExperiencePoints FROM UserStats WHERE UserId = p_user_id
$$;
