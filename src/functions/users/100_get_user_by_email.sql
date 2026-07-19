CREATE OR REPLACE FUNCTION get_user_by_email(_email TEXT)
  RETURNS TABLE (
    id    INTEGER,
    login TEXT,
    email TEXT
  )
LANGUAGE sql AS $$
SELECT Id, Login, Email
FROM common.Users
WHERE Email = _email
$$;
