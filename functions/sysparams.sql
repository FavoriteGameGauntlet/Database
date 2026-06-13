CREATE OR REPLACE FUNCTION get_all_system_parameters()
RETURNS TABLE(id INTEGER, name TEXT, value TEXT)
LANGUAGE sql AS $$
    SELECT Id, Name, Value FROM SystemParameters
$$;

CREATE OR REPLACE FUNCTION get_system_parameter(p_name TEXT)
RETURNS TABLE(id INTEGER, name TEXT, value TEXT)
LANGUAGE sql AS $$
    SELECT Id, Name, Value FROM SystemParameters WHERE Name = p_name
$$;

CREATE OR REPLACE FUNCTION change_system_parameter_value(p_name TEXT, p_value TEXT)
RETURNS void
LANGUAGE sql AS $$
    UPDATE SystemParameters SET Value = p_value WHERE Name = p_name
$$;
