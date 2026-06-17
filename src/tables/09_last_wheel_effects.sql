CREATE TABLE IF NOT EXISTS LastWheelEffects (
    Id            SERIAL PRIMARY KEY,
    UserId        INTEGER NOT NULL REFERENCES Users (Id),
    WheelEffectId INTEGER NOT NULL REFERENCES WheelEffects (Id),
    Position      INTEGER NOT NULL,
    IsApplied     INTEGER NOT NULL DEFAULT 0 CHECK (IsApplied IN (0, 1)),
    RollDate      TIMESTAMP NOT NULL DEFAULT NOW()
);
