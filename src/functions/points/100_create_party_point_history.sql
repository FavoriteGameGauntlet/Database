CREATE OR REPLACE FUNCTION create_party_point_history(
  _party_id INTEGER,
  _point_type_id INTEGER,
  _actor_user_id INTEGER,
  _desired_change_value INTEGER,
  _actual_change_value INTEGER,
  _final_value INTEGER,
  _source_event_id INTEGER
)
  RETURNS TABLE (
    id                   INTEGER,
    party_id             INTEGER,
    point_type_id        INTEGER,
    actor_user_id        INTEGER,
    desired_change_value INTEGER,
    actual_change_value  INTEGER,
    final_value          INTEGER,
    source_event_id      INTEGER,
    changed_date         TIMESTAMP
  )
  LANGUAGE sql
AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action, SourceEventId)
      VALUES (NULL, _actor_user_id, _party_id, 'point', 'changed', _source_event_id)
      RETURNING Id, ActorUserId, PartyId, CreatedDate),

  point_history AS (
    INSERT INTO shared.PointHistory (
                                     Id, PartyId, PointTypeId, DesiredChangeValue, ActualChangeValue, FinalValue
      )
      SELECT he.Id,
             he.PartyId,
             _point_type_id,
             _desired_change_value,
             _actual_change_value,
             _final_value
      FROM history_event he)

SELECT Id,
       PartyId,
       _point_type_id,
       ActorUserId,
       _desired_change_value,
       _actual_change_value,
       _final_value,
       _source_event_id,
       CreatedDate
FROM history_event
$$;
