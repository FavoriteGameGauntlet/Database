CREATE OR REPLACE FUNCTION act_timer(
  _timer_id INTEGER,
  _state TEXT,
  _time_spent INTERVAL
)
  RETURNS void
  LANGUAGE sql AS
$$
UPDATE users.Timers
SET State          = _state::users.TimerState,
    TimeSpent      = _time_spent,
    LastActionDate = NOW()
WHERE Id = _timer_id
$$;
