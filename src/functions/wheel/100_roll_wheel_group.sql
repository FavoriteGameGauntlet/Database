CREATE OR REPLACE FUNCTION roll_wheel_group(
  _user_id INTEGER,
  _party_id INTEGER,
  _group_id INTEGER
)
  RETURNS TABLE (
    id               INTEGER,
    user_id          INTEGER,
    party_id         INTEGER,
    wheel_row_id     INTEGER,
    wheel_position   INTEGER,
    rolled_date      TIMESTAMP,
    is_manual_change BOOLEAN
  )
  LANGUAGE sql
AS
$$
WITH
  candidate AS (SELECT wr.Id, c.IsManualChange
                FROM party.WheelRows wr
                       INNER JOIN party.Changes c ON c.PartyId = wr.PartyId AND c.Id = wr.ChangeId
                WHERE wr.PartyId = _party_id
                  AND wr.GroupId = _group_id
                  AND NOT EXISTS (SELECT 1
                                  FROM users.LastWheelRows lwr
                                  WHERE lwr.WheelRowId = wr.Id
                                    AND lwr.UserId = _user_id
                                    AND lwr.PartyId = _party_id)
                ORDER BY random()
                LIMIT 1),
  inserted AS (
    INSERT INTO users.LastWheelRows (UserId, PartyId, WheelRowId, Position)
      SELECT _user_id,
             _party_id,
             c.Id,
             COALESCE((SELECT MAX(Position) FROM users.LastWheelRows WHERE UserId = _user_id AND PartyId = _party_id),
                      0) + 1
      FROM candidate c
      RETURNING Id, UserId, PartyId, WheelRowId, Position, RolledDate)
SELECT i.Id, i.UserId, i.PartyId, i.WheelRowId, i.Position, i.RolledDate, c.IsManualChange
FROM inserted i
       JOIN candidate c ON c.Id = i.WheelRowId
$$;
