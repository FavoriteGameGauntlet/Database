CREATE OR REPLACE FUNCTION get_item_history(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS TABLE (
    id              INTEGER,
    user_id         INTEGER,
    party_id        INTEGER,
    item_id         INTEGER,
    action          TEXT,
    user_effect_id  INTEGER,
    source_event_id INTEGER,
    created_date    TIMESTAMP
  )
  LANGUAGE sql
AS
$$
SELECT ih.Id,
       he.UserId,
       ih.PartyId,
       ih.ItemId,
       he.Action,
       ih.UserEffectId,
       he.SourceEventId,
       he.CreatedDate
FROM users.ItemHistory ih
       INNER JOIN users.HistoryEvents he ON he.Id = ih.Id AND he.PartyId = ih.PartyId
WHERE he.UserId = _user_id
  AND ih.PartyId = _party_id
ORDER BY he.CreatedDate DESC
$$;
