CREATE OR REPLACE FUNCTION get_perk(
  _party_id INTEGER,
  _perk_id INTEGER
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
WHERE Id = _perk_id
  AND PartyId = _party_id
  AND NOT IsRemoved
$$;
