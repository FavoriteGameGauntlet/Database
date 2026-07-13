CREATE TABLE IF NOT EXISTS users.EffectHistory
(
  Id        SERIAL PRIMARY KEY,
  UserId    INTEGER   NOT NULL REFERENCES common.Users (Id),
  PartyId   INTEGER   NOT NULL REFERENCES common.Parties (Id),
  EffectId  INTEGER   NOT NULL,
  StartedDate TIMESTAMP NOT NULL DEFAULT NOW(),
  EndDate   TIMESTAMP CHECK ( EndDate IS NULL OR StartedDate < EndDate ),

  UNIQUE (Id, PartyId),
  FOREIGN KEY (EffectId, PartyId) REFERENCES party.Effects (Id, PartyId)
);
