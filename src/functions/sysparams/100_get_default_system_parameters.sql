CREATE OR REPLACE FUNCTION get_default_system_parameters(
)
  RETURNS TABLE (
    id            INTEGER,
    code          TEXT,
    default_value TEXT,
    name          TEXT,
    description   TEXT
  )
  LANGUAGE sql
AS
$$
SELECT Id, Code, DefaultValue, Name, Description
FROM defaults.SystemParameters
$$;
