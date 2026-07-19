CREATE OR REPLACE FUNCTION get_effects(_party_id INTEGER)
RETURNS TABLE(id INTEGER, party_id INTEGER, name TEXT, description TEXT, use_count INTEGER, duration INTERVAL, change_id INTEGER)
LANGUAGE sql AS $$
    SELECT Id, PartyId, Name, Description, UseCount, Duration, ChangeId
    FROM party.Effects
    WHERE PartyId = _party_id
$$;
