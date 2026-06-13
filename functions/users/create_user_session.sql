CREATE OR REPLACE FUNCTION create_user_session(p_user_id INTEGER)
RETURNS TABLE(id TEXT, userid INTEGER)
LANGUAGE sql AS $$
    WITH inserted AS (
        INSERT INTO UserSessions (Id, UserId) VALUES (gen_random_uuid()::TEXT, p_user_id)
        RETURNING Id, UserId
    )
    SELECT id, userid FROM inserted
$$;
