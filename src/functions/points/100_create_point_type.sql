CREATE OR REPLACE FUNCTION create_point_type(
  _party_id INTEGER,
  _name TEXT,
  _description TEXT,
  _start_value INTEGER,
  _is_public BOOLEAN,
  _is_shared BOOLEAN,
  _minimum INTEGER,
  _maximum INTEGER
)
  RETURNS TABLE (
    id          INTEGER,
    party_id    INTEGER,
    name        TEXT,
    description TEXT,
    start_value INTEGER,
    is_public   BOOLEAN,
    is_shared   BOOLEAN,
    minimum     INTEGER,
    maximum     INTEGER,
    is_removed  BOOLEAN
  )
  LANGUAGE sql
AS
$$
INSERT INTO party.PointTypes (PartyId, Name, Description, StartValue, IsPublic, IsShared, Minimum, Maximum)
VALUES (_party_id, _name, _description, _start_value, _is_public, _is_shared, _minimum, _maximum)
RETURNING Id, PartyId, Name, Description, StartValue, IsPublic, IsShared, Minimum, Maximum, IsRemoved
$$;
