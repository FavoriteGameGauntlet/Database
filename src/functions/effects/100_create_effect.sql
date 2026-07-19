CREATE OR REPLACE FUNCTION create_effect(
  _party_id INTEGER,
  _name TEXT,
  _description TEXT,
  _use_count INTEGER,
  _duration INTERVAL,
  _change JSONB
)
  RETURNS TABLE (
    effect_id   INTEGER,
    party_id    INTEGER,
    name        TEXT,
    description TEXT,
    use_count   INTEGER,
    duration    INTERVAL,
    change      JSONB
  )
  LANGUAGE sql
AS
$$
WITH
  change AS (SELECT create_change_from_jsonb(_party_id, _change) AS data),

  effect AS (
    INSERT INTO party.Effects (PartyId, Name, Description, UseCount, Duration, ChangeId)
      VALUES (_party_id, _name, _description, _use_count, _duration,
              ((SELECT data FROM change) ->> 'change_id')::integer)
      RETURNING Id, PartyId, Name, Description, UseCount, Duration)
SELECT ef.Id,
       ef.PartyId,
       ef.Name,
       ef.Description,
       ef.UseCount,
       ef.Duration,
       (SELECT data FROM change)
FROM effect ef
$$;
