CREATE OR REPLACE FUNCTION get_named_change_entries(
  _party_id INTEGER,
  _change_id INTEGER
)
  RETURNS TABLE (
    point_type_name TEXT,
    item_id         INTEGER,
    perk_name       TEXT,
    effect_id       INTEGER,
    amount          INTEGER
  )
  LANGUAGE sql
AS
$$
SELECT pt.Name, ce.ItemId, p.Name, ce.EffectId, ce.Amount
FROM party.ChangeEntries ce
       LEFT JOIN party.PointTypes pt ON pt.PartyId = ce.PartyId AND pt.Id = ce.PointTypeId
       LEFT JOIN party.Perks p ON p.PartyId = ce.PartyId AND p.Id = ce.PerkId
WHERE ce.PartyId = _party_id
  AND ce.ChangeId = _change_id
ORDER BY ce.Id
$$;
