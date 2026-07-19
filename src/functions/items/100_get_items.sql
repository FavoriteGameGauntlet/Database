CREATE OR REPLACE FUNCTION get_items(_party_id INTEGER)
RETURNS TABLE(id INTEGER, party_id INTEGER, name TEXT, description TEXT, use_count INTEGER, change_id INTEGER)
LANGUAGE sql AS $$
    SELECT Id, PartyId, Name, Description, UseCount, ChangeId
    FROM party.Items
    WHERE PartyId = _party_id AND NOT IsRemoved
$$;
