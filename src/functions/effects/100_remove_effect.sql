CREATE OR REPLACE FUNCTION remove_effect(
  _party_id INTEGER,
  _effect_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
UPDATE party.Effects
SET IsRemoved = TRUE
WHERE Id = _effect_id
  AND PartyId = _party_id
$$;
