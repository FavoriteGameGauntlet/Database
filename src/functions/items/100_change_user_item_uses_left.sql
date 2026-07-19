CREATE OR REPLACE FUNCTION change_user_item_uses_left(
  _user_id INTEGER,
  _party_id INTEGER,
  _item_id INTEGER,
  _uses_left INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
UPDATE users.Items
SET UsesLeft = _uses_left
WHERE UserId = _user_id
  AND PartyId = _party_id
  AND ItemId = _item_id
$$;
