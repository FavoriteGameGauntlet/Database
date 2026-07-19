CREATE OR REPLACE FUNCTION create_exchange(
  _party_id INTEGER,
  _name TEXT,
  _description TEXT,
  _source_change JSONB,
  _target_change JSONB
)
  RETURNS TABLE (
    exchange_id   INTEGER,
    exchange_name TEXT,
    description   TEXT,
    source_change JSONB,
    target_change JSONB
  )
  LANGUAGE sql
AS
$$
WITH
  source_change AS (SELECT create_change_from_jsonb(_party_id, _source_change) AS data),

  target_change AS (SELECT create_change_from_jsonb(_party_id, _target_change) AS data),

  exchange AS (
    INSERT INTO party.Exchanges (PartyId, Name, Description, SourceChangeId, TargetChangeId)
      VALUES (_party_id,
              _name,
              _description,
              ((SELECT data FROM source_change) ->> 'change_id')::integer,
              ((SELECT data FROM target_change) ->> 'change_id')::integer)
      RETURNING Id, Name, Description)
SELECT ex.Id,
       ex.Name,
       ex.Description,
       (SELECT data FROM source_change),
       (SELECT data FROM target_change)
FROM exchange ex
$$;
