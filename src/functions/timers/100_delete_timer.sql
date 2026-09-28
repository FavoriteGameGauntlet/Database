CREATE OR REPLACE FUNCTION delete_timer(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS TABLE (
    id               INTEGER,
    user_id          INTEGER,
    party_id         INTEGER,
    game_id          INTEGER,
    state            TEXT,
    duration         INTERVAL,
    time_spent       INTERVAL,
    last_action_date TIMESTAMP
  )
  LANGUAGE sql
AS
$$
DELETE
FROM users.Timers
WHERE UserId = _user_id
  AND PartyId = _party_id
RETURNING Id, UserId, PartyId, GameId, State, Duration,
  LEAST(CASE State
          WHEN 'running' THEN TimeSpent + (NOW() - LastActionDate)
          ELSE TimeSpent
          END, Duration) AS TimeSpent,
  NOW() AS LastActionDate
$$;
