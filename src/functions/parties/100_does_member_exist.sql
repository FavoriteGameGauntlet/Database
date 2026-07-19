CREATE OR REPLACE FUNCTION does_member_exist(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS BOOLEAN
  LANGUAGE sql AS
$$
SELECT EXISTS (SELECT 1
               FROM party.Members
               WHERE UserId = _user_id AND PartyId = _party_id)
$$;
