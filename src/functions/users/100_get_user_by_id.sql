CREATE OR REPLACE FUNCTION get_user_by_id(_id INTEGER)
  RETURNS TABLE (
    id    INTEGER,
    login TEXT,
    email TEXT
  )
LANGUAGE sql AS $$
SELECT Id, Login, Email
FROM common.Users
WHERE Id = _id
$$;
