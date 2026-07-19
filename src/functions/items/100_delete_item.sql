CREATE OR REPLACE FUNCTION delete_item(_party_id INTEGER, _item_id INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE party.Items SET IsRemoved = TRUE WHERE Id = _item_id AND PartyId = _party_id
$$;
