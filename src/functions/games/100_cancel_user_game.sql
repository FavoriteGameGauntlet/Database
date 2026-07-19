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
    DELETE FROM users.Games
      WHERE UserId = _user_id
        AND PartyId = _party_id
        AND GameId = _game_id
      RETURNING UserId, PartyId, TimeSpent),

  history_event AS (
    INSERT INTO users.HistoryEvents (UserId, PartyId, Type, Action, SourceEventId)
      SELECT UserId, PartyId, 'game', 'removed', _source_event_id
      FROM cancelled_game
      RETURNING Id, PartyId),

  game_history AS (
    INSERT INTO users.GameHistory (Id, PartyId, GameId, TimeSpent, EndState)
      SELECT he.Id, he.PartyId, _game_id, cg.TimeSpent, 'cancelled'
      FROM history_event he,
           cancelled_game cg)

SELECT 1
$$;
