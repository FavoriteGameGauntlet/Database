CREATE OR REPLACE FUNCTION get_timer(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS TABLE (
    id               INTEGER,
    game_id          INTEGER,
    state            TEXT,
    duration         INTERVAL,
    last_action_date TIMESTAMP,
    time_spent       INTERVAL
  )
  LANGUAGE sql
AS
$$
SELECT t.Id,
       t.GameId,
       t.State,
       t.Duration,
       t.LastActionDate,
       CASE
         WHEN t.State = 'running' THEN t.TimeSpent + (NOW() - t.LastActionDate)
         ELSE t.TimeSpent
         END AS TimeSpent
FROM users.Timers t
WHERE t.UserId = _user_id
  AND t.PartyId = _party_id
$$;
