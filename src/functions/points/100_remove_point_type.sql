CREATE OR REPLACE FUNCTION remove_point_type(
  _party_id INTEGER,
  _point_type_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
UPDATE party.PointTypes
SET IsRemoved = TRUE
WHERE Id = _point_type_id
  AND PartyId = _party_id
$$;
