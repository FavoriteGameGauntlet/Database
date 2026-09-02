CREATE TABLE IF NOT EXISTS defaults.ChangeEntries (
  Id          SERIAL PRIMARY KEY,
  ChangeId    INTEGER NOT NULL REFERENCES defaults.Changes (Id),
  Amount      INTEGER,
  PointTypeId INTEGER REFERENCES defaults.PointTypes (Id),
  ItemId      INTEGER REFERENCES defaults.Items (Id),
  PerkId      INTEGER REFERENCES defaults.Perks (Id),
  EffectId    INTEGER REFERENCES defaults.Effects (Id),

  CHECK ( num_nonnulls(PointTypeId, ItemId, PerkId, EffectId) = 1 )
);

CREATE TABLE IF NOT EXISTS party.ChangeEntries (
  Id          SERIAL PRIMARY KEY,
  PartyId     INTEGER NOT NULL REFERENCES common.Parties (Id),
  ChangeId    INTEGER NOT NULL,
  Amount      INTEGER,
  PointTypeId INTEGER,
  ItemId      INTEGER,
  PerkId      INTEGER,
  EffectId    INTEGER,

  CHECK ( num_nonnulls(PointTypeId, ItemId, PerkId, EffectId) = 1 ),
  FOREIGN KEY (ChangeId, PartyId) REFERENCES party.Changes (Id, PartyId),
  FOREIGN KEY (PointTypeId, PartyId) REFERENCES party.PointTypes (Id, PartyId),
  FOREIGN KEY (ItemId, PartyId) REFERENCES party.Items (Id, PartyId),
  FOREIGN KEY (PerkId, PartyId) REFERENCES party.Perks (Id, PartyId),
  FOREIGN KEY (EffectId, PartyId) REFERENCES party.Effects (Id, PartyId)
);

CREATE TABLE IF NOT EXISTS users.ChangeEntries (
  Id          SERIAL PRIMARY KEY,
  PartyId     INTEGER NOT NULL REFERENCES common.Parties (Id),
  ChangeId    INTEGER NOT NULL,
  UserId      INTEGER REFERENCES common.Users (Id),
  Amount      INTEGER,
  PointTypeId INTEGER,
  ItemId      INTEGER,
  PerkId      INTEGER,
  EffectId    INTEGER,

  CHECK ( num_nonnulls(PointTypeId, ItemId, PerkId, EffectId) = 1 ),
  CHECK ( UserId IS NOT NULL OR PointTypeId IS NOT NULL ),
  FOREIGN KEY (ChangeId, PartyId) REFERENCES users.Changes (Id, PartyId),
  FOREIGN KEY (PointTypeId, PartyId) REFERENCES party.PointTypes (Id, PartyId),
  FOREIGN KEY (ItemId, PartyId) REFERENCES party.Items (Id, PartyId),
  FOREIGN KEY (PerkId, PartyId) REFERENCES party.Perks (Id, PartyId),
  FOREIGN KEY (EffectId, PartyId) REFERENCES party.Effects (Id, PartyId)
);
