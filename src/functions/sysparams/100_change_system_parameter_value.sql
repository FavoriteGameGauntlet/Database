-- Returns whether the party's override was created rather than changed: a freshly inserted row has
-- no xmax, while a row the upsert updated carries the updating transaction's id in it.
CREATE OR REPLACE FUNCTION change_system_parameter_value(
  _party_id INTEGER,
  _system_parameter_id INTEGER,
  _value TEXT
)
  RETURNS BOOLEAN
  LANGUAGE sql AS
$$
INSERT INTO party.SystemParameters (PartyId, SystemParameterId, Value)
VALUES (_party_id, _system_parameter_id, _value)
ON CONFLICT (PartyId, SystemParameterId) DO UPDATE SET Value = EXCLUDED.Value
RETURNING xmax = 0
$$;
