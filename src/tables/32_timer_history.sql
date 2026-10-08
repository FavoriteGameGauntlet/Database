CREATE TABLE IF NOT EXISTS users.TimerHistory (
  Id            INTEGER PRIMARY KEY,
  PartyId       INTEGER NOT NULL REFERENCES common.Parties (Id),
  TimerRewardId INTEGER,

  UNIQUE (Id, PartyId),
  FOREIGN KEY (Id, PartyId) REFERENCES users.HistoryEvents (Id, PartyId),
  FOREIGN KEY (TimerRewardId, PartyId) REFERENCES party.TimerRewards (Id, PartyId)
);
