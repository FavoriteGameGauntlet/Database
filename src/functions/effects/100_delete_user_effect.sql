CREATE OR REPLACE FUNCTION delete_user_effect(
  _user_id INTEGER,
  _party_id INTEGER,
  _effect_id INTEGER,
  _actor_user_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _actor_user_id, _party_id, 'effect', 'removed', _source_event_id)
      RETURNING Id, PartyId),

  effect_history AS (
    INSERT INTO users.EffectHistory (Id, PartyId, EffectId)
      SELECT he.Id, he.PartyId, _effect_id
      FROM history_event he)

DELETE
FROM users.Effects
WHERE UserId = _user_id
  AND PartyId = _party_id
  AND EffectId = _effect_id
$$;
