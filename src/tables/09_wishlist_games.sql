CREATE TABLE IF NOT EXISTS users.WishlistGames
(
  Id         SERIAL PRIMARY KEY,
  UserId     INTEGER   NOT NULL REFERENCES common.Users (Id),
  PartyId    INTEGER   NOT NULL REFERENCES common.Parties (Id),
  GameId     INTEGER   NOT NULL,
  CreatedDate TIMESTAMP NOT NULL DEFAULT NOW(),

  UNIQUE (UserId, PartyId, GameId),
  FOREIGN KEY (GameId, PartyId) REFERENCES party.Games (Id, PartyId)
);
