CREATE OR REPLACE FUNCTION get_user_by_login(p_login TEXT)
RETURNS TABLE(id INTEGER, login TEXT, displayname TEXT, email TEXT)
LANGUAGE sql AS $$
    SELECT Id, Login, DisplayName, Email FROM Users WHERE Login = p_login
$$;

CREATE OR REPLACE FUNCTION get_user_by_id(p_id INTEGER)
RETURNS TABLE(id INTEGER, login TEXT, displayname TEXT, email TEXT)
LANGUAGE sql AS $$
    SELECT Id, Login, DisplayName, Email FROM Users WHERE Id = p_id
$$;

CREATE OR REPLACE FUNCTION get_user_by_email(p_email TEXT)
RETURNS TABLE(id INTEGER, login TEXT, displayname TEXT, email TEXT)
LANGUAGE sql AS $$
    SELECT Id, Login, DisplayName, Email FROM Users WHERE Email = p_email
$$;

CREATE OR REPLACE FUNCTION get_user_by_login_and_password(p_login TEXT, p_password TEXT)
RETURNS TABLE(id INTEGER, login TEXT, displayname TEXT, email TEXT)
LANGUAGE sql AS $$
    SELECT Id, Login, DisplayName, Email FROM Users WHERE Login = p_login AND Password = p_password
$$;

CREATE OR REPLACE FUNCTION create_user(p_login TEXT, p_email TEXT, p_password TEXT)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO Users (Login, Email, Password) VALUES (p_login, p_email, p_password)
$$;

CREATE OR REPLACE FUNCTION create_user_stats(p_login TEXT)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO UserStats (UserId) SELECT Id FROM Users WHERE Login = p_login
$$;

CREATE OR REPLACE FUNCTION get_user_session_by_id(p_id TEXT)
RETURNS TABLE(id TEXT, userid INTEGER)
LANGUAGE sql AS $$
    SELECT Id, UserId FROM UserSessions WHERE Id = p_id
$$;

CREATE OR REPLACE FUNCTION create_user_session(p_user_id INTEGER)
RETURNS TABLE(id TEXT, userid INTEGER)
LANGUAGE sql AS $$
    WITH inserted AS (
        INSERT INTO UserSessions (Id, UserId) VALUES (gen_random_uuid()::TEXT, p_user_id)
        RETURNING Id, UserId
    )
    SELECT id, userid FROM inserted
$$;

CREATE OR REPLACE FUNCTION delete_user_session(p_id TEXT)
RETURNS void
LANGUAGE sql AS $$
    DELETE FROM UserSessions WHERE Id = p_id
$$;
