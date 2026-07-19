CREATE TABLE IF NOT EXISTS defaults.WheelGroups (
  Id   SERIAL PRIMARY KEY,
  Name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS party.WheelGroups (
  Id        SERIAL PRIMARY KEY,
  PartyId   INTEGER NOT NULL REFERENCES common.Parties (Id),
  Name      TEXT    NOT NULL,
  IsRemoved BOOLEAN NOT NULL DEFAULT FALSE,

  UNIQUE (Id, PartyId)
);

CREATE UNIQUE INDEX IF NOT EXISTS WheelGroupsPartyIdNameUnique
  ON party.WheelGroups (PartyId, Name) WHERE NOT IsRemoved;
