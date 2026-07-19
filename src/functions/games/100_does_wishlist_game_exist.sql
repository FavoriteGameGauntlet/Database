CREATE OR REPLACE FUNCTION does_wishlist_game_exist(
  _user_id INTEGER,
  _party_id INTEGER,
  _game_id INTEGER
)
  RETURNS BOOLEAN
  LANGUAGE sql AS
$$
SELECT EXISTS (SELECT 1
               FROM users.WishlistGames
               WHERE UserId = _user_id
                 AND PartyId = _party_id
                 AND GameId = _game_id)
$$;
