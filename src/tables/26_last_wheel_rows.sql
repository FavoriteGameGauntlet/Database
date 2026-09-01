CREATE TABLE IF NOT EXISTS users.LastWheelRows
(
  Id         SERIAL PRIMARY KEY,
  UserId     INTEGER   NOT NULL REFERENCES common.Users (Id),
  PartyId    INTEGER   NOT NULL REFERENCES common.Parties (Id),
  WheelRowId INTEGER   NOT NULL,
  Position   INTEGER   NOT NULL,
  RolledDate TIMESTAMP NOT NULL DEFAULT NOW(),

  FOREIGN KEY (WheelRowId, PartyId) REFERENCES party.WheelRows (Id, PartyId)
);

CREATE INDEX IF NOT EXISTS LastWheelRowsUserIdPartyIdWheelRowIdIdx
  ON users.LastWheelRows (UserId, PartyId, WheelRowId);
