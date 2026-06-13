CREATE OR REPLACE FUNCTION create_game(p_name TEXT)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO Games (Name) VALUES (p_name)
$$;
