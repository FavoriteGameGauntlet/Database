CREATE OR REPLACE FUNCTION set_timer_reward(
  _party_id INTEGER,
  _change JSONB
)
  RETURNS INTEGER
  LANGUAGE sql
AS
$$
UPDATE party.TimerRewards
SET IsRemoved = TRUE
WHERE PartyId = _party_id
  AND NOT IsRemoved;

WITH
  change AS (SELECT create_change_from_jsonb(_party_id, _change) AS data)

INSERT INTO party.TimerRewards (PartyId, ChangeId)
VALUES (_party_id, ((SELECT data FROM change) ->> 'change_id')::integer)
RETURNING Id;
$$;
