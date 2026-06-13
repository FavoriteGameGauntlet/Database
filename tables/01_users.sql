CREATE TABLE IF NOT EXISTS Users (
    Id          SERIAL PRIMARY KEY,
    Login       TEXT NOT NULL UNIQUE,
    DisplayName TEXT UNIQUE,
    Email       TEXT NOT NULL UNIQUE,
    Password    TEXT NOT NULL,
    JoinDate    TIMESTAMP NOT NULL DEFAULT NOW()
);
