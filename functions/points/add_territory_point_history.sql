CREATE OR REPLACE FUNCTION add_territory_point_history(
    p_user_id INTEGER,
    p_source_user_id INTEGER,
    p_change_source TEXT,
    p_change_value INTEGER,
    p_actual_change_value INTEGER,
    p_final_value INTEGER
)
RETURNS void
LANGUAGE sql AS $$
    INSERT INTO TerritoryPointHistory (UserId, SourceUserId, ChangeSource, ChangeValue, ActualChangeValue, FinalValue)
    VALUES (p_user_id, p_source_user_id, p_change_source, p_change_value, p_actual_change_value, p_final_value)
$$;
