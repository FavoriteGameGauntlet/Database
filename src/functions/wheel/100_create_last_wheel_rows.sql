CREATE OR REPLACE FUNCTION create_last_wheel_rows(
  _user_id INTEGER,
  _party_id INTEGER,
  _wheel_rows JSONB
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
SELECT _user_id,
       _party_id,
       (row_entry ->> 'wheel_row_id')::integer,
       (row_entry ->> 'position')::integer
FROM jsonb_array_elements(_wheel_rows) AS row_entry
RETURNING Id, UserId, PartyId, WheelRowId, Position, RolledDate
$$;
