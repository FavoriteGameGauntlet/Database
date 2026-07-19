CREATE OR REPLACE FUNCTION get_wheel_groups(
  _party_id INTEGER
)
  RETURNS TABLE (
    id       INTEGER,
    party_id INTEGER,
    name     TEXT
  )
  LANGUAGE sql
AS
$$
SELECT Id, PartyId, Name
FROM party.WheelGroups
WHERE PartyId = _party_id
  AND NOT IsRemoved
$$;
