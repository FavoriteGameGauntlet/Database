CREATE OR REPLACE FUNCTION get_all_user_games(
  _party_id INTEGER
)
  RETURNS TABLE (
    id         INTEGER,
    name       TEXT,
    time_spent INTERVAL,
    login      TEXT
  )
  LANGUAGE sql
AS
$$
SELECT g.Id, g.Name, gh.TimeSpent, u.Login
FROM users.Games gh
       INNER JOIN party.Games g ON g.Id = gh.GameId AND g.PartyId = gh.PartyId
       INNER JOIN common.Users u ON u.Id = gh.UserId
WHERE gh.PartyId = _party_id
$$;
