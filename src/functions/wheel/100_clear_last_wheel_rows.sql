CREATE OR REPLACE FUNCTION clear_last_wheel_rows(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
DELETE
FROM users.LastWheelRows
WHERE UserId = _user_id
  AND PartyId = _party_id
$$;
