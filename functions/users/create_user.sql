CREATE OR REPLACE FUNCTION create_user(_login TEXT, _email TEXT, _password TEXT)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO Users (Login, Email, Password) VALUES (_login, _email, _password)
$$;
