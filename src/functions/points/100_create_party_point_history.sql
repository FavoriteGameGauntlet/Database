CREATE OR REPLACE FUNCTION create_party_point_history(
  _party_id INTEGER,
  _point_type_id INTEGER,
  _source_user_id INTEGER,
  _desired_change_value INTEGER,
  _actual_change_value INTEGER,
  _final_value INTEGER,
  _source_event_id INTEGER
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
INSERT INTO party.PointHistory (PartyId, PointTypeId, SourceUserId, DesiredChangeValue, ActualChangeValue, FinalValue,
                                SourceEventId)
VALUES (_party_id, _point_type_id, _source_user_id, _desired_change_value, _actual_change_value, _final_value,
        _source_event_id)
RETURNING
  Id, PartyId, PointTypeId, SourceUserId,
  DesiredChangeValue, ActualChangeValue, FinalValue,
  SourceEventId, ChangedDate
$$;
