CREATE OR REPLACE FUNCTION finish_user_game(
  _user_id INTEGER,
  _party_id INTEGER,
  _game_id INTEGER,
  _actor_user_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
WITH
  deleted_game AS (
    DELETE FROM users.Games
      WHERE UserId = _user_id
        AND PartyId = _party_id
        AND GameId = _game_id
      RETURNING UserId, PartyId, TimeSpent),

  history_event AS (
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action, SourceEventId)
      SELECT UserId, _actor_user_id, PartyId, 'game', 'removed', _source_event_id
      FROM deleted_game
      RETURNING Id, PartyId),

  game_history AS (
    INSERT INTO users.GameHistory (Id, PartyId, GameId, TimeSpent, EndState)
      SELECT he.Id, he.PartyId, _game_id, dg.TimeSpent, 'finished'
      FROM history_event he,
           deleted_game dg)

SELECT 1
$$;
