CREATE OR REPLACE FUNCTION finish_user_game(
  _user_id INTEGER,
  _party_id INTEGER,
  _game_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (UserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _party_id, 'game', 'removed', _source_event_id)
      RETURNING Id, PartyId),

  game_history AS (
    INSERT INTO users.GameHistory (Id, PartyId, GameId, EndState)
      SELECT he.Id, he.PartyId, _game_id, 'finished'
      FROM history_event he)

UPDATE users.Games
SET State        = 'finished',
    FinishedDate = NOW()
WHERE UserId = _user_id
  AND PartyId = _party_id
  AND GameId = _game_id
$$;
