CREATE OR REPLACE FUNCTION get_effect(
  _party_id INTEGER,
  _effect_id INTEGER
)
  RETURNS TABLE (
    id          INTEGER,
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
SELECT ef.Id,
       ef.PartyId,
       ef.Name,
       ef.Description,
       ef.UseCount,
       ef.Duration,
       change_to_jsonb(
         c.Id,
         c.ShouldApplyToAll,
         c.IsManualChange,
         get_change_entries_jsonb(ef.PartyId, ef.ChangeId)
       )
FROM party.Effects ef
       INNER JOIN party.Changes c ON c.PartyId = ef.PartyId AND c.Id = ef.ChangeId
WHERE ef.Id = _effect_id
  AND ef.PartyId = _party_id
$$;
