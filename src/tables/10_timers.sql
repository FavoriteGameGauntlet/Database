CREATE TABLE IF NOT EXISTS users.Timers
(
  Id             SERIAL PRIMARY KEY,
  UserId         INTEGER          NOT NULL REFERENCES common.Users (Id),
  PartyId        INTEGER          NOT NULL REFERENCES common.Parties (Id),
  GameId         INTEGER          NOT NULL,
  State          users.TimerState NOT NULL DEFAULT 'created',
  Duration       INTERVAL         NOT NULL CHECK ( Duration >= INTERVAL '0' ),
  TimeSpent INTERVAL NOT NULL DEFAULT INTERVAL '0' CHECK ( TimeSpent >= INTERVAL '0' ),
  CreatedDate    TIMESTAMP        NOT NULL DEFAULT NOW(),
  LastActionDate TIMESTAMP        NOT NULL DEFAULT NOW(),

  UNIQUE (UserId, PartyId),
  FOREIGN KEY (GameId, PartyId) REFERENCES party.Games (Id, PartyId)
);
