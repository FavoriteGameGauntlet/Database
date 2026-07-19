CREATE OR REPLACE FUNCTION delete_perk(_party_id INTEGER, _perk_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE party.Perks SET IsRemoved = TRUE WHERE Id = _perk_id AND PartyId = _party_id
$$;
