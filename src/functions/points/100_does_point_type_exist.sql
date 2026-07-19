CREATE OR REPLACE FUNCTION does_point_type_exist(
  _party_id INTEGER,
  _name TEXT
)
  RETURNS BOOLEAN
  LANGUAGE sql AS
$$
SELECT EXISTS (SELECT 1 FROM party.PointTypes WHERE PartyId = _party_id AND Name = _name AND NOT IsRemoved)
$$;
