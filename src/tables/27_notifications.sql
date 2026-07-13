CREATE TABLE IF NOT EXISTS users.Notifications
(
  Id           SERIAL PRIMARY KEY,
  UserId       INTEGER   NOT NULL REFERENCES common.Users (Id),
  PartyId      INTEGER   NOT NULL REFERENCES common.Parties (Id),
  Title        TEXT      NOT NULL,
  Description  TEXT,
  SentDate     TIMESTAMP NOT NULL DEFAULT NOW(),
  ReceivedDate TIMESTAMP CHECK ( SentDate < ReceivedDate )
);
