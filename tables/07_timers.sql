CREATE TABLE IF NOT EXISTS Timers (
    Id               SERIAL PRIMARY KEY,
    UserId           INTEGER NOT NULL REFERENCES Users (Id),
    GameId           INTEGER NOT NULL REFERENCES Games (Id),
    State            TEXT NOT NULL DEFAULT 'created',
    DurationInS      INTEGER NOT NULL,
    RemainingTimeInS INTEGER NOT NULL,
    CreateDate       TIMESTAMP NOT NULL DEFAULT NOW(),
    LastActionDate   TIMESTAMP NOT NULL DEFAULT NOW()
);
