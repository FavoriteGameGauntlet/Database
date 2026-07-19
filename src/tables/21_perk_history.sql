CREATE TABLE IF NOT EXISTS users.PerkHistory (
  Id      INTEGER PRIMARY KEY,
  PartyId INTEGER NOT NULL REFERENCES common.Parties (Id),
  PerkId  INTEGER NOT NULL,

  UNIQUE (Id, PartyId),
  FOREIGN KEY (Id, PartyId) REFERENCES users.HistoryEvents (Id, PartyId),
  FOREIGN KEY (PerkId, PartyId) REFERENCES party.Perks (Id, PartyId)
);
