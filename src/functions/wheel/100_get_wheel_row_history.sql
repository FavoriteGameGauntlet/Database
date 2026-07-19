CREATE OR REPLACE FUNCTION get_wheel_row_history(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS TABLE (
    name         TEXT,
    description  TEXT,
    applied_date TIMESTAMP
  )
  LANGUAGE sql
AS
$$
SELECT wr.Name, wr.Description, he.CreatedDate
FROM users.WheelRowHistory wrh
       INNER JOIN users.HistoryEvents he ON he.Id = wrh.Id AND he.PartyId = wrh.PartyId
       INNER JOIN party.WheelRows wr ON wr.Id = wrh.WheelRowId AND wr.PartyId = wrh.PartyId
WHERE he.UserId = _user_id
  AND wrh.PartyId = _party_id
$$;
