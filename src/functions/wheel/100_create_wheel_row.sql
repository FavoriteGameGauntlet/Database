CREATE OR REPLACE FUNCTION create_wheel_row(
  _party_id INTEGER,
  _name TEXT,
  _description TEXT,
  _change_id INTEGER,
  _group_id INTEGER
)
  RETURNS TABLE (
    id          INTEGER,
    party_id    INTEGER,
    name        TEXT,
    description TEXT,
    change_id   INTEGER,
    group_id    INTEGER
  )
  LANGUAGE sql
AS
$$
INSERT INTO party.WheelRows (PartyId, Name, Description, ChangeId, GroupId)
VALUES (_party_id, _name, _description, _change_id, _group_id)
RETURNING Id, PartyId, Name, Description, ChangeId, GroupId
$$;
