CREATE OR REPLACE FUNCTION cancel_user_game(
  _user_id INTEGER,
  _party_id INTEGER,
  _game_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
WITH
  cancelled_game AS (
    UPDATE users.Games
      SET State = 'cancelled',
        FinishedDate = NOW()
      WHERE UserId = _user_id
        AND PartyId = _party_id
        AND GameId = _game_id
        AND State = 'current'
      RETURNING UserId, PartyId),

  history_event AS (
    INSERT INTO users.HistoryEvents (UserId, PartyId, Type, Action, SourceEventId)
      SELECT UserId, PartyId, 'game', 'removed', _source_event_id
      FROM cancelled_game
      RETURNING Id, PartyId),

  game_history AS (
    INSERT INTO users.GameHistory (Id, PartyId, GameId, EndState)
      SELECT he.Id, he.PartyId, _game_id, 'cancelled'
      FROM history_event he)

SELECT 1
$$;
