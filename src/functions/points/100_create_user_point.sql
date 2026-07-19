CREATE OR REPLACE FUNCTION create_user_point(
  _user_id INTEGER,
  _party_id INTEGER,
  _point_type_id INTEGER,
  _value INTEGER
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
INSERT INTO users.Points (UserId, PartyId, PointTypeId, Value)
VALUES (_user_id, _party_id, _point_type_id, _value)
RETURNING Id, UserId, PartyId, PointTypeId, Value
$$;
