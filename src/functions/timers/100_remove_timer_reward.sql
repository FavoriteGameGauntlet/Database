CREATE OR REPLACE FUNCTION remove_timer_reward(
  _party_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
UPDATE party.TimerRewards
SET IsRemoved = TRUE
WHERE PartyId = _party_id
  AND NOT IsRemoved
$$;
