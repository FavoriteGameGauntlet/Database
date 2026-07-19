CREATE OR REPLACE FUNCTION delete_wheel_row(
  _party_id INTEGER,
  _wheel_row_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
DELETE
FROM party.WheelRows
WHERE Id = _wheel_row_id
  AND PartyId = _party_id
$$;
