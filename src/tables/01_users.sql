CREATE TABLE IF NOT EXISTS common.Users
(
  Id          SERIAL PRIMARY KEY,
  Login       TEXT      NOT NULL UNIQUE,
  Email       TEXT      NOT NULL UNIQUE,
  Password    TEXT      NOT NULL,
  JoinedDate    TIMESTAMP NOT NULL DEFAULT NOW()
);
