CREATE OR REPLACE FUNCTION create_user(p_login TEXT, p_email TEXT, p_password TEXT)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO Users (Login, Email, Password) VALUES (p_login, p_email, p_password)
$$;
