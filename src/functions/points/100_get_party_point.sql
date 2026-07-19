CREATE OR REPLACE FUNCTION get_party_point(
  _party_id INTEGER,
  _point_type_id INTEGER
)
  RETURNS TABLE (
    id            INTEGER,
    party_id      INTEGER,
    point_type_id INTEGER,
    value         INTEGER
  )
  LANGUAGE sql
AS
$$
SELECT Id, PartyId, PointTypeId, Value
FROM party.Points
WHERE PartyId = _party_id
  AND PointTypeId = _point_type_id
$$;
