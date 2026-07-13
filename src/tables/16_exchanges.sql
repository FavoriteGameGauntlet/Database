CREATE TABLE IF NOT EXISTS defaults.Exchanges
(
  Id             SERIAL PRIMARY KEY,
  Name           TEXT    NOT NULL,
  SourceChangeId INTEGER NOT NULL REFERENCES defaults.Changes (Id),
  TargetChangeId INTEGER NOT NULL REFERENCES defaults.Changes (Id)
);

CREATE TABLE IF NOT EXISTS party.Exchanges
(
  Id             SERIAL PRIMARY KEY,
  PartyId        INTEGER NOT NULL REFERENCES common.Parties (Id),
  Name           TEXT    NOT NULL,
  SourceChangeId INTEGER NOT NULL,
  TargetChangeId INTEGER NOT NULL,
  IsRemoved      BOOLEAN NOT NULL DEFAULT FALSE,

  UNIQUE (Id, PartyId),
  FOREIGN KEY (SourceChangeId, PartyId) REFERENCES party.Changes (Id, PartyId),
  FOREIGN KEY (TargetChangeId, PartyId) REFERENCES party.Changes (Id, PartyId)
);

CREATE UNIQUE INDEX IF NOT EXISTS ExchangesPartyIdNameUnique
  ON party.Exchanges (PartyId, Name) WHERE NOT IsRemoved;
