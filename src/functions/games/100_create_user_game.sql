CREATE OR REPLACE FUNCTION create_user_game(
  _user_id INTEGER,
  _party_id INTEGER,
  _game_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS TABLE (
    id           INTEGER,
    user_id      INTEGER,
    party_id     INTEGER,
    game_id      INTEGER,
    state        TEXT,
    started_date TIMESTAMP
  )
  LANGUAGE sql
AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (UserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _party_id, 'game', 'added', _source_event_id)
      RETURNING Id, UserId, PartyId),

  game_history AS (
    INSERT INTO users.GameHistory (Id, PartyId, GameId)
      SELECT he.Id, he.PartyId, _game_id
      FROM history_event he),

  game AS (
    INSERT INTO users.Games (UserId, PartyId, GameId)
      SELECT he.UserId, he.PartyId, _game_id
      FROM history_event he
      RETURNING Id, UserId, PartyId, GameId, State, StartedDate)

SELECT Id, UserId, PartyId, GameId, State, StartedDate
FROM game
$$;
