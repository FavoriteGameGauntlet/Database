CREATE TABLE IF NOT EXISTS users.HistoryEvents (
  Id            SERIAL PRIMARY KEY,
  UserId        INTEGER                 NOT NULL REFERENCES common.Users (Id),
  PartyId       INTEGER                 NOT NULL REFERENCES common.Parties (Id),
  Type          users.HistoryEventType  NOT NULL,
  Action        users.HistoryActionType NOT NULL,
  SourceEventId INTEGER,
  CreatedDate   TIMESTAMP               NOT NULL DEFAULT NOW(),

  UNIQUE (Id, PartyId),
  FOREIGN KEY (SourceEventId, PartyId) REFERENCES users.HistoryEvents (Id, PartyId),

  CHECK ( Type IN ('manual', 'wheel_row', 'exchange') OR SourceEventId IS NOT NULL ),

  CHECK (
    (Type = 'point' AND Action = 'changed')
      OR (Type IN ('exchange', 'wheel_row', 'manual') AND Action = 'added')
      OR (Type IN ('effect', 'item', 'perk', 'game'))
    )
);
