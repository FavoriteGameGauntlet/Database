CREATE TABLE IF NOT EXISTS defaults.SystemParameters
(
  Id           SERIAL PRIMARY KEY,
  Code         TEXT NOT NULL UNIQUE,
  DefaultValue TEXT NOT NULL,
  Name         TEXT NOT NULL UNIQUE,
  Description   TEXT
);

CREATE TABLE IF NOT EXISTS party.SystemParameters
(
  Id                SERIAL PRIMARY KEY,
  PartyId           INTEGER NOT NULL REFERENCES common.Parties (Id),
  SystemParameterId INTEGER NOT NULL REFERENCES defaults.SystemParameters (Id),
  Value             TEXT    NOT NULL,

  UNIQUE (PartyId, SystemParameterId)
);
