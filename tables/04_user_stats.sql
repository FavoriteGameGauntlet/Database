CREATE TABLE IF NOT EXISTS UserStats (
    Id               SERIAL PRIMARY KEY,
    UserId           INTEGER NOT NULL UNIQUE REFERENCES Users (Id),
    AvailableRolls   INTEGER NOT NULL DEFAULT 0,
    TerritoryHours   INTEGER NOT NULL DEFAULT 0,
    ExperiencePoints INTEGER NOT NULL DEFAULT 0,
    TerritoryPoints  INTEGER NOT NULL DEFAULT 0,
    FreePoints       INTEGER NOT NULL DEFAULT 0
);
