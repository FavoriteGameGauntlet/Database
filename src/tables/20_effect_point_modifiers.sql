CREATE TABLE IF NOT EXISTS users.EffectPointModifiers
(
  Id           SERIAL PRIMARY KEY,
  UserId       INTEGER NOT NULL REFERENCES common.Users (Id),
  PartyId      INTEGER NOT NULL REFERENCES common.Parties (Id),
  PointTypeId  INTEGER NOT NULL,
  UserEffectId INTEGER NOT NULL,
  Amount       INTEGER NOT NULL CHECK ( Amount <> 0 ),

  UNIQUE (UserId, PartyId, PointTypeId, UserEffectId),
  FOREIGN KEY (PointTypeId, PartyId) REFERENCES party.PointTypes (Id, PartyId),
  FOREIGN KEY (UserEffectId, PartyId) REFERENCES users.Effects (Id, PartyId)
);
