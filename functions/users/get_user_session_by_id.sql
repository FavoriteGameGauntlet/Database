CREATE OR REPLACE FUNCTION get_user_session_by_id(p_id TEXT)
RETURNS TABLE(id TEXT, userid INTEGER)
LANGUAGE sql AS $$
    SELECT Id, UserId FROM UserSessions WHERE Id = p_id
$$;
