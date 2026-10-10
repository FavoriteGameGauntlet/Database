CREATE TABLE IF NOT EXISTS defaults.Items (
  Id          SERIAL PRIMARY KEY,
  Name        TEXT    NOT NULL UNIQUE,
  Description TEXT,
  UseCount    INTEGER CHECK ( UseCount IS NULL OR UseCount > 0 ),
  ChangeId    INTEGER REFERENCES defaults.Changes (Id)
);

CREATE TABLE IF NOT EXISTS party.Items (
  Id          SERIAL PRIMARY KEY,
  PartyId     INTEGER NOT NULL REFERENCES common.Parties (Id),
  Name        TEXT    NOT NULL,
  Description TEXT,
  UseCount    INTEGER CHECK ( UseCount IS NULL OR UseCount > 0 ),
  ChangeId    INTEGER,
  IsRemoved   BOOLEAN NOT NULL DEFAULT FALSE,

  UNIQUE (Id, PartyId),
  FOREIGN KEY (ChangeId, PartyId) REFERENCES party.Changes (Id, PartyId)
);

CREATE UNIQUE INDEX IF NOT EXISTS ItemsPartyIdNameUnique
  ON party.Items (PartyId, Name) WHERE NOT IsRemoved;

CREATE TABLE IF NOT EXISTS users.Items (
  Id           SERIAL PRIMARY KEY,
  UserId       INTEGER   NOT NULL REFERENCES common.Users (Id),
  PartyId      INTEGER   NOT NULL REFERENCES common.Parties (Id),
  ItemId       INTEGER   NOT NULL,
  UsesLeft     INTEGER   CHECK ( UsesLeft IS NULL OR UsesLeft > 0 ),
  ReceivedDate TIMESTAMP NOT NULL DEFAULT NOW(),

  FOREIGN KEY (ItemId, PartyId) REFERENCES party.Items (Id, PartyId)
);
