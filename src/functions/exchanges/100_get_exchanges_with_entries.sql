CREATE OR REPLACE FUNCTION get_exchanges_with_entries(
  _party_id INTEGER,
  _exchange_id INTEGER
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
SELECT e.Id,
       e.Name,
       e.Description,
       change_to_jsonb(sc.Id,
                       sc.ShouldApplyToAll,
                       sc.ShouldChangePoints,
                       get_change_entries_jsonb(e.PartyId, e.SourceChangeId)),
       change_to_jsonb(tc.Id,
                       tc.ShouldApplyToAll,
                       tc.ShouldChangePoints,
                       get_change_entries_jsonb(e.PartyId, e.TargetChangeId))
FROM party.Exchanges e
       INNER JOIN party.Changes sc ON sc.PartyId = e.PartyId AND sc.Id = e.SourceChangeId
       INNER JOIN party.Changes tc ON tc.PartyId = e.PartyId AND tc.Id = e.TargetChangeId
WHERE e.PartyId = _party_id
  AND e.Id = _exchange_id
  AND NOT e.IsRemoved
$$;
