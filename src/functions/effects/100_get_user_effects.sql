CREATE OR REPLACE FUNCTION get_user_effects(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS TABLE (
    id           INTEGER,
    user_id      INTEGER,
    party_id     INTEGER,
    effect_id    INTEGER,
    name         TEXT,
    description  TEXT,
    use_count    INTEGER,
    uses_left    INTEGER,
    duration     INTERVAL,
    started_date TIMESTAMP,
    modifiers    JSONB
  )
  LANGUAGE sql
AS
$$
SELECT ue.Id,
       ue.UserId,
       ue.PartyId,
       ue.EffectId,
       e.Name,
       e.Description,
       e.UseCount,
       ue.UsesLeft,
       e.Duration,
       he.CreatedDate,
       get_user_effect_point_modifiers_jsonb(ue.PartyId, ue.Id)
FROM users.Effects ue
       INNER JOIN party.Effects e ON e.PartyId = ue.PartyId AND e.Id = ue.EffectId
       INNER JOIN LATERAL (
  SELECT he.CreatedDate
  FROM users.EffectHistory eh
         INNER JOIN users.HistoryEvents he ON he.Id = eh.Id AND he.PartyId = eh.PartyId
  WHERE eh.PartyId = ue.PartyId
    AND eh.EffectId = ue.EffectId
    AND he.AffectedUserId = ue.UserId
    AND he.Action = 'added'
  ORDER BY he.CreatedDate DESC
  LIMIT 1
  ) he ON TRUE
WHERE ue.UserId = _user_id
  AND ue.PartyId = _party_id
$$;
