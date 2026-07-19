CREATE OR REPLACE FUNCTION get_item(
  _party_id INTEGER,
  _item_id INTEGER
)
  RETURNS TABLE
  (
    id          INTEGER,
    party_id    INTEGER,
    name        TEXT,
    description TEXT,
    use_count   INTEGER,
    change      JSONB
  )
  LANGUAGE sql
AS
$$
SELECT it.Id,
       it.PartyId,
       it.Name,
       it.Description,
       it.UseCount,
       change_to_jsonb(
         c.Id,
         c.ShouldApplyToAll,
         c.IsManualChange,
         get_change_entries_jsonb(it.PartyId, it.ChangeId)
       )
FROM party.Items it
       INNER JOIN party.Changes c ON c.PartyId = it.PartyId AND c.Id = it.ChangeId
WHERE it.Id = _item_id
  AND it.PartyId = _party_id
  AND NOT it.IsRemoved
$$;
