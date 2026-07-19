CREATE OR REPLACE FUNCTION get_actual_perks(
  _party_id INTEGER
)
  RETURNS TABLE (
    id          INTEGER,
    party_id    INTEGER,
    name        TEXT,
    description TEXT,
    effect_id   INTEGER
  )
  LANGUAGE sql
AS
$$
SELECT Id, PartyId, Name, Description, EffectId
FROM party.Perks
WHERE PartyId = _party_id
  AND NOT IsRemoved
$$;
