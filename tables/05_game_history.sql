CREATE TABLE IF NOT EXISTS GameHistory (
    Id         SERIAL PRIMARY KEY,
    UserId     INTEGER NOT NULL REFERENCES Users (Id),
    GameId     INTEGER NOT NULL REFERENCES Games (Id),
    State      TEXT NOT NULL DEFAULT 'started',
    ChangeDate TIMESTAMP NOT NULL DEFAULT NOW(),
    FinishDate TIMESTAMP
);
