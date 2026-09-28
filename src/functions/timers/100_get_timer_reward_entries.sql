CREATE OR REPLACE FUNCTION get_timer_reward_entries(
  _party_id INTEGER
)
  RETURNS TABLE (
    amount          INTEGER,
    point_type_name TEXT,
    item_name       TEXT,
    perk_name       TEXT,
    effect_name     TEXT
  )
  LANGUAGE sql
AS
$$
SELECT COALESCE(ce.Amount, 0),
       pt.Name,
       it.Name,
       pk.Name,
       ef.Name
FROM party.TimerRewards tr
       INNER JOIN party.ChangeEntries ce ON ce.PartyId = tr.PartyId AND ce.ChangeId = tr.ChangeId
       LEFT JOIN party.PointTypes pt ON pt.PartyId = ce.PartyId AND pt.Id = ce.PointTypeId
       LEFT JOIN party.Items it ON it.PartyId = ce.PartyId AND it.Id = ce.ItemId
       LEFT JOIN party.Perks pk ON pk.PartyId = ce.PartyId AND pk.Id = ce.PerkId
       LEFT JOIN party.Effects ef ON ef.PartyId = ce.PartyId AND ef.Id = ce.EffectId
WHERE tr.PartyId = _party_id
  AND NOT tr.IsRemoved
ORDER BY ce.Id
$$;
