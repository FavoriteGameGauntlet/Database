CREATE OR REPLACE FUNCTION change_system_parameter_value(_name TEXT, _value TEXT)
RETURNS void
LANGUAGE sql AS $$
    UPDATE SystemParameters SET Value = _value WHERE Name = _name
$$;
