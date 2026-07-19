CREATE OR REPLACE FUNCTION get_user_perk(
  _user_id INTEGER,
  _party_id INTEGER,
  _perk_id INTEGER
)
  RETURNS TABLE (
    id             INTEGER,
    user_id        INTEGER,
    party_id       INTEGER,
    perk_id        INTEGER,
    user_effect_id INTEGER,
    received_date  TIMESTAMP
  )
  LANGUAGE sql
AS
$$
SELECT Id, UserId, PartyId, PerkId, UserEffectId, ReceivedDate
FROM users.Perks
WHERE UserId = _user_id
  AND PartyId = _party_id
  AND PerkId = _perk_id
$$;
