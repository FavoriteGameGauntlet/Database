CREATE OR REPLACE FUNCTION change_game_time_spent(
  _user_id INTEGER,
  _party_id INTEGER,
  _game_id INTEGER,
  _change_value INTERVAL,
  _source_event_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (UserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _party_id, 'game', 'changed', _source_event_id)
      RETURNING Id, PartyId),

  game_history AS (
    INSERT INTO users.GameHistory (Id, PartyId, GameId, TimeSpentDelta)
      SELECT he.Id, he.PartyId, _game_id, _change_value
      FROM history_event he)

UPDATE users.Games
SET TimeSpent = TimeSpent + _change_value
WHERE UserId = _user_id
  AND PartyId = _party_id
  AND GameId = _game_id
$$;
