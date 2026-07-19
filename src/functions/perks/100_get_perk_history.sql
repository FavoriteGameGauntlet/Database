CREATE OR REPLACE FUNCTION get_perk_history(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS TABLE (
    id              INTEGER,
    user_id         INTEGER,
    party_id        INTEGER,
    perk_id         INTEGER,
    action          TEXT,
    source_event_id INTEGER,
    created_date    TIMESTAMP
  )
  LANGUAGE sql
AS
$$
SELECT ph.Id, he.UserId, ph.PartyId, ph.PerkId, he.Action, he.SourceEventId, he.CreatedDate
FROM users.PerkHistory ph
       INNER JOIN users.HistoryEvents he ON he.Id = ph.Id AND he.PartyId = ph.PartyId
WHERE he.UserId = _user_id
  AND ph.PartyId = _party_id
ORDER BY he.CreatedDate DESC
$$;
