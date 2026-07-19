CREATE OR REPLACE FUNCTION delete_ended_user_effects(
)
  RETURNS TABLE (
    id        INTEGER,
    user_id   INTEGER,
    party_id  INTEGER,
    effect_id INTEGER,
    uses_left INTEGER
  )
  LANGUAGE sql
AS
$$
DELETE
FROM users.Effects ue
  USING party.Effects e
WHERE e.Id = ue.EffectId
  AND e.PartyId = ue.PartyId
  AND e.Duration IS NOT NULL
  AND (SELECT he.CreatedDate
       FROM users.EffectHistory eh
              INNER JOIN users.HistoryEvents he ON he.Id = eh.Id AND he.PartyId = eh.PartyId
       WHERE eh.PartyId = ue.PartyId
         AND eh.EffectId = ue.EffectId
         AND he.UserId = ue.UserId
         AND he.Action = 'added'
       ORDER BY he.CreatedDate DESC
       LIMIT 1) + e.Duration <= NOW()
RETURNING ue.Id, ue.UserId, ue.PartyId, ue.EffectId, ue.UsesLeft
$$;
