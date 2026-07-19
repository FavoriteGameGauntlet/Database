CREATE OR REPLACE FUNCTION create_user_perk(
  _user_id INTEGER,
  _party_id INTEGER,
  _perk_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS TABLE (
    id             INTEGER,
    user_id        INTEGER,
    party_id       INTEGER,
    perk_id        INTEGER,
    user_effect_id INTEGER,
    received_date  TIMESTAMP
  )
  LANGUAGE sql
AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (UserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _party_id, 'perk', 'added', _source_event_id)
      RETURNING Id, UserId, PartyId),

  perk_history AS (
    INSERT INTO users.PerkHistory (Id, PartyId, PerkId)
      SELECT he.Id, he.PartyId, _perk_id
      FROM history_event he),

  user_perk AS (
    INSERT INTO users.Perks (UserId, PartyId, PerkId, UserEffectId)
      SELECT he.UserId, he.PartyId, _perk_id, _source_event_id
      FROM history_event he
      RETURNING Id, UserId, PartyId, PerkId, UserEffectId, ReceivedDate)

SELECT Id, UserId, PartyId, PerkId, UserEffectId, ReceivedDate
FROM user_perk
$$;
