CREATE OR REPLACE FUNCTION get_user_point_history(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS TABLE (
    id                   INTEGER,
    affected_user_id     INTEGER,
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
SELECT ph.Id,
       he.AffectedUserId,
       ph.PartyId,
       ph.PointTypeId,
       he.ActorUserId,
       ph.DesiredChangeValue,
       ph.ActualChangeValue,
       ph.FinalValue,
       he.SourceEventId,
       he.CreatedDate
FROM users.PointHistory ph
       INNER JOIN users.HistoryEvents he ON he.Id = ph.Id AND he.PartyId = ph.PartyId
WHERE he.AffectedUserId = _user_id
  AND ph.PartyId = _party_id
ORDER BY he.CreatedDate DESC
$$;
