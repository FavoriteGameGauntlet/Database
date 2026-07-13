DO
$$
  BEGIN
    CREATE TYPE users.GameHistoryState AS ENUM ('started', 'finished', 'cancelled');
  EXCEPTION
    WHEN duplicate_object THEN NULL;
  END
$$;

CREATE TABLE IF NOT EXISTS users.GameHistory
(
  Id            SERIAL PRIMARY KEY,
  UserId        INTEGER                NOT NULL REFERENCES common.Users (Id),
  PartyId       INTEGER                NOT NULL REFERENCES common.Parties (Id),
  GameId        INTEGER                NOT NULL,
  State         users.GameHistoryState NOT NULL DEFAULT 'started',
  TimeSpent     INTERVAL               NOT NULL DEFAULT INTERVAL '0' CHECK ( TimeSpent >= INTERVAL '0' ),
  Rating        SMALLINT CHECK ( Rating BETWEEN 1 AND 10 ),
  ReviewComment TEXT,
  StartedDate   TIMESTAMP              NOT NULL DEFAULT NOW(),
  FinishedDate  TIMESTAMP CHECK ( StartedDate < FinishedDate ),

  UNIQUE (UserId, PartyId, GameId),
  FOREIGN KEY (GameId, PartyId) REFERENCES party.Games (Id, PartyId)
);
