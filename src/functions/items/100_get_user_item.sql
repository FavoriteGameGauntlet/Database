CREATE OR REPLACE FUNCTION get_user_item(
  _user_id INTEGER,
  _party_id INTEGER,
  _user_item_id INTEGER
)
  RETURNS TABLE (
    id            INTEGER,
    user_id       INTEGER,
    party_id      INTEGER,
    item_id       INTEGER,
    uses_left     INTEGER,
    received_date TIMESTAMP,
    change_id     INTEGER
  )
  LANGUAGE sql
AS
$$
SELECT ui.Id, ui.UserId, ui.PartyId, ui.ItemId, ui.UsesLeft, ui.ReceivedDate, i.ChangeId
FROM users.Items ui
       INNER JOIN party.Items i ON i.PartyId = ui.PartyId AND i.Id = ui.ItemId
WHERE ui.Id = _user_item_id
  AND ui.UserId = _user_id
  AND ui.PartyId = _party_id
$$;
