CREATE OR REPLACE FUNCTION delete_user_session(p_id TEXT)
RETURNS void
LANGUAGE sql AS $$
    DELETE FROM UserSessions WHERE Id = p_id
$$;
