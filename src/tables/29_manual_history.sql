CREATE TABLE IF NOT EXISTS users.ManualHistory (
  Id       INTEGER PRIMARY KEY,
  PartyId  INTEGER NOT NULL REFERENCES common.Parties (Id),
  ChangeId INTEGER NOT NULL,

  UNIQUE (Id, PartyId),
  FOREIGN KEY (Id, PartyId) REFERENCES users.HistoryEvents (Id, PartyId),
  FOREIGN KEY (ChangeId, PartyId) REFERENCES users.Changes (Id, PartyId)
);
