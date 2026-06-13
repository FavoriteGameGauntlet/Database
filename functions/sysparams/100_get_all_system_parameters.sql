CREATE OR REPLACE FUNCTION get_all_system_parameters()
RETURNS TABLE(id INTEGER, name TEXT, value TEXT)
LANGUAGE sql AS $$
    SELECT Id, Name, Value FROM SystemParameters
$$;
