CREATE TABLE IF NOT EXISTS users.ItemHistory
(
  Id           SERIAL PRIMARY KEY,
  UserId       INTEGER   NOT NULL REFERENCES common.Users (Id),
  PartyId      INTEGER   NOT NULL REFERENCES common.Parties (Id),
  ItemId       INTEGER   NOT NULL,
  UserEffectId INTEGER,
  UsedDate     TIMESTAMP NOT NULL DEFAULT NOW(),

  UNIQUE (Id, PartyId),
  FOREIGN KEY (ItemId, PartyId) REFERENCES party.Items (Id, PartyId),
  FOREIGN KEY (UserEffectId, PartyId) REFERENCES users.Effects (Id, PartyId)
);
