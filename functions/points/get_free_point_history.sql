CREATE OR REPLACE FUNCTION get_free_point_history(p_user_id INTEGER)
RETURNS TABLE(actualchangevalue INTEGER, changedate TIMESTAMP, changesource TEXT, changevalue INTEGER, finalvalue INTEGER, login TEXT, wheeleffectname TEXT)
LANGUAGE sql AS $$
    SELECT fph.ActualChangeValue, fph.ChangeDate, fph.ChangeSource, fph.ChangeValue, fph.FinalValue, u.Login, we.Name
    FROM FreePointHistory fph
        LEFT JOIN Users u ON u.Id = fph.SourceUserId
        LEFT JOIN WheelEffects we ON we.Id = fph.WheelEffectId
    WHERE fph.UserId = p_user_id
    ORDER BY fph.ChangeDate DESC
$$;
