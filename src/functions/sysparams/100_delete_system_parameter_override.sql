CREATE OR REPLACE FUNCTION delete_system_parameter_override(
  _party_id INTEGER,
  _system_parameter_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
DELETE
FROM party.SystemParameters
WHERE PartyId = _party_id
  AND SystemParameterId = _system_parameter_id
$$;
