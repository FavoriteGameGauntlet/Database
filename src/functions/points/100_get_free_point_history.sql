CREATE OR REPLACE FUNCTION get_free_point_history(_user_id INTEGER)
RETURNS TABLE(actualchangevalue INTEGER, changedate TIMESTAMP, changesource TEXT, changevalue INTEGER, finalvalue INTEGER, login TEXT, wheeleffectname TEXT)
LANGUAGE sql AS $$
    SELECT fph.ActualChangeValue, fph.ChangeDate, fph.ChangeSource, fph.ChangeValue, fph.FinalValue, u.Login, weh.Name
    FROM FreePointHistory fph
        LEFT JOIN Users u ON u.Id = fph.SourceUserId
        LEFT JOIN wheeleffecthistory weh ON weh.Id = fph.WheelEffectHistoryId
        LEFT JOIN wheeleffects we ON we.Id = weh.WheelEffectId
    WHERE fph.UserId = _user_id
    ORDER BY fph.ChangeDate DESC
$$;
