CREATE OR REPLACE FUNCTION change_party_point_value(
  _party_id INTEGER,
  _point_type_id INTEGER,
  _change_value INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
UPDATE shared.Points
SET Value = Value + _change_value
WHERE PartyId = _party_id
  AND PointTypeId = _point_type_id
$$;
