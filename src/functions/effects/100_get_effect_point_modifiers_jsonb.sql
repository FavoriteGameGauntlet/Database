CREATE OR REPLACE FUNCTION get_effect_point_modifiers_jsonb(
  _party_id INTEGER,
  _effect_id INTEGER
)
  RETURNS JSONB
  LANGUAGE sql
AS
$$
SELECT COALESCE(
         jsonb_agg(
           jsonb_build_object(
             'id',
             epm.Id,
             'point_type_id',
             epm.PointTypeId,
             'amount',
             epm.Amount
           )
           ORDER BY epm.Id
         ),
         '[]'::jsonb
       )
FROM party.EffectPointModifiers epm
WHERE epm.PartyId = _party_id
  AND epm.EffectId = _effect_id
$$;
