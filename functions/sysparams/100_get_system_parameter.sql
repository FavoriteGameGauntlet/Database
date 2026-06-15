CREATE OR REPLACE FUNCTION get_system_parameter(_name TEXT)
RETURNS TABLE(id INTEGER, name TEXT, value TEXT, should_show_to_app BOOLEAN)
LANGUAGE sql AS $$
    SELECT Id, Name, Value, ShouldShowToApp FROM SystemParameters WHERE Name = _name
$$;
