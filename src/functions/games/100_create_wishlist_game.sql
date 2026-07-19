CREATE OR REPLACE FUNCTION create_wishlist_game(
  _user_id INTEGER,
  _party_id INTEGER,
  _game_id INTEGER
)
  RETURNS TABLE (
    id           INTEGER,
    user_id      INTEGER,
    party_id     INTEGER,
    game_id      INTEGER,
    created_date TIMESTAMP
  )
  LANGUAGE sql
AS
$$
INSERT INTO users.WishlistGames (UserId, PartyId, GameId)
VALUES (_user_id, _party_id, _game_id)
RETURNING Id, UserId, PartyId, GameId, CreatedDate
$$;
