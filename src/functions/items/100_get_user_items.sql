CREATE OR REPLACE FUNCTION get_user_items(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS TABLE (
    id            INTEGER,
    user_id       INTEGER,
    party_id      INTEGER,
    item_id       INTEGER,
    uses_left     INTEGER,
    received_date TIMESTAMP
  )
  LANGUAGE sql
AS
$$
SELECT Id, UserId, PartyId, ItemId, UsesLeft, ReceivedDate
FROM users.Items
WHERE UserId = _user_id
  AND PartyId = _party_id
$$;
