CREATE OR REPLACE FUNCTION delete_ended_timers(
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
WHERE State != 'created'
  AND CASE State
        WHEN 'running' THEN TimeSpent + (NOW() - LastActionDate)
        ELSE TimeSpent
        END >= Duration
RETURNING Id, UserId, PartyId, GameId, State, Duration, Duration AS TimeSpent, NOW() AS LastActionDate
$$;
