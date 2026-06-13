CREATE OR REPLACE FUNCTION create_game(_name TEXT)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO Games (Name) VALUES (_name)
$$;
