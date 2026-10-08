CREATE TABLE IF NOT EXISTS defaults.TimerRewards (
  Id       SERIAL PRIMARY KEY,
  ChangeId INTEGER NOT NULL REFERENCES defaults.Changes (Id)
);

CREATE TABLE IF NOT EXISTS party.TimerRewards (
  Id        SERIAL PRIMARY KEY,
  PartyId   INTEGER NOT NULL REFERENCES common.Parties (Id),
  ChangeId  INTEGER NOT NULL,
  IsRemoved BOOLEAN NOT NULL DEFAULT FALSE,

  UNIQUE (Id, PartyId),
  FOREIGN KEY (ChangeId, PartyId) REFERENCES party.Changes (Id, PartyId)
);

CREATE UNIQUE INDEX IF NOT EXISTS TimerRewardsPartyIdUnique
  ON party.TimerRewards (PartyId) WHERE NOT IsRemoved;
