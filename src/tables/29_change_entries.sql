CREATE TABLE IF NOT EXISTS defaults.ChangeEntries
(
  Id          SERIAL PRIMARY KEY,
  ChangeId    INTEGER NOT NULL REFERENCES defaults.Changes (Id),
  PointTypeId INTEGER REFERENCES defaults.PointTypes (Id),
  ItemId      INTEGER REFERENCES defaults.Items (Id),
  PerkId      INTEGER REFERENCES defaults.Perks (Id),
  EffectId    INTEGER REFERENCES defaults.Effects (Id),
  Amount      INTEGER,

  CHECK ( num_nonnulls(PointTypeId, ItemId, PerkId, EffectId) = 1 )
);

CREATE TABLE IF NOT EXISTS party.ChangeEntries
(
  Id          SERIAL PRIMARY KEY,
  PartyId     INTEGER NOT NULL REFERENCES common.Parties (Id),
  ChangeId    INTEGER NOT NULL,
  PointTypeId INTEGER,
  ItemId      INTEGER,
  PerkId      INTEGER,
  EffectId    INTEGER,
  Amount      INTEGER,

  CHECK ( num_nonnulls(PointTypeId, ItemId, PerkId, EffectId) = 1 ),
  FOREIGN KEY (ChangeId, PartyId) REFERENCES party.Changes (Id, PartyId),
  FOREIGN KEY (PointTypeId, PartyId) REFERENCES party.PointTypes (Id, PartyId),
  FOREIGN KEY (ItemId, PartyId) REFERENCES party.Items (Id, PartyId),
  FOREIGN KEY (PerkId, PartyId) REFERENCES party.Perks (Id, PartyId),
  FOREIGN KEY (EffectId, PartyId) REFERENCES party.Effects (Id, PartyId)
);
