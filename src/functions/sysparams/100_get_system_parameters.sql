CREATE OR REPLACE FUNCTION get_system_parameters(
  _party_id INTEGER
)
  RETURNS TABLE (
    id          INTEGER,
    code        TEXT,
    name        TEXT,
    description TEXT,
    value       TEXT,
    is_default  BOOLEAN
  )
  LANGUAGE sql
AS
$$
SELECT sp.Id,
       sp.Code,
       sp.Name,
       sp.Description,
       COALESCE(psp.Value, sp.DefaultValue) AS Value,
       psp.SystemParameterId IS NULL        AS IsDefault
FROM defaults.SystemParameters sp
       LEFT JOIN party.SystemParameters psp ON psp.SystemParameterId = sp.Id AND psp.PartyId = _party_id
$$;
