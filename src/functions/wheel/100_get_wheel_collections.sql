CREATE OR REPLACE FUNCTION get_wheel_collections(
  _party_id INTEGER
)
  RETURNS TABLE (
    id                   INTEGER,
    party_id             INTEGER,
    name                 TEXT,
    should_check_history BOOLEAN
  )
  LANGUAGE sql
AS
$$
SELECT Id, PartyId, Name, ShouldCheckHistory
FROM party.WheelCollections
WHERE PartyId = _party_id
  AND NOT IsRemoved
$$;
