CREATE OR REPLACE FUNCTION change_to_jsonb(
  _change_id INTEGER,
  _should_apply_to_all BOOLEAN,
  _is_manual_change BOOLEAN,
  _entries JSONB
)
  RETURNS JSONB
  LANGUAGE sql
AS
$$
SELECT jsonb_build_object(
         'change_id', _change_id,
         'should_apply_to_all', _should_apply_to_all,
         'is_manual_change', _is_manual_change,
         'entries', _entries
       )
$$;
