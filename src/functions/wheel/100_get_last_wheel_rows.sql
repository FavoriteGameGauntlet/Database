CREATE OR REPLACE FUNCTION get_last_wheel_rows(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS TABLE (
    id             INTEGER,
    name           TEXT,
    description    TEXT,
    rolled_date    TIMESTAMP,
    wheel_position INTEGER
  )
  LANGUAGE sql
AS
$$
SELECT wr.Id, wr.Name, wr.Description, lwr.RolledDate, lwr.Position
FROM users.LastWheelRows lwr
       INNER JOIN party.WheelRows wr ON wr.Id = lwr.WheelRowId AND wr.PartyId = lwr.PartyId
WHERE lwr.UserId = _user_id
  AND lwr.PartyId = _party_id
$$;
