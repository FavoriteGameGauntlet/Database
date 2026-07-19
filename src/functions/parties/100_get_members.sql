CREATE OR REPLACE FUNCTION get_members(
  _party_id INTEGER
)
  RETURNS TABLE (
    id           INTEGER,
    user_id      INTEGER,
    party_id     INTEGER,
    login        TEXT,
    display_name TEXT,
    is_admin     BOOLEAN,
    joined_date  TIMESTAMP,
    left_date    TIMESTAMP
  )
  LANGUAGE sql
AS
$$
SELECT m.Id,
       m.UserId,
       m.PartyId,
       u.Login,
       m.DisplayName,
       m.IsAdmin,
       m.JoinedDate,
       m.LeftDate
FROM party.Members m
       INNER JOIN common.Users u ON u.Id = m.UserId
WHERE m.PartyId = _party_id
$$;
