CREATE OR REPLACE FUNCTION change_system_parameter_value(
  _party_id INTEGER,
  _system_parameter_id INTEGER,
  _value TEXT
)
  RETURNS void
  LANGUAGE sql AS
$$
INSERT INTO party.SystemParameters (PartyId, SystemParameterId, Value)
VALUES (_party_id, _system_parameter_id, _value)
ON CONFLICT (PartyId, SystemParameterId) DO UPDATE SET Value = EXCLUDED.Value
$$;
