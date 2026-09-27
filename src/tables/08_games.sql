CREATE TABLE IF NOT EXISTS party.Games
(
  Id      SERIAL PRIMARY KEY,
  PartyId INTEGER NOT NULL REFERENCES common.Parties (Id),
  Name    TEXT    NOT NULL,

  UNIQUE (PartyId, Name),
  UNIQUE (Id, PartyId)
);

CREATE TABLE IF NOT EXISTS users.Games (
  Id        SERIAL PRIMARY KEY,
  UserId    INTEGER  NOT NULL REFERENCES common.Users (Id),
  PartyId   INTEGER  NOT NULL REFERENCES common.Parties (Id),
  GameId    INTEGER  NOT NULL,
  TimeSpent INTERVAL NOT NULL DEFAULT INTERVAL '0' CHECK ( TimeSpent >= INTERVAL '0' ),
  StartDate TIMESTAMP NOT NULL DEFAULT NOW(),

  UNIQUE (UserId, PartyId, GameId),
  FOREIGN KEY (GameId, PartyId) REFERENCES party.Games (Id, PartyId)
);
