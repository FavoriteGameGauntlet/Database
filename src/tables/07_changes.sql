CREATE TABLE IF NOT EXISTS defaults.Changes
(
  Id                 SERIAL PRIMARY KEY,
  ShouldApplyToAll   BOOLEAN NOT NULL DEFAULT TRUE,
  IsManualChange BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS party.Changes
(
  Id                 SERIAL PRIMARY KEY,
  PartyId            INTEGER NOT NULL REFERENCES common.Parties (Id),
  ShouldApplyToAll   BOOLEAN NOT NULL DEFAULT TRUE,
  IsManualChange BOOLEAN NOT NULL DEFAULT FALSE,

  UNIQUE (Id, PartyId)
);

CREATE TABLE IF NOT EXISTS users.Changes (
  Id      SERIAL PRIMARY KEY,
  PartyId INTEGER NOT NULL REFERENCES common.Parties (Id),

  UNIQUE (Id, PartyId)
);
