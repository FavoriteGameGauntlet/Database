CREATE TABLE IF NOT EXISTS TerritoryPointHistory (
    Id                SERIAL PRIMARY KEY,
    UserId            INTEGER NOT NULL REFERENCES Users (Id),
    SourceUserId      INTEGER NOT NULL REFERENCES Users (Id),
    ChangeSource      TEXT NOT NULL,
    ChangeValue       INTEGER NOT NULL,
    ActualChangeValue INTEGER NOT NULL,
    FinalValue        INTEGER NOT NULL CHECK (FinalValue >= 0),
    ChangeDate        TIMESTAMP NOT NULL DEFAULT NOW()
);
