CREATE OR REPLACE FUNCTION change_entry_to_jsonb(
  _entry_id INTEGER,
  _amount INTEGER,
  _point_type_id INTEGER,
  _item_id INTEGER,
  _perk_id INTEGER,
  _effect_id INTEGER,
  _user_id INTEGER DEFAULT NULL
)
  RETURNS JSONB
  LANGUAGE sql
AS
$$
SELECT jsonb_build_object(
         'entry_id', _entry_id,
         'amount', _amount,
         'point_type_id', _point_type_id,
         'item_id', _item_id,
         'perk_id', _perk_id,
         'effect_id', _effect_id,
         'user_id', _user_id
       )
$$;
