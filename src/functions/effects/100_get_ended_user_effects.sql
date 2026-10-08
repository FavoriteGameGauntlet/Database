CREATE OR REPLACE FUNCTION get_ended_user_effects(
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
SELECT ue.Id, ue.UserId, ue.PartyId, ue.EffectId, ue.UsesLeft
FROM users.Effects ue
       INNER JOIN party.Effects e ON e.Id = ue.EffectId AND e.PartyId = ue.PartyId
WHERE e.Duration IS NOT NULL
  AND ue.StartedDate + e.Duration <= NOW()
$$;
