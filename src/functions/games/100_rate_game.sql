CREATE OR REPLACE FUNCTION rate_game(
  _user_id INTEGER,
  _party_id INTEGER,
  _game_id INTEGER,
  _rating INTEGER,
  _review_comment TEXT,
  _actor_user_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _actor_user_id, _party_id, 'game', 'changed', _source_event_id)
      RETURNING Id, PartyId),

  last_time_spent AS (
    SELECT gh.TimeSpent
    FROM users.GameHistory gh
           INNER JOIN users.HistoryEvents he ON he.Id = gh.Id AND he.PartyId = gh.PartyId
    WHERE he.AffectedUserId = _user_id
      AND he.PartyId = _party_id
      AND gh.GameId = _game_id
    ORDER BY he.CreatedDate DESC
    LIMIT 1)

INSERT INTO users.GameHistory (Id, PartyId, GameId, TimeSpent, Rating, ReviewComment)
SELECT he.Id, he.PartyId, _game_id, COALESCE(lts.TimeSpent, INTERVAL '0'), _rating, _review_comment
FROM history_event he
       LEFT JOIN last_time_spent lts ON TRUE
$$;
