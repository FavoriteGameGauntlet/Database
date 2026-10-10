CREATE TABLE IF NOT EXISTS users.EffectHistory (
  Id           INTEGER PRIMARY KEY,
  PartyId      INTEGER NOT NULL REFERENCES common.Parties (Id),
  EffectId     INTEGER NOT NULL,
  UserEffectId INTEGER NOT NULL,
  UsesLeft     INTEGER CHECK ( UsesLeft IS NULL OR UsesLeft >= 0 ),

  UNIQUE (Id, PartyId),
  FOREIGN KEY (Id, PartyId) REFERENCES users.HistoryEvents (Id, PartyId),
  FOREIGN KEY (EffectId, PartyId) REFERENCES party.Effects (Id, PartyId)
);
