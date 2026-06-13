CREATE OR REPLACE FUNCTION get_system_parameter(p_name TEXT)
RETURNS TABLE(id INTEGER, name TEXT, value TEXT)
LANGUAGE sql AS $$
    SELECT Id, Name, Value FROM SystemParameters WHERE Name = p_name
$$;
