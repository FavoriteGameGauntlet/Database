CREATE OR REPLACE FUNCTION create_user(
  _login TEXT,
  _email TEXT,
  _password TEXT
)
  RETURNS TABLE (
    id    INTEGER,
    login TEXT,
    email TEXT
  )
  LANGUAGE sql
AS
$$
INSERT INTO common.Users (Login, Email, Password)
VALUES (_login, _email, _password)
RETURNING Id, Login, Email
$$;
