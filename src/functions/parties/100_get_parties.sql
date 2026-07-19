CREATE OR REPLACE FUNCTION get_parties(
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
$$;
