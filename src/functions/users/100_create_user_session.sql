CREATE OR REPLACE FUNCTION create_user_session(
  _user_id INTEGER
)
  RETURNS TABLE (
    id           TEXT,
    user_id      INTEGER,
    created_date TIMESTAMP,
    expiry_date  TIMESTAMP
  )
  LANGUAGE sql
AS
$$
INSERT INTO common.UserSessions (Id, UserId)
VALUES (gen_random_uuid()::TEXT, _user_id)
RETURNING Id, UserId, CreatedDate, ExpiryDate
$$;
