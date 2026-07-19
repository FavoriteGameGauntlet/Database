CREATE OR REPLACE FUNCTION change_user_point_value(
  _user_id INTEGER,
  _party_id INTEGER,
  _point_type_id INTEGER,
  _change_value INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
UPDATE users.Points
SET Value = Value + _change_value
WHERE UserId = _user_id
  AND PartyId = _party_id
  AND PointTypeId = _point_type_id
$$;
