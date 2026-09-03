CREATE TABLE IF NOT EXISTS users.GameRatings (
  Id            SERIAL PRIMARY KEY,
  UserId        INTEGER   NOT NULL REFERENCES common.Users (Id),
  PartyId       INTEGER   NOT NULL REFERENCES common.Parties (Id),
  GameId        INTEGER   NOT NULL,
  Rating        INTEGER   NOT NULL CHECK ( Rating BETWEEN 1 AND 10 ),
  ReviewComment TEXT,
  CreatedDate   TIMESTAMP NOT NULL DEFAULT NOW(),
  UpdatedDate   TIMESTAMP NOT NULL DEFAULT NOW(),

  UNIQUE (UserId, PartyId, GameId),
  FOREIGN KEY (GameId, PartyId) REFERENCES party.Games (Id, PartyId)
);
