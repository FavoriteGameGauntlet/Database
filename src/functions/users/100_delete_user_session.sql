CREATE OR REPLACE FUNCTION delete_user_session(_id TEXT)
RETURNS void
LANGUAGE sql AS $$
DELETE
FROM common.UserSessions
WHERE Id = _id
$$;
