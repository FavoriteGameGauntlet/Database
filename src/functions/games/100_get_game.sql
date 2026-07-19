CREATE OR REPLACE FUNCTION get_game(
  _party_id INTEGER,
  _game_id INTEGER
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
WHERE Id = _game_id
  AND PartyId = _party_id
$$;
