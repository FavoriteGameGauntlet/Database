CREATE TABLE IF NOT EXISTS common.Parties
(
  Id          SERIAL PRIMARY KEY,
  Name        TEXT      NOT NULL,
  CreatedDate TIMESTAMP NOT NULL DEFAULT NOW()
);
