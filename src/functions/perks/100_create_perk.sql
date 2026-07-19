CREATE OR REPLACE FUNCTION create_perk(
  _party_id INTEGER,
  _name TEXT,
  _description TEXT,
  _effect_id INTEGER
)
  RETURNS TABLE (
    id          INTEGER,
    party_id    INTEGER,
    name        TEXT,
    description TEXT,
    effect_id   INTEGER,
    is_removed  BOOLEAN
  )
  LANGUAGE sql
AS
$$
INSERT INTO party.Perks (PartyId, Name, Description, EffectId)
VALUES (_party_id, _name, _description, _effect_id)
RETURNING Id, PartyId, Name, Description, EffectId, IsRemoved
$$;
