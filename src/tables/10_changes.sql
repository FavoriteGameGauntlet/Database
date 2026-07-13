CREATE TABLE IF NOT EXISTS defaults.Changes
(
  Id                 SERIAL PRIMARY KEY,
  Name               TEXT    NOT NULL,
  ShouldApplyToAll   BOOLEAN NOT NULL DEFAULT TRUE,
  ShouldChangePoints BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS party.Changes
(
  Id                 SERIAL PRIMARY KEY,
  PartyId            INTEGER NOT NULL REFERENCES common.Parties (Id),
  Name               TEXT    NOT NULL,
  ShouldApplyToAll   BOOLEAN NOT NULL DEFAULT TRUE,
  ShouldChangePoints BOOLEAN NOT NULL DEFAULT FALSE,

  UNIQUE (Id, PartyId)
);
