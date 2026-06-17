CREATE OR REPLACE FUNCTION get_all_system_parameters()
RETURNS TABLE(id INTEGER, name TEXT, value TEXT, should_show_to_app BOOLEAN)
LANGUAGE sql AS $$
    SELECT Id, Name, Value, ShouldShowToApp FROM SystemParameters
$$;
