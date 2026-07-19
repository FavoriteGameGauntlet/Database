CREATE OR REPLACE FUNCTION remove_member(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
UPDATE party.Members
SET LeftDate = NOW()
WHERE UserId = _user_id
  AND PartyId = _party_id
$$;
