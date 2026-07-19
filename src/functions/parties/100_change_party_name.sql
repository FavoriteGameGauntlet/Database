CREATE OR REPLACE FUNCTION change_party_name(
  _party_id INTEGER,
  _name TEXT
)
  RETURNS void
  LANGUAGE sql AS
$$
UPDATE common.Parties
SET Name = _name
WHERE Id = _party_id
$$;
