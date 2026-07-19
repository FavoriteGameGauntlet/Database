CREATE OR REPLACE FUNCTION get_removed_effects(
  _party_id INTEGER
)
  RETURNS TABLE (
    id          INTEGER,
    party_id    INTEGER,
    name        TEXT,
    description TEXT,
    use_count   INTEGER,
    duration    INTERVAL
  )
  LANGUAGE sql
AS
$$
SELECT Id, PartyId, Name, Description, UseCount, Duration
FROM party.Effects
WHERE PartyId = _party_id
  AND IsRemoved
$$;
