CREATE OR REPLACE FUNCTION add_territory_point_history(
    _user_id INTEGER,
    _source_user_id INTEGER,
    _change_source TEXT,
    _change_value INTEGER,
    _actual_change_value INTEGER,
    _final_value INTEGER
)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO TerritoryPointHistory (UserId, SourceUserId, ChangeSource, ChangeValue, ActualChangeValue, FinalValue)
    VALUES (_user_id, _source_user_id, _change_source, _change_value, _actual_change_value, _final_value)
$$;
