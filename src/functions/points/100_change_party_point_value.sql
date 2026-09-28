CREATE OR REPLACE FUNCTION change_party_point_value(
  _party_id INTEGER,
  _point_type_id INTEGER,
  _change_value INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
INSERT INTO shared.Points (PartyId, PointTypeId, Value)
SELECT _party_id, Id, StartValue + _change_value
FROM party.PointTypes
WHERE Id = _point_type_id
  AND PartyId = _party_id
ON CONFLICT (PartyId, PointTypeId) DO UPDATE
  SET Value = shared.Points.Value + _change_value
$$;
