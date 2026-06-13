CREATE OR REPLACE FUNCTION get_territory_point_history(p_user_id INTEGER)
RETURNS TABLE(actualchangevalue INTEGER, changedate TIMESTAMP, changesource TEXT, changevalue INTEGER, finalvalue INTEGER, login TEXT)
LANGUAGE sql AS $$
    SELECT tph.ActualChangeValue, tph.ChangeDate, tph.ChangeSource, tph.ChangeValue, tph.FinalValue, u.Login
    FROM TerritoryPointHistory tph
        LEFT JOIN Users u ON u.Id = tph.SourceUserId
    WHERE tph.UserId = p_user_id
    ORDER BY tph.ChangeDate DESC
$$;
