CREATE TABLE IF NOT EXISTS users.WheelRowHistory (
  Id         INTEGER PRIMARY KEY,
  PartyId    INTEGER NOT NULL REFERENCES common.Parties (Id),
  WheelRowId INTEGER NOT NULL,

  UNIQUE (Id, PartyId),
  FOREIGN KEY (Id, PartyId) REFERENCES users.HistoryEvents (Id, PartyId),
  FOREIGN KEY (WheelRowId, PartyId) REFERENCES party.WheelRows (Id, PartyId)
);
