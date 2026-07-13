CREATE TABLE IF NOT EXISTS users.PerkHistory
(
  Id           SERIAL PRIMARY KEY,
  UserId       INTEGER   NOT NULL REFERENCES common.Users (Id),
  PartyId      INTEGER   NOT NULL REFERENCES common.Parties (Id),
  PerkId       INTEGER   NOT NULL,
  ReceivedDate TIMESTAMP NOT NULL DEFAULT NOW(),
  RemovedDate  TIMESTAMP CHECK ( RemovedDate IS NULL OR ReceivedDate < RemovedDate ),

  FOREIGN KEY (PerkId, PartyId) REFERENCES party.Perks (Id, PartyId)
);
