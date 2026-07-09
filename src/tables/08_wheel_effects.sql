CREATE TABLE IF NOT EXISTS WheelEffects (
    Id                      SERIAL PRIMARY KEY,
    Name                    TEXT NOT NULL UNIQUE,
    Description             TEXT NOT NULL
);
