CREATE TABLE IF NOT EXISTS party.EffectTriggers
(
  Id        SERIAL PRIMARY KEY,
  PartyId   INTEGER NOT NULL REFERENCES common.Parties (Id),
  EffectId  INTEGER NOT NULL,
  TriggerId INTEGER NOT NULL,

  UNIQUE (PartyId, EffectId, TriggerId),
  FOREIGN KEY (EffectId, PartyId) REFERENCES party.Effects (Id, PartyId),
  FOREIGN KEY (TriggerId, PartyId) REFERENCES party.Triggers (Id, PartyId)
);
