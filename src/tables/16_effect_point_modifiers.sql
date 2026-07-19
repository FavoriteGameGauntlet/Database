CREATE TABLE IF NOT EXISTS defaults.EffectPointModifiers (
  Id          SERIAL PRIMARY KEY,
  EffectId    INTEGER NOT NULL REFERENCES defaults.Effects (Id),
  PointTypeId INTEGER NOT NULL REFERENCES defaults.PointTypes (Id),
  Amount      INTEGER NOT NULL CHECK ( Amount <> 0 ),

  UNIQUE (EffectId, PointTypeId)
);

CREATE TABLE IF NOT EXISTS party.EffectPointModifiers (
  Id          SERIAL PRIMARY KEY,
  PartyId     INTEGER NOT NULL REFERENCES common.Parties (Id),
  EffectId    INTEGER NOT NULL,
  PointTypeId INTEGER NOT NULL,
  Amount      INTEGER NOT NULL CHECK ( Amount <> 0 ),

  UNIQUE (PartyId, EffectId, PointTypeId),
  FOREIGN KEY (EffectId, PartyId) REFERENCES party.Effects (Id, PartyId),
  FOREIGN KEY (PointTypeId, PartyId) REFERENCES party.PointTypes (Id, PartyId)
);

CREATE TABLE IF NOT EXISTS users.EffectPointModifiers (
  Id           SERIAL PRIMARY KEY,
  UserId       INTEGER NOT NULL REFERENCES common.Users (Id),
  PartyId      INTEGER NOT NULL REFERENCES common.Parties (Id),
  PointTypeId  INTEGER NOT NULL,
  UserEffectId INTEGER NOT NULL,
  Amount       INTEGER NOT NULL CHECK ( Amount <> 0 ),

  UNIQUE (UserId, PartyId, PointTypeId, UserEffectId),
  FOREIGN KEY (PointTypeId, PartyId) REFERENCES party.PointTypes (Id, PartyId),
  FOREIGN KEY (UserEffectId, PartyId) REFERENCES users.Effects (Id, PartyId) ON DELETE CASCADE
);
