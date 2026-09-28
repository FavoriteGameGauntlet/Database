CREATE OR REPLACE FUNCTION get_timer_reward(
  _party_id INTEGER
)
  RETURNS TABLE (
    id     INTEGER,
    change JSONB
  )
  LANGUAGE sql
AS
$$
SELECT tr.Id,
       change_to_jsonb(
         c.Id,
         c.ShouldApplyToAll,
         c.IsManualChange,
         get_change_entries_jsonb(tr.PartyId, tr.ChangeId)
       )
FROM party.TimerRewards tr
       INNER JOIN party.Changes c ON c.PartyId = tr.PartyId AND c.Id = tr.ChangeId
WHERE tr.PartyId = _party_id
  AND NOT tr.IsRemoved
$$;
