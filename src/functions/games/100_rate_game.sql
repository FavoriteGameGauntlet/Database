CREATE OR REPLACE FUNCTION rate_game(
  _user_id INTEGER,
  _party_id INTEGER,
  _game_id INTEGER,
  _rating INTEGER,
  _review_comment TEXT,
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
    INSERT INTO users.GameHistory (Id, PartyId, GameId, Rating, ReviewComment)
      SELECT he.Id, he.PartyId, _game_id, _rating, _review_comment
      FROM history_event he)

UPDATE users.Games
SET Rating        = _rating,
    ReviewComment = _review_comment
WHERE UserId = _user_id
  AND PartyId = _party_id
  AND GameId = _game_id
$$;
