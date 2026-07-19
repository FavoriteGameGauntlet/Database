CREATE TABLE IF NOT EXISTS defaults.Perks (
  Id          SERIAL PRIMARY KEY,
  Name        TEXT    NOT NULL UNIQUE,
  Description TEXT,
  EffectId    INTEGER NOT NULL REFERENCES defaults.Effects (Id)
);

CREATE TABLE IF NOT EXISTS party.Perks (
  Id          SERIAL PRIMARY KEY,
  PartyId     INTEGER NOT NULL REFERENCES common.Parties (Id),
  Name        TEXT    NOT NULL,
  Description TEXT,
  EffectId    INTEGER NOT NULL,
  IsRemoved   BOOLEAN NOT NULL DEFAULT FALSE,

  UNIQUE (Id, PartyId),
  FOREIGN KEY (EffectId, PartyId) REFERENCES party.Effects (Id, PartyId)
);

CREATE UNIQUE INDEX IF NOT EXISTS PerksPartyIdNameUnique
  ON party.Perks (PartyId, Name) WHERE NOT IsRemoved;

CREATE TABLE IF NOT EXISTS users.Perks (
  Id           SERIAL PRIMARY KEY,
  UserId       INTEGER   NOT NULL REFERENCES common.Users (Id),
  PartyId      INTEGER   NOT NULL REFERENCES common.Parties (Id),
  PerkId       INTEGER   NOT NULL,
  UserEffectId INTEGER   NOT NULL,
  ReceivedDate TIMESTAMP NOT NULL DEFAULT NOW(),

  UNIQUE (UserId, PartyId, PerkId),
  FOREIGN KEY (PerkId, PartyId) REFERENCES party.Perks (Id, PartyId),
  FOREIGN KEY (UserEffectId, PartyId) REFERENCES users.EffectHistory (Id, PartyId)
);