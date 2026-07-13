CREATE TABLE IF NOT EXISTS party.Games
(
  Id         SERIAL PRIMARY KEY,
  PartyId    INTEGER   NOT NULL REFERENCES common.Parties (Id),
  Name       TEXT      NOT NULL,

  UNIQUE (PartyId, Name),
  UNIQUE (Id, PartyId)
);
