CREATE OR REPLACE FUNCTION get_party_point_history(
  _party_id INTEGER
)
  RETURNS TABLE (
    id                   INTEGER,
    party_id             INTEGER,
    point_type_id        INTEGER,
    source_user_id       INTEGER,
    desired_change_value INTEGER,
    actual_change_value  INTEGER,
    final_value          INTEGER,
    source_event_id      INTEGER,
    changed_date         TIMESTAMP
  )
  LANGUAGE sql
AS
$$
SELECT Id,
       PartyId,
       PointTypeId,
       SourceUserId,
       DesiredChangeValue,
       ActualChangeValue,
       FinalValue,
       SourceEventId,
       ChangedDate
FROM party.PointHistory
WHERE PartyId = _party_id
ORDER BY ChangedDate DESC
$$;
