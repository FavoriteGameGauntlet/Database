CREATE OR REPLACE FUNCTION create_user_game(
  _user_id INTEGER,
  _party_id INTEGER,
  _game_id INTEGER,
  _actor_user_id INTEGER,
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
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _actor_user_id, _party_id, 'game', 'added', _source_event_id)
      RETURNING Id, AffectedUserId, PartyId, CreatedDate),

  game_history AS (
    INSERT INTO users.GameHistory (Id, PartyId, GameId, TimeSpent)
      SELECT he.Id, he.PartyId, _game_id, INTERVAL '0'
      FROM history_event he),

  game AS (
    INSERT INTO users.Games (UserId, PartyId, GameId)
      SELECT he.AffectedUserId, he.PartyId, _game_id
      FROM history_event he
      RETURNING Id, UserId, PartyId, GameId, TimeSpent, StartDate)

SELECT g.Id, g.UserId, g.PartyId, g.GameId, g.TimeSpent, g.StartDate
FROM game g
$$;
