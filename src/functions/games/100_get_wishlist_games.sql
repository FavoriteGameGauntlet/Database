CREATE OR REPLACE FUNCTION get_wishlist_games(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS TABLE (
    id      INTEGER,
    game_id INTEGER,
    name    TEXT
  )
  LANGUAGE sql
AS
$$
SELECT wg.Id, g.Id, g.Name
FROM users.WishlistGames wg
       INNER JOIN party.Games g ON g.Id = wg.GameId AND g.PartyId = wg.PartyId
WHERE wg.UserId = _user_id
  AND wg.PartyId = _party_id
$$;
