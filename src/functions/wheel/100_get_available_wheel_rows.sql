CREATE OR REPLACE FUNCTION get_available_wheel_rows(
  _user_id INTEGER,
  _party_id INTEGER,
  _collection_id INTEGER
)
  RETURNS TABLE (
    id               INTEGER,
    party_id         INTEGER,
    name             TEXT,
    description      TEXT,
    change_id        INTEGER,
    collection_id    INTEGER,
    is_manual_change BOOLEAN
  )
  LANGUAGE sql
AS
$$
SELECT wr.Id, wr.PartyId, wr.Name, wr.Description, wr.ChangeId, wr.CollectionId, c.IsManualChange
FROM party.WheelRows wr
       INNER JOIN party.Changes c ON c.PartyId = wr.PartyId AND c.Id = wr.ChangeId
WHERE wr.PartyId = _party_id
  AND wr.CollectionId = _collection_id
  AND (
  NOT (SELECT ShouldCheckHistory
       FROM party.WheelCollections
       WHERE Id = _collection_id
         AND PartyId = _party_id)
    OR (
    NOT EXISTS (SELECT 1
                FROM users.LastWheelRows lwr
                WHERE lwr.WheelRowId = wr.Id
                  AND lwr.UserId = _user_id
                  AND lwr.PartyId = _party_id)
      AND NOT EXISTS (SELECT 1
                      FROM users.WheelRowHistory wrh
                             INNER JOIN users.HistoryEvents he
                                        ON he.Id = wrh.Id AND he.PartyId = wrh.PartyId
                      WHERE wrh.WheelRowId = wr.Id
                        AND he.AffectedUserId = _user_id
                        AND wrh.PartyId = _party_id)
    )
  )
$$;
