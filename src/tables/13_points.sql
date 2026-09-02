CREATE TABLE IF NOT EXISTS shared.Points (
  Id          SERIAL PRIMARY KEY,
  PartyId     INTEGER NOT NULL REFERENCES common.Parties (Id),
  PointTypeId INTEGER NOT NULL,
  Value       INTEGER NOT NULL DEFAULT 0,

  UNIQUE (PartyId, PointTypeId),
  FOREIGN KEY (PointTypeId, PartyId) REFERENCES party.PointTypes (Id, PartyId)
);

CREATE TABLE IF NOT EXISTS users.Points (
  Id          SERIAL PRIMARY KEY,
  UserId      INTEGER NOT NULL REFERENCES common.Users (Id),
  PartyId     INTEGER NOT NULL REFERENCES common.Parties (Id),
  PointTypeId INTEGER NOT NULL,
  Value       INTEGER NOT NULL DEFAULT 0,

  UNIQUE (UserId, PartyId, PointTypeId),
  FOREIGN KEY (PointTypeId, PartyId) REFERENCES party.PointTypes (Id, PartyId)
);