CREATE OR REPLACE FUNCTION create_member(
  _user_id INTEGER,
  _party_id INTEGER,
  _display_name TEXT,
  _is_admin BOOLEAN
)
  RETURNS TABLE (
    id           INTEGER,
    user_id      INTEGER,
    party_id     INTEGER,
    display_name TEXT,
    is_admin     BOOLEAN,
    joined_date  TIMESTAMP,
    left_date    TIMESTAMP
  )
  LANGUAGE sql
AS
$$
INSERT INTO party.Members (UserId, PartyId, DisplayName, IsAdmin)
VALUES (_user_id, _party_id, _display_name, _is_admin)
RETURNING Id, UserId, PartyId, DisplayName, IsAdmin, JoinedDate, LeftDate
$$;
