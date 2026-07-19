CREATE TABLE IF NOT EXISTS defaults.WheelRows
(
  Id          SERIAL PRIMARY KEY,
  Name        TEXT    NOT NULL UNIQUE,
  Description TEXT    NOT NULL,
  ChangeId INTEGER NOT NULL REFERENCES defaults.Changes (Id),
  GroupId  INTEGER NOT NULL REFERENCES defaults.WheelGroups (Id)
);

CREATE TABLE IF NOT EXISTS party.WheelRows
(
  Id          SERIAL PRIMARY KEY,
  PartyId     INTEGER NOT NULL REFERENCES common.Parties (Id),
  Name        TEXT    NOT NULL,
  Description TEXT    NOT NULL,
  ChangeId INTEGER NOT NULL,
  GroupId  INTEGER NOT NULL,

  UNIQUE (PartyId, Name),
  UNIQUE (Id, PartyId),
  FOREIGN KEY (ChangeId, PartyId) REFERENCES party.Changes (Id, PartyId),
  FOREIGN KEY (GroupId, PartyId) REFERENCES party.WheelGroups (Id, PartyId)
);
