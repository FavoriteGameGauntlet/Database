CREATE TABLE IF NOT EXISTS users.PointHistory
(
  Id                 SERIAL PRIMARY KEY,
  UserId             INTEGER   NOT NULL REFERENCES common.Users (Id),
  PartyId            INTEGER   NOT NULL REFERENCES common.Parties (Id),
  PointTypeId        INTEGER   NOT NULL,
  SourceUserId       INTEGER   NOT NULL REFERENCES common.Users (Id),
  DesiredChangeValue INTEGER   NOT NULL,
  ActualChangeValue  INTEGER   NOT NULL,
  FinalValue         INTEGER   NOT NULL,
  ExchangeHistoryId  INTEGER,
  WheelRowHistoryId  INTEGER,
  EffectHistoryId    INTEGER,
  ItemHistoryId      INTEGER,
  ChangedDate        TIMESTAMP NOT NULL DEFAULT NOW(),

  CHECK ( num_nonnulls(ExchangeHistoryId, WheelRowHistoryId, EffectHistoryId, ItemHistoryId) = 1 ),
  FOREIGN KEY (PointTypeId, PartyId) REFERENCES party.PointTypes (Id, PartyId),
  FOREIGN KEY (ExchangeHistoryId, PartyId) REFERENCES users.ExchangeHistory (Id, PartyId),
  FOREIGN KEY (WheelRowHistoryId, PartyId) REFERENCES users.WheelRowHistory (Id, PartyId),
  FOREIGN KEY (EffectHistoryId, PartyId) REFERENCES users.EffectHistory (Id, PartyId),
  FOREIGN KEY (ItemHistoryId, PartyId) REFERENCES users.ItemHistory (Id, PartyId)
);

CREATE TABLE IF NOT EXISTS party.PointHistory
(
  Id                 SERIAL PRIMARY KEY,
  PartyId            INTEGER   NOT NULL REFERENCES common.Parties (Id),
  PointTypeId        INTEGER   NOT NULL,
  SourceUserId       INTEGER   NOT NULL REFERENCES common.Users (Id),
  DesiredChangeValue INTEGER   NOT NULL,
  ActualChangeValue  INTEGER   NOT NULL,
  FinalValue         INTEGER   NOT NULL,
  ExchangeHistoryId  INTEGER,
  WheelRowHistoryId  INTEGER,
  EffectHistoryId    INTEGER,
  ItemHistoryId      INTEGER,
  ChangedDate        TIMESTAMP NOT NULL DEFAULT NOW(),

  CHECK ( num_nonnulls(ExchangeHistoryId, WheelRowHistoryId, EffectHistoryId, ItemHistoryId) = 1 ),
  FOREIGN KEY (PointTypeId, PartyId) REFERENCES party.PointTypes (Id, PartyId),
  FOREIGN KEY (ExchangeHistoryId, PartyId) REFERENCES users.ExchangeHistory (Id, PartyId),
  FOREIGN KEY (WheelRowHistoryId, PartyId) REFERENCES users.WheelRowHistory (Id, PartyId),
  FOREIGN KEY (EffectHistoryId, PartyId) REFERENCES users.EffectHistory (Id, PartyId),
  FOREIGN KEY (ItemHistoryId, PartyId) REFERENCES users.ItemHistory (Id, PartyId)
);
