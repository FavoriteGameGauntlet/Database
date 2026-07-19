CREATE OR REPLACE FUNCTION end_perk_history(_user_id INTEGER, _party_id INTEGER, _perk_history_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE users.PerkHistory
    SET RemovedDate = NOW()
    WHERE Id = _perk_history_id AND UserId = _user_id AND PartyId = _party_id
$$;
