CREATE TABLE IF NOT EXISTS users.LastWheelRows
(
  Id         SERIAL PRIMARY KEY,
  UserId     INTEGER   NOT NULL REFERENCES common.Users (Id),
  PartyId    INTEGER   NOT NULL REFERENCES common.Parties (Id),
  WheelRowId INTEGER   NOT NULL,
  Position   INTEGER   NOT NULL,
  RolledDate TIMESTAMP NOT NULL DEFAULT NOW(),

  UNIQUE (UserId, PartyId, WheelRowId),
  FOREIGN KEY (WheelRowId, PartyId) REFERENCES party.WheelRows (Id, PartyId)
);
