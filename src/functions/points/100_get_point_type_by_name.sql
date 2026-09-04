CREATE OR REPLACE FUNCTION get_point_type_by_name(
  _party_id INTEGER,
  _name TEXT
)
  RETURNS TABLE (
    id          INTEGER,
    party_id    INTEGER,
    name        TEXT,
    description TEXT,
    start_value INTEGER,
    is_public   BOOLEAN,
    is_shared   BOOLEAN,
    minimum     INTEGER,
    maximum     INTEGER
  )
  LANGUAGE sql
AS
$$
SELECT Id,
       PartyId,
       Name,
       Description,
       StartValue,
       IsPublic,
       IsShared,
       Minimum,
       Maximum
FROM party.PointTypes
WHERE PartyId = _party_id
  AND Name = _name
  AND NOT IsRemoved
$$;
