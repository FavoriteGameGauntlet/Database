CREATE OR REPLACE FUNCTION get_named_change_entries(
  _party_id INTEGER,
  _change_id INTEGER
)
  RETURNS TABLE (
    point_type_name TEXT,
    item_name       TEXT,
    perk_name       TEXT,
    effect_name     TEXT,
    amount          INTEGER
  )
  LANGUAGE sql
AS
$$
SELECT pt.Name, i.Name, p.Name, e.Name, ce.Amount
FROM party.ChangeEntries ce
       LEFT JOIN party.PointTypes pt ON pt.PartyId = ce.PartyId AND pt.Id = ce.PointTypeId
       LEFT JOIN party.Items i ON i.PartyId = ce.PartyId AND i.Id = ce.ItemId
       LEFT JOIN party.Perks p ON p.PartyId = ce.PartyId AND p.Id = ce.PerkId
       LEFT JOIN party.Effects e ON e.PartyId = ce.PartyId AND e.Id = ce.EffectId
WHERE ce.PartyId = _party_id
  AND ce.ChangeId = _change_id
ORDER BY ce.Id
$$;
