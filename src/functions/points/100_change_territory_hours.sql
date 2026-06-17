CREATE OR REPLACE FUNCTION change_territory_hours(_user_id INTEGER, _change_value INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET TerritoryHours = TerritoryHours + _change_value WHERE UserId = _user_id
$$;
