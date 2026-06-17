CREATE OR REPLACE FUNCTION get_user_session_by_id(_id TEXT)
RETURNS TABLE(id TEXT, userid INTEGER)
LANGUAGE sql AS $$
    SELECT Id, UserId FROM UserSessions WHERE Id = _id
$$;
