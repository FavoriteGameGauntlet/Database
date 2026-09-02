CREATE OR REPLACE FUNCTION create_wheel_row_history(
  _user_id INTEGER,
  _party_id INTEGER,
  _wheel_row_id INTEGER,
  _actor_user_id INTEGER,
  _source_event_id INTEGER DEFAULT NULL
)
  RETURNS TABLE (
    id               INTEGER,
    affected_user_id INTEGER,
    party_id         INTEGER,
    wheel_row_id     INTEGER,
    applied_date     TIMESTAMP
  )
  LANGUAGE sql
AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _actor_user_id, _party_id, 'wheel_row', 'added', _source_event_id)
      RETURNING Id, AffectedUserId, PartyId, CreatedDate),

  wheel_row_history AS (
    INSERT INTO users.WheelRowHistory (Id, PartyId, WheelRowId)
      SELECT he.Id, he.PartyId, _wheel_row_id
      FROM history_event he)

SELECT Id, AffectedUserId, PartyId, _wheel_row_id, CreatedDate
FROM history_event
$$;
