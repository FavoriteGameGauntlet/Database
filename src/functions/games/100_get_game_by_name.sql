CREATE OR REPLACE FUNCTION get_game_by_name(
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
SELECT Id, PartyId, Name
FROM party.Games
WHERE PartyId = _party_id
  AND Name = _name
$$;
