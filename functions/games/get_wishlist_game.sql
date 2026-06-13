CREATE OR REPLACE FUNCTION get_wishlist_game(_name TEXT)
RETURNS TABLE(id INTEGER, name TEXT)
LANGUAGE sql AS $$
    SELECT Id, Name FROM Games WHERE Name = _name
$$;
