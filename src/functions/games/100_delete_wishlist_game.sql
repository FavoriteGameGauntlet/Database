CREATE OR REPLACE FUNCTION delete_wishlist_game(
  _user_id INTEGER,
  _party_id INTEGER,
  _game_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
DELETE
FROM users.WishlistGames
WHERE UserId = _user_id
  AND PartyId = _party_id
  AND GameId = _game_id
$$;
