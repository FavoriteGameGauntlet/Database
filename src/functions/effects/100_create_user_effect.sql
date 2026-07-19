CREATE OR REPLACE FUNCTION create_user_effect(
  _user_id INTEGER,
  _party_id INTEGER,
  _effect_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS TABLE (
    id                INTEGER,
    user_id           INTEGER,
    party_id          INTEGER,
    effect_id         INTEGER,
    uses_left         INTEGER,
    effect_history_id INTEGER
  )
  LANGUAGE sql
AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (UserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _party_id, 'effect', 'added', _source_event_id)
      RETURNING Id, UserId, PartyId),

  effect_history AS (
    INSERT INTO users.EffectHistory (Id, PartyId, EffectId)
      SELECT he.Id, he.PartyId, _effect_id
      FROM history_event he),

  user_effect AS (
    INSERT INTO users.Effects (UserId, PartyId, EffectId, UsesLeft)
      SELECT he.UserId, he.PartyId, _effect_id, e.UseCount
      FROM history_event he
             INNER JOIN party.Effects e ON e.Id = _effect_id AND e.PartyId = he.PartyId
      RETURNING Id, UserId, PartyId, EffectId, UsesLeft),

  point_modifiers AS (
    INSERT INTO users.EffectPointModifiers (UserId, PartyId, PointTypeId, UserEffectId, Amount)
      SELECT ue.UserId, ue.PartyId, epm.PointTypeId, ue.Id, epm.Amount
      FROM user_effect ue
             INNER JOIN party.EffectPointModifiers epm ON epm.PartyId = ue.PartyId AND epm.EffectId = ue.EffectId)

SELECT ue.Id, ue.UserId, ue.PartyId, ue.EffectId, ue.UsesLeft, (SELECT Id FROM history_event)
FROM user_effect ue
$$;
