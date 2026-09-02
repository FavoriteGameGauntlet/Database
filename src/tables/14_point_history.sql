CREATE TABLE IF NOT EXISTS shared.PointHistory (
  Id                 INTEGER PRIMARY KEY,
  PartyId            INTEGER NOT NULL REFERENCES common.Parties (Id),
  PointTypeId        INTEGER NOT NULL,
  DesiredChangeValue INTEGER NOT NULL,
  ActualChangeValue  INTEGER NOT NULL,
  FinalValue         INTEGER NOT NULL,

  UNIQUE (Id, PartyId),
  FOREIGN KEY (Id, PartyId) REFERENCES users.HistoryEvents (Id, PartyId),
  FOREIGN KEY (PointTypeId, PartyId) REFERENCES party.PointTypes (Id, PartyId)
);

CREATE TABLE IF NOT EXISTS users.PointHistory (
  Id                 INTEGER PRIMARY KEY,
  PartyId            INTEGER NOT NULL REFERENCES common.Parties (Id),
  PointTypeId        INTEGER NOT NULL,
  DesiredChangeValue INTEGER NOT NULL,
  ActualChangeValue  INTEGER NOT NULL,
  FinalValue         INTEGER NOT NULL,

  UNIQUE (Id, PartyId),
  FOREIGN KEY (Id, PartyId) REFERENCES users.HistoryEvents (Id, PartyId),
  FOREIGN KEY (PointTypeId, PartyId) REFERENCES party.PointTypes (Id, PartyId)
);
