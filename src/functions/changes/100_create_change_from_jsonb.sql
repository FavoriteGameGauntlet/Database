CREATE OR REPLACE FUNCTION create_change_from_jsonb(
  _party_id INTEGER,
  _change JSONB
)
  RETURNS JSONB
  LANGUAGE sql
AS
$$
WITH
  change AS (
    INSERT INTO party.Changes (PartyId, ShouldApplyToAll, IsManualChange)
      VALUES (_party_id,
              (_change ->> 'should_apply_to_all')::boolean,
              COALESCE((_change ->> 'is_manual_change')::boolean, FALSE))
      RETURNING Id, ShouldApplyToAll, IsManualChange),

  change_entries AS (
    INSERT INTO party.ChangeEntries (PartyId, ChangeId, Amount, PointTypeId, ItemId, PerkId, EffectId)
      SELECT _party_id,
             (SELECT Id FROM change),
             (entry ->> 'amount')::integer,
             (entry ->> 'point_type_id')::integer,
             (entry ->> 'item_id')::integer,
             (entry ->> 'perk_id')::integer,
             (entry ->> 'effect_id')::integer
      FROM jsonb_array_elements(COALESCE(_change -> 'entries', '[]'::jsonb)) AS entry
      RETURNING Id, Amount, PointTypeId, ItemId, PerkId, EffectId)

SELECT change_to_jsonb(
         c.Id,
         c.ShouldApplyToAll,
         c.IsManualChange,
         (SELECT jsonb_agg(change_entry_to_jsonb(ie.Id, ie.Amount, ie.PointTypeId, ie.ItemId, ie.PerkId, ie.EffectId))
          FROM change_entries ie)
       )
FROM change c
$$;
