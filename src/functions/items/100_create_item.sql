CREATE OR REPLACE FUNCTION create_item(
  _party_id INTEGER,
  _name TEXT,
  _description TEXT,
  _use_count INTEGER,
  _change JSONB
)
  RETURNS TABLE (
    item_id     INTEGER,
    party_id    INTEGER,
    name        TEXT,
    description TEXT,
    use_count   INTEGER,
    change      JSONB
  )
  LANGUAGE sql
AS
$$
WITH
  change AS (SELECT create_change_from_jsonb(_party_id, _change) AS data),

  item AS (
    INSERT INTO party.Items (PartyId, Name, Description, UseCount, ChangeId)
      VALUES (_party_id, _name, _description, _use_count,
              ((SELECT data FROM change) ->> 'change_id')::integer)
      RETURNING Id, PartyId, Name, Description, UseCount)

SELECT it.Id,
       it.PartyId,
       it.Name,
       it.Description,
       it.UseCount,
       (SELECT data FROM change)
FROM item it
$$;
