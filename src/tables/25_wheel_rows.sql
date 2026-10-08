CREATE TABLE IF NOT EXISTS defaults.WheelRows
(
  Id           SERIAL PRIMARY KEY,
  Name         TEXT    NOT NULL UNIQUE,
  Description  TEXT    NOT NULL,
  ChangeId     INTEGER NOT NULL REFERENCES defaults.Changes (Id),
  CollectionId INTEGER NOT NULL REFERENCES defaults.WheelCollections (Id)
);

CREATE TABLE IF NOT EXISTS party.WheelRows
(
  Id           SERIAL PRIMARY KEY,
  PartyId      INTEGER NOT NULL REFERENCES common.Parties (Id),
  Name         TEXT    NOT NULL,
  Description  TEXT    NOT NULL,
  ChangeId     INTEGER NOT NULL,
  CollectionId INTEGER NOT NULL,

  UNIQUE (PartyId, Name),
  UNIQUE (Id, PartyId),
  FOREIGN KEY (ChangeId, PartyId) REFERENCES party.Changes (Id, PartyId),
  FOREIGN KEY (CollectionId, PartyId) REFERENCES party.WheelCollections (Id, PartyId)
);
