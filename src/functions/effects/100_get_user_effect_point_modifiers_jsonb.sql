CREATE OR REPLACE FUNCTION get_user_effect_point_modifiers_jsonb(
  _party_id INTEGER,
  _user_effect_id INTEGER
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
         ),
         '[]'::jsonb
       )
FROM users.EffectPointModifiers epm
WHERE epm.PartyId = _party_id
  AND epm.UserEffectId = _user_effect_id
$$;
