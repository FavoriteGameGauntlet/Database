CREATE OR REPLACE FUNCTION create_party(
  _name TEXT
)
  RETURNS TABLE (
    id           INTEGER,
    name         TEXT,
    created_date TIMESTAMP
  )
  LANGUAGE sql
AS
$$
INSERT INTO common.Parties (Name)
VALUES (_name)
RETURNING Id, Name, CreatedDate
$$;
