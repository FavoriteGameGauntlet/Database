CREATE TABLE IF NOT EXISTS users.GameHistory (
  Id            INTEGER PRIMARY KEY,
  PartyId       INTEGER  NOT NULL REFERENCES common.Parties (Id),
  GameId        INTEGER  NOT NULL,
  TimeSpent     INTERVAL NOT NULL CHECK ( TimeSpent >= INTERVAL '0' ),
  Rating        INTEGER CHECK ( Rating BETWEEN 1 AND 10 ),
  ReviewComment TEXT,
  EndState      users.GameEndState,

  UNIQUE (Id, PartyId),
  FOREIGN KEY (Id, PartyId) REFERENCES users.HistoryEvents (Id, PartyId),
  FOREIGN KEY (GameId, PartyId) REFERENCES party.Games (Id, PartyId)
);