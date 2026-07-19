CREATE TABLE IF NOT EXISTS defaults.PointTypes (
  Id          SERIAL PRIMARY KEY,
  Name        TEXT    NOT NULL UNIQUE,
  Description TEXT    NOT NULL,
  StartValue  INTEGER NOT NULL DEFAULT 0,
  IsPublic    BOOLEAN NOT NULL DEFAULT TRUE,
  IsShared    BOOLEAN NOT NULL DEFAULT FALSE,
  Minimum     INTEGER NOT NULL DEFAULT 0,
  Maximum     INTEGER NOT NULL DEFAULT 100,

  CHECK ( Minimum <= Maximum ),
  CHECK ( StartValue BETWEEN Minimum AND Maximum )
);

CREATE TABLE IF NOT EXISTS party.PointTypes (
  Id          SERIAL PRIMARY KEY,
  PartyId     INTEGER NOT NULL REFERENCES common.Parties (Id),
  Name        TEXT    NOT NULL,
  Description TEXT    NOT NULL,
  StartValue  INTEGER NOT NULL DEFAULT 0,
  IsPublic    BOOLEAN NOT NULL DEFAULT TRUE,
  IsShared    BOOLEAN NOT NULL DEFAULT FALSE,
  Minimum     INTEGER NOT NULL DEFAULT 0,
  Maximum     INTEGER NOT NULL DEFAULT 100,
  IsRemoved   BOOLEAN NOT NULL DEFAULT FALSE,

  UNIQUE (Id, PartyId),
  CHECK ( Minimum <= Maximum ),
  CHECK ( StartValue BETWEEN Minimum AND Maximum )
);

CREATE UNIQUE INDEX IF NOT EXISTS PointTypesPartyIdNameUnique
  ON party.PointTypes (PartyId, Name) WHERE NOT IsRemoved;
