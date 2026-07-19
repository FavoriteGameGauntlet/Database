CREATE OR REPLACE FUNCTION create_user_change_from_jsonb(
  _party_id INTEGER,
  _entries JSONB
)
  RETURNS JSONB
  LANGUAGE sql
AS
$$
WITH
  change AS (
    INSERT INTO users.Changes (PartyId)
      VALUES (_party_id)
      RETURNING Id),

  change_entries AS (
    INSERT INTO users.ChangeEntries (PartyId, ChangeId, UserId, Amount, PointTypeId, ItemId, PerkId, EffectId)
      SELECT _party_id,
             (SELECT Id FROM change),
             (entry ->> 'user_id')::integer,
             (entry ->> 'amount')::integer,
             (entry ->> 'point_type_id')::integer,
             (entry ->> 'item_id')::integer,
             (entry ->> 'perk_id')::integer,
             (entry ->> 'effect_id')::integer
      FROM jsonb_array_elements(COALESCE(_entries, '[]'::jsonb)) AS entry
      RETURNING Id, UserId, Amount, PointTypeId, ItemId, PerkId, EffectId)

SELECT jsonb_build_object(
         'change_id', (SELECT Id FROM change),
         'entries',
         (SELECT jsonb_agg(change_entry_to_jsonb(ie.Id, ie.Amount, ie.PointTypeId, ie.ItemId, ie.PerkId, ie.EffectId,
                                                 ie.UserId))
          FROM change_entries ie)
       )
$$;
