CREATE OR REPLACE FUNCTION delete_party(
  _party_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
DELETE
FROM common.Parties
WHERE Id = _party_id
$$;
