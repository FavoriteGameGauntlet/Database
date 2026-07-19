CREATE OR REPLACE FUNCTION change_member_display_name(
  _user_id INTEGER,
  _party_id INTEGER,
  _display_name TEXT
)
  RETURNS void
  LANGUAGE sql AS
$$
UPDATE party.Members
SET DisplayName = _display_name
WHERE UserId = _user_id
  AND PartyId = _party_id
$$;
