CREATE OR REPLACE FUNCTION get_system_parameter(_name TEXT)
RETURNS TABLE(id INTEGER, name TEXT, value TEXT)
LANGUAGE sql AS $$
    SELECT Id, Name, Value FROM SystemParameters WHERE Name = _name
$$;
