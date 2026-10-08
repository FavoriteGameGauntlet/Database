CREATE OR REPLACE FUNCTION get_user_items(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS TABLE (
    name          TEXT,
    description   TEXT,
    uses_left     INTEGER,
    received_date TIMESTAMP,
    change_id     INTEGER
  )
  LANGUAGE sql
AS
$$
SELECT i.Name, i.Description, ui.UsesLeft, ui.ReceivedDate, i.ChangeId
FROM users.Items ui
       INNER JOIN party.Items i ON i.PartyId = ui.PartyId AND i.Id = ui.ItemId
WHERE ui.UserId = _user_id
  AND ui.PartyId = _party_id
$$;
