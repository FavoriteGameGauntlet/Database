CREATE OR REPLACE FUNCTION get_user_game(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS TABLE (
    id           INTEGER,
    name         TEXT,
    state        TEXT,
    time_spent   INTERVAL,
    started_date TIMESTAMP
  )
  LANGUAGE sql
AS
$$
SELECT g.Id, g.Name, gh.State, gh.TimeSpent, gh.StartedDate
FROM users.Games gh
       INNER JOIN party.Games g ON g.Id = gh.GameId AND g.PartyId = gh.PartyId
WHERE gh.UserId = _user_id
  AND gh.PartyId = _party_id
  AND gh.State = 'current'
$$;
