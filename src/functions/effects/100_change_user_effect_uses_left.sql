CREATE OR REPLACE FUNCTION change_user_effect_uses_left(
  _user_id INTEGER,
  _party_id INTEGER,
  _user_effect_id INTEGER,
  _uses_left INTEGER,
  _actor_user_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS INTEGER
  LANGUAGE sql AS
$$
WITH
  target_effect AS (
    SELECT Id, EffectId
    FROM users.Effects
    WHERE Id = _user_effect_id
      AND UserId = _user_id
      AND PartyId = _party_id),

  history_event AS (
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action, SourceEventId)
      SELECT _user_id, _actor_user_id, _party_id, 'effect', 'changed', _source_event_id
      FROM target_effect
      RETURNING Id, PartyId),

  effect_history AS (
    INSERT INTO users.EffectHistory (Id, PartyId, EffectId, UserEffectId, UsesLeft)
      SELECT he.Id, he.PartyId, te.EffectId, te.Id, _uses_left
      FROM history_event he
             CROSS JOIN target_effect te),

  updated_effect AS (
    UPDATE users.Effects
      SET UsesLeft = _uses_left
      WHERE Id = _user_effect_id
        AND UserId = _user_id
        AND PartyId = _party_id
        AND _uses_left > 0)

SELECT Id
FROM history_event
$$;
