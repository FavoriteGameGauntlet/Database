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
    time_spent   INTERVAL,
    started_date TIMESTAMP
  )
  LANGUAGE sql
AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (UserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _party_id, 'game', 'added', _source_event_id)
      RETURNING Id, UserId, PartyId, CreatedDate),

  game_history AS (
    INSERT INTO users.GameHistory (Id, PartyId, GameId, TimeSpent)
      SELECT he.Id, he.PartyId, _game_id, INTERVAL '0'
      FROM history_event he),

  game AS (
    INSERT INTO users.Games (UserId, PartyId, GameId)
      SELECT he.UserId, he.PartyId, _game_id
      FROM history_event he
      RETURNING Id, UserId, PartyId, GameId, TimeSpent)

SELECT g.Id, g.UserId, g.PartyId, g.GameId, g.TimeSpent, he.CreatedDate
FROM game g,
     history_event he
$$;
