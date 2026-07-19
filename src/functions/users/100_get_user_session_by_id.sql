CREATE OR REPLACE FUNCTION get_user_session_by_id(_id TEXT)
  RETURNS TABLE (
    id      TEXT,
    user_id INTEGER
  )
LANGUAGE sql AS $$
SELECT Id, UserId
FROM common.UserSessions
WHERE Id = _id
$$;
