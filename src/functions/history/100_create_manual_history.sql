CREATE OR REPLACE FUNCTION create_manual_history(
  _user_id INTEGER,
  _party_id INTEGER,
  _change_id INTEGER,
  _actor_user_id INTEGER,
  _source_event_id INTEGER DEFAULT NULL
)
  RETURNS TABLE (
    id               INTEGER,
    affected_user_id INTEGER,
    party_id         INTEGER,
    actor_user_id    INTEGER,
    change_id        INTEGER,
    created_date     TIMESTAMP
  )
  LANGUAGE sql
AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _actor_user_id, _party_id, 'manual', 'added', _source_event_id)
      RETURNING Id, AffectedUserId, ActorUserId, PartyId, CreatedDate),

  manual_history AS (
    INSERT INTO users.ManualHistory (Id, PartyId, ChangeId)
      SELECT he.Id, he.PartyId, _change_id
      FROM history_event he)

SELECT Id, AffectedUserId, PartyId, ActorUserId, _change_id, CreatedDate
FROM history_event
$$;
