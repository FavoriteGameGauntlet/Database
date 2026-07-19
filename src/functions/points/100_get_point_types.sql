CREATE OR REPLACE FUNCTION get_point_types(
  _party_id INTEGER
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
  AND NOT IsRemoved
$$;
