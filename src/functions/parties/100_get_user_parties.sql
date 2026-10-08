CREATE OR REPLACE FUNCTION get_user_parties(
  _user_id INTEGER
)
  RETURNS TABLE (
    id           INTEGER,
    name         TEXT,
    created_date TIMESTAMP
  )
  LANGUAGE sql
AS
$$
SELECT p.Id, p.Name, p.CreatedDate
FROM common.Parties p
       INNER JOIN party.Members m ON m.PartyId = p.Id
WHERE m.UserId = _user_id
  AND m.LeftDate IS NULL
$$;
