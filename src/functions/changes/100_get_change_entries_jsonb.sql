CREATE OR REPLACE FUNCTION get_change_entries_jsonb(
  _party_id INTEGER,
  _change_id INTEGER
)
  RETURNS JSONB
  LANGUAGE sql
AS
$$
SELECT jsonb_agg(change_entry_to_jsonb(ce.Id, ce.Amount, ce.PointTypeId, ce.ItemId, ce.PerkId, ce.EffectId))
FROM party.ChangeEntries ce
WHERE ce.PartyId = _party_id
  AND ce.ChangeId = _change_id
$$;
