CREATE TABLE IF NOT EXISTS users.ExchangeHistory (
  Id         INTEGER PRIMARY KEY,
  PartyId    INTEGER NOT NULL REFERENCES common.Parties (Id),
  ExchangeId INTEGER NOT NULL,

  UNIQUE (Id, PartyId),
  FOREIGN KEY (Id, PartyId) REFERENCES users.HistoryEvents (Id, PartyId),
  FOREIGN KEY (ExchangeId, PartyId) REFERENCES party.Exchanges (Id, PartyId)
);
