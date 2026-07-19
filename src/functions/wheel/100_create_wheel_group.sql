CREATE OR REPLACE FUNCTION create_wheel_group(
  _party_id INTEGER,
  _name TEXT
)
  RETURNS TABLE (
    id       INTEGER,
    party_id INTEGER,
    name     TEXT
  )
  LANGUAGE sql
AS
$$
INSERT INTO party.WheelGroups (PartyId, Name)
VALUES (_party_id, _name)
RETURNING Id, PartyId, Name
$$;
