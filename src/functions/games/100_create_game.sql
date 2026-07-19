CREATE OR REPLACE FUNCTION create_game(
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
INSERT INTO party.Games (PartyId, Name)
VALUES (_party_id, _name)
RETURNING Id, PartyId, Name
$$;
