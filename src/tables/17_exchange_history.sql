CREATE TABLE IF NOT EXISTS users.ExchangeHistory
(
  Id         SERIAL PRIMARY KEY,
  UserId     INTEGER   NOT NULL REFERENCES common.Users (Id),
  PartyId    INTEGER   NOT NULL REFERENCES common.Parties (Id),
  ExchangeId INTEGER   NOT NULL,
  UsedDate   TIMESTAMP NOT NULL DEFAULT NOW(),

  UNIQUE (Id, PartyId),
  FOREIGN KEY (ExchangeId, PartyId) REFERENCES party.Exchanges (Id, PartyId)
);
