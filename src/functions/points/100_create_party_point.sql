CREATE OR REPLACE FUNCTION create_party_point(
  _party_id INTEGER,
  _point_type_id INTEGER,
  _value INTEGER
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
INSERT INTO party.Points (PartyId, PointTypeId, Value)
VALUES (_party_id, _point_type_id, _value)
RETURNING Id, PartyId, PointTypeId, Value
$$;
