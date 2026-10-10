CREATE TABLE IF NOT EXISTS defaults.Effects (
  Id          SERIAL PRIMARY KEY,
  Name        TEXT NOT NULL UNIQUE,
  Description TEXT,
  UseCount    INTEGER CHECK ( UseCount IS NULL OR UseCount > 0 ),
  Duration    INTERVAL CHECK ( Duration IS NULL OR Duration > INTERVAL '0' ),
  ChangeId    INTEGER REFERENCES defaults.Changes (Id)
);

CREATE TABLE IF NOT EXISTS party.Effects (
  Id          SERIAL PRIMARY KEY,
  PartyId     INTEGER NOT NULL REFERENCES common.Parties (Id),
  Name        TEXT    NOT NULL,
  Description TEXT,
  UseCount    INTEGER CHECK ( UseCount IS NULL OR UseCount > 0 ),
  Duration    INTERVAL CHECK ( Duration IS NULL OR Duration > INTERVAL '0' ),
  ChangeId    INTEGER,
  IsRemoved   BOOLEAN NOT NULL DEFAULT FALSE,

  UNIQUE (Id, PartyId),
  FOREIGN KEY (ChangeId, PartyId) REFERENCES party.Changes (Id, PartyId)
);

CREATE UNIQUE INDEX IF NOT EXISTS EffectsPartyIdNameUnique
  ON party.Effects (PartyId, Name) WHERE NOT IsRemoved;

CREATE TABLE IF NOT EXISTS users.Effects (
  Id          SERIAL PRIMARY KEY,
  UserId      INTEGER   NOT NULL REFERENCES common.Users (Id),
  PartyId     INTEGER   NOT NULL REFERENCES common.Parties (Id),
  EffectId    INTEGER   NOT NULL,
  UsesLeft    INTEGER CHECK ( UsesLeft IS NULL OR UsesLeft > 0 ),
  StartedDate TIMESTAMP NOT NULL DEFAULT NOW(),

  UNIQUE (Id, PartyId),
  FOREIGN KEY (EffectId, PartyId) REFERENCES party.Effects (Id, PartyId)
);
