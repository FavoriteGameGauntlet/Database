CREATE OR REPLACE FUNCTION get_user_point(
  _user_id INTEGER,
  _party_id INTEGER,
  _point_type_id INTEGER
)
  RETURNS TABLE (
    id            INTEGER,
    user_id       INTEGER,
    party_id      INTEGER,
    point_type_id INTEGER,
    value         INTEGER
  )
  LANGUAGE sql
AS
$$
SELECT Id, UserId, PartyId, PointTypeId, Value
FROM users.Points
WHERE UserId = _user_id
  AND PartyId = _party_id
  AND PointTypeId = _point_type_id
$$;
