CREATE TABLE IF NOT EXISTS party.PointHistory (
  Id                 SERIAL PRIMARY KEY,
  PartyId            INTEGER   NOT NULL REFERENCES common.Parties (Id),
  PointTypeId        INTEGER   NOT NULL,
  SourceUserId       INTEGER   NOT NULL REFERENCES common.Users (Id),
  DesiredChangeValue INTEGER   NOT NULL,
  ActualChangeValue  INTEGER   NOT NULL,
  FinalValue         INTEGER   NOT NULL,
  SourceEventId      INTEGER   NOT NULL,
  ChangedDate        TIMESTAMP NOT NULL DEFAULT NOW(),

  FOREIGN KEY (PointTypeId, PartyId) REFERENCES party.PointTypes (Id, PartyId),
  FOREIGN KEY (SourceEventId, PartyId) REFERENCES users.HistoryEvents (Id, PartyId)
);

CREATE TABLE IF NOT EXISTS users.PointHistory (
  Id                 INTEGER PRIMARY KEY,
  PartyId            INTEGER NOT NULL REFERENCES common.Parties (Id),
  PointTypeId        INTEGER NOT NULL,
  SourceUserId       INTEGER NOT NULL REFERENCES common.Users (Id),
  DesiredChangeValue INTEGER NOT NULL,
  ActualChangeValue  INTEGER NOT NULL,
  FinalValue         INTEGER NOT NULL,

  UNIQUE (Id, PartyId),
  FOREIGN KEY (Id, PartyId) REFERENCES users.HistoryEvents (Id, PartyId),
  FOREIGN KEY (PointTypeId, PartyId) REFERENCES party.PointTypes (Id, PartyId)
);
