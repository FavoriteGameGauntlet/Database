CREATE OR REPLACE FUNCTION change_user_effect_uses_left(
  _user_id INTEGER,
  _party_id INTEGER,
  _effect_id INTEGER,
  _uses_left INTEGER,
  _actor_user_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS INTEGER
  LANGUAGE sql AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _actor_user_id, _party_id, 'effect', 'changed', _source_event_id)
      RETURNING Id, PartyId),

  effect_history AS (
    INSERT INTO users.EffectHistory (Id, PartyId, EffectId, UsesLeft)
      SELECT he.Id, he.PartyId, _effect_id, _uses_left
      FROM history_event he),

  updated_effect AS (
    UPDATE users.Effects
      SET UsesLeft = _uses_left
      WHERE UserId = _user_id
        AND PartyId = _party_id
        AND EffectId = _effect_id
        AND _uses_left > 0)

SELECT Id
FROM history_event
$$;
