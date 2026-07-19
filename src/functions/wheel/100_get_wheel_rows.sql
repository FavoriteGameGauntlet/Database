CREATE OR REPLACE FUNCTION get_wheel_rows(
  _party_id INTEGER
)
  RETURNS TABLE (
    id               INTEGER,
    party_id         INTEGER,
    name             TEXT,
    description      TEXT,
    change_id        INTEGER,
    group_id         INTEGER,
    is_manual_change BOOLEAN
  )
  LANGUAGE sql
AS
$$
SELECT wr.Id, wr.PartyId, wr.Name, wr.Description, wr.ChangeId, wr.GroupId, c.IsManualChange
FROM party.WheelRows wr
       INNER JOIN party.Changes c ON c.PartyId = wr.PartyId AND c.Id = wr.ChangeId
WHERE wr.PartyId = _party_id
$$;
