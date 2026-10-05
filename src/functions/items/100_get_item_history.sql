CREATE OR REPLACE FUNCTION get_item_history(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS TABLE (
    id               INTEGER,
    affected_user_id INTEGER,
    actor_user_id    INTEGER,
    party_id         INTEGER,
    item_id          INTEGER,
    action           TEXT,
    uses_left        INTEGER,
    source_event_id  INTEGER,
    created_date     TIMESTAMP
  )
  LANGUAGE sql
AS
$$
SELECT ih.Id,
       he.AffectedUserId,
       he.ActorUserId,
       ih.PartyId,
       ih.ItemId,
       he.Action,
       ih.UsesLeft,
       he.SourceEventId,
       he.CreatedDate
FROM users.ItemHistory ih
       INNER JOIN users.HistoryEvents he ON he.Id = ih.Id AND he.PartyId = ih.PartyId
WHERE he.AffectedUserId = _user_id
  AND ih.PartyId = _party_id
ORDER BY he.CreatedDate DESC
$$;
