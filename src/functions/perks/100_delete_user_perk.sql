CREATE OR REPLACE FUNCTION delete_user_perk(
  _user_id INTEGER,
  _party_id INTEGER,
  _perk_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (UserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _party_id, 'perk', 'removed', _source_event_id)
      RETURNING Id, PartyId),

  perk_history AS (
    INSERT INTO users.PerkHistory (Id, PartyId, PerkId)
      SELECT he.Id, he.PartyId, _perk_id
      FROM history_event he)

DELETE
FROM users.Perks
WHERE UserId = _user_id
  AND PartyId = _party_id
  AND PerkId = _perk_id
$$;
