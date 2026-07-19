CREATE OR REPLACE FUNCTION get_party(
  _party_id INTEGER
)
  RETURNS TABLE (
    id           INTEGER,
    name         TEXT,
    created_date TIMESTAMP
  )
  LANGUAGE sql
AS
$$
SELECT Id, Name, CreatedDate
FROM common.Parties
WHERE Id = _party_id
$$;
