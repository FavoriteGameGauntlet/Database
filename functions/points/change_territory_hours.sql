CREATE OR REPLACE FUNCTION change_territory_hours(p_user_id INTEGER, p_change_value INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET TerritoryHours = TerritoryHours + p_change_value WHERE UserId = p_user_id
$$;
