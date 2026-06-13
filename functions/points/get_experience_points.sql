CREATE OR REPLACE FUNCTION get_experience_points(_user_id INTEGER)
RETURNS TABLE(experiencepoints INTEGER)
LANGUAGE sql AS $$
    SELECT ExperiencePoints FROM UserStats WHERE UserId = _user_id
$$;
