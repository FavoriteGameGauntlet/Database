CREATE OR REPLACE FUNCTION get_effect_history(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS TABLE (
    id               INTEGER,
    affected_user_id INTEGER,
    party_id         INTEGER,
    effect_id        INTEGER,
    name             TEXT,
    description      TEXT,
    use_count        INTEGER,
    duration         INTERVAL,
    action           TEXT,
    uses_left        INTEGER,
    source_event_id  INTEGER,
    created_date     TIMESTAMP
  )
  LANGUAGE sql
AS
$$
SELECT eh.Id,
       he.AffectedUserId,
       eh.PartyId,
       eh.EffectId,
       e.Name,
       e.Description,
       e.UseCount,
       e.Duration,
       he.Action,
       eh.UsesLeft,
       he.SourceEventId,
       he.CreatedDate
FROM users.EffectHistory eh
       INNER JOIN users.HistoryEvents he ON he.Id = eh.Id AND he.PartyId = eh.PartyId
       INNER JOIN party.Effects e ON e.PartyId = eh.PartyId AND e.Id = eh.EffectId
WHERE he.AffectedUserId = _user_id
  AND eh.PartyId = _party_id
ORDER BY he.CreatedDate DESC
$$;
