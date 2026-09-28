CREATE OR REPLACE FUNCTION change_user_point_value(
  _user_id INTEGER,
  _party_id INTEGER,
  _point_type_id INTEGER,
  _change_value INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
INSERT INTO users.Points (UserId, PartyId, PointTypeId, Value)
SELECT _user_id, _party_id, Id, StartValue + _change_value
FROM party.PointTypes
WHERE Id = _point_type_id
  AND PartyId = _party_id
ON CONFLICT (UserId, PartyId, PointTypeId) DO UPDATE
  SET Value = users.Points.Value + _change_value
$$;
