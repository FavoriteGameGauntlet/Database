CREATE TABLE IF NOT EXISTS defaults.Triggers
(
  Id          SERIAL PRIMARY KEY,
  Code        TEXT NOT NULL UNIQUE,
  Name        TEXT NOT NULL UNIQUE,
  Description TEXT
);

CREATE TABLE IF NOT EXISTS party.Triggers
(
  Id          SERIAL PRIMARY KEY,
  PartyId     INTEGER NOT NULL REFERENCES common.Parties (Id),
  PointTypeId INTEGER,
  ExchangeId  INTEGER,
  Code        TEXT    NOT NULL,
  Name        TEXT    NOT NULL,
  Description TEXT,

  UNIQUE (PartyId, Code),
  UNIQUE (Id, PartyId),
  FOREIGN KEY (PointTypeId, PartyId) REFERENCES party.PointTypes (Id, PartyId),
  FOREIGN KEY (ExchangeId, PartyId) REFERENCES party.Exchanges (Id, PartyId)
);
