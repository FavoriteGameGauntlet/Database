CREATE OR REPLACE FUNCTION create_wheel_collection(
  _party_id INTEGER,
  _name TEXT,
  _should_check_history BOOLEAN DEFAULT TRUE
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
INSERT INTO party.WheelCollections (PartyId, Name, ShouldCheckHistory)
VALUES (_party_id, _name, _should_check_history)
RETURNING Id, PartyId, Name, ShouldCheckHistory
$$;
