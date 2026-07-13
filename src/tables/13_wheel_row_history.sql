CREATE TABLE IF NOT EXISTS users.WheelRowHistory
(
  Id          SERIAL PRIMARY KEY,
  UserId      INTEGER   NOT NULL REFERENCES common.Users (Id),
  PartyId     INTEGER   NOT NULL REFERENCES common.Parties (Id),
  WheelRowId  INTEGER   NOT NULL,
  AppliedDate TIMESTAMP NOT NULL DEFAULT NOW(),

  UNIQUE (UserId, PartyId, WheelRowId),
  UNIQUE (Id, PartyId),
  FOREIGN KEY (WheelRowId, PartyId) REFERENCES party.WheelRows (Id, PartyId)
);
