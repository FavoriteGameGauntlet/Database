CREATE OR REPLACE FUNCTION change_point_type(
  _party_id INTEGER,
  _point_type_id INTEGER,
  _name TEXT,
  _description TEXT,
  _is_public BOOLEAN,
  _is_shared BOOLEAN,
  _minimum INTEGER,
  _maximum INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
UPDATE party.PointTypes
SET Name        = _name,
    Description = _description,
    IsPublic    = _is_public,
    IsShared    = _is_shared,
    Minimum     = _minimum,
    Maximum     = _maximum
WHERE Id = _point_type_id
  AND PartyId = _party_id
$$;
