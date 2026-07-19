CREATE OR REPLACE FUNCTION remove_exchange(
  _party_id INTEGER,
  _exchange_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
UPDATE party.Exchanges
SET IsRemoved = TRUE
WHERE Id = _exchange_id
  AND PartyId = _party_id
$$;
