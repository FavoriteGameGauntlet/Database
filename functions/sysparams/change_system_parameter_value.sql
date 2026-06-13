CREATE OR REPLACE FUNCTION change_system_parameter_value(p_name TEXT, p_value TEXT)
RETURNS void
LANGUAGE sql AS $$
    UPDATE SystemParameters SET Value = p_value WHERE Name = p_name
$$;
