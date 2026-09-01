CREATE TABLE IF NOT EXISTS defaults.WheelCollections (
  Id                 SERIAL PRIMARY KEY,
  Name               TEXT    NOT NULL UNIQUE,
  ShouldCheckHistory BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS party.WheelCollections (
  Id                 SERIAL PRIMARY KEY,
  PartyId            INTEGER NOT NULL REFERENCES common.Parties (Id),
  Name               TEXT    NOT NULL,
  ShouldCheckHistory BOOLEAN NOT NULL DEFAULT TRUE,
  IsRemoved          BOOLEAN NOT NULL DEFAULT FALSE,

  UNIQUE (Id, PartyId)
);

CREATE UNIQUE INDEX IF NOT EXISTS WheelCollectionsPartyIdNameUnique
  ON party.WheelCollections (PartyId, Name) WHERE NOT IsRemoved;
