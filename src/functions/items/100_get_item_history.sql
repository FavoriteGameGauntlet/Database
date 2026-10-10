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
    user_item_id     INTEGER,
    name             TEXT,
    use_count        INTEGER,
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
       ih.UserItemId,
       i.Name,
       i.UseCount,
       he.Action,
       ih.UsesLeft,
       he.SourceEventId,
       he.CreatedDate
FROM users.ItemHistory ih
       INNER JOIN users.HistoryEvents he ON he.Id = ih.Id AND he.PartyId = ih.PartyId
       INNER JOIN party.Items i ON i.PartyId = ih.PartyId AND i.Id = ih.ItemId
WHERE he.AffectedUserId = _user_id
  AND ih.PartyId = _party_id
ORDER BY he.CreatedDate DESC
$$;
