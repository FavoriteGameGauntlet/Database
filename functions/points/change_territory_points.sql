CREATE OR REPLACE FUNCTION change_territory_points(_user_id INTEGER, _change_value INTEGER)
RETURNS void
LANGUAGE sql AS $$
    UPDATE UserStats SET TerritoryPoints = TerritoryPoints + _change_value WHERE UserId = _user_id
$$;
