CREATE TABLE IF NOT EXISTS defaults.WheelRows
(
  Id          SERIAL PRIMARY KEY,
  Name        TEXT    NOT NULL UNIQUE,
  Description TEXT    NOT NULL,
  ChangeId    INTEGER REFERENCES defaults.Changes (Id)
);

CREATE TABLE IF NOT EXISTS party.WheelRows
(
  Id          SERIAL PRIMARY KEY,
  PartyId     INTEGER NOT NULL REFERENCES common.Parties (Id),
  Name        TEXT    NOT NULL,
  Description TEXT    NOT NULL,
  ChangeId    INTEGER,

  UNIQUE (PartyId, Name),
  UNIQUE (Id, PartyId),
  FOREIGN KEY (ChangeId, PartyId) REFERENCES party.Changes (Id, PartyId)
);
