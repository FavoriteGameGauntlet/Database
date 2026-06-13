CREATE OR REPLACE FUNCTION delete_user_session(_id TEXT)
RETURNS void
LANGUAGE sql AS $$
    DELETE FROM UserSessions WHERE Id = _id
$$;
