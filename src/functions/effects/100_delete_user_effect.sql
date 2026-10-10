CREATE OR REPLACE FUNCTION delete_user_effect(
  _user_id INTEGER,
  _party_id INTEGER,
  _user_effect_id INTEGER,
  _actor_user_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
WITH
  deleted_effect AS (
    DELETE FROM users.Effects
      WHERE Id = _user_effect_id
        AND UserId = _user_id
        AND PartyId = _party_id
      RETURNING Id, EffectId),

  history_event AS (
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action, SourceEventId)
      SELECT _user_id, _actor_user_id, _party_id, 'effect', 'removed', _source_event_id
      FROM deleted_effect
      RETURNING Id, PartyId),

  effect_history AS (
    INSERT INTO users.EffectHistory (Id, PartyId, EffectId, UserEffectId)
      SELECT he.Id, he.PartyId, de.EffectId, de.Id
      FROM history_event he
             CROSS JOIN deleted_effect de)

SELECT 1
$$;
