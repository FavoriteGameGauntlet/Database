CREATE OR REPLACE FUNCTION create_wheel_row(
  _party_id INTEGER,
  _name TEXT,
  _description TEXT,
  _change_id INTEGER,
  _collection_id INTEGER
)
  RETURNS TABLE (
    id            INTEGER,
    party_id      INTEGER,
    name          TEXT,
    description   TEXT,
    change_id     INTEGER,
    collection_id INTEGER
  )
  LANGUAGE sql
AS
$$
INSERT INTO party.WheelRows (PartyId, Name, Description, ChangeId, CollectionId)
VALUES (_party_id, _name, _description, _change_id, _collection_id)
RETURNING Id, PartyId, Name, Description, ChangeId, CollectionId
$$;
