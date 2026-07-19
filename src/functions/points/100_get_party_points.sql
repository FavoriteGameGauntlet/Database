CREATE OR REPLACE FUNCTION get_party_points(
  _party_id INTEGER
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
$$;
