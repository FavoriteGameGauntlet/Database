CREATE TABLE IF NOT EXISTS party.Members
(
  Id          SERIAL PRIMARY KEY,
  UserId      INTEGER   NOT NULL REFERENCES common.Users (Id),
  PartyId     INTEGER   NOT NULL REFERENCES common.Parties (Id),
  DisplayName TEXT,
  IsAdmin     BOOLEAN   NOT NULL DEFAULT FALSE,
  JoinedDate  TIMESTAMP NOT NULL DEFAULT NOW(),
  LeftDate    TIMESTAMP,

  UNIQUE (UserId, PartyId),
  UNIQUE (PartyId, DisplayName)
);
