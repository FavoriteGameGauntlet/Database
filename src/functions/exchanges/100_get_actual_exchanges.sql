CREATE OR REPLACE FUNCTION get_actual_exchanges(
  _party_id INTEGER
)
  RETURNS TABLE (
    id          INTEGER,
    party_id    INTEGER,
    name        TEXT,
    description TEXT
  )
  LANGUAGE sql
AS
$$
SELECT Id, PartyId, Name, Description
FROM party.Exchanges
WHERE PartyId = _party_id
  AND NOT IsRemoved
$$;
