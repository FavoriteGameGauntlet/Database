CREATE OR REPLACE FUNCTION change_member_admin_status(
  _user_id INTEGER,
  _party_id INTEGER,
  _is_admin BOOLEAN
)
  RETURNS void
  LANGUAGE sql AS
$$
UPDATE party.Members
SET IsAdmin = _is_admin
WHERE UserId = _user_id
  AND PartyId = _party_id
$$;
