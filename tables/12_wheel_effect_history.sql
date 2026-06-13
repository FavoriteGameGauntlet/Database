CREATE TABLE IF NOT EXISTS WheelEffectHistory (
    Id            SERIAL PRIMARY KEY,
    UserId        INTEGER NOT NULL REFERENCES Users (Id),
    WheelEffectId INTEGER NOT NULL REFERENCES WheelEffects (Id),
    RollDate      TIMESTAMP NOT NULL DEFAULT NOW()
);
