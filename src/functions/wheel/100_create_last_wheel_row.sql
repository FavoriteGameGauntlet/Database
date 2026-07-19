CREATE OR REPLACE FUNCTION create_last_wheel_row(
  _user_id INTEGER,
  _party_id INTEGER,
  _wheel_row_id INTEGER,
  _position INTEGER
)
  RETURNS TABLE (
    id             INTEGER,
    user_id        INTEGER,
    party_id       INTEGER,
    wheel_row_id   INTEGER,
    wheel_position INTEGER,
    rolled_date    TIMESTAMP
  )
  LANGUAGE sql
AS
$$
INSERT INTO users.LastWheelRows (UserId, PartyId, WheelRowId, Position)
VALUES (_user_id, _party_id, _wheel_row_id, _position)
RETURNING Id, UserId, PartyId, WheelRowId, Position, RolledDate
$$;
