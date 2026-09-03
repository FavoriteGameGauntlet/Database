CREATE OR REPLACE FUNCTION rate_game(
  _user_id INTEGER,
  _party_id INTEGER,
  _game_id INTEGER,
  _rating INTEGER,
  _review_comment TEXT
)
  RETURNS TABLE (
    id             INTEGER,
    user_id        INTEGER,
    party_id       INTEGER,
    game_id        INTEGER,
    rating         INTEGER,
    review_comment TEXT,
    created_date   TIMESTAMP,
    updated_date   TIMESTAMP
  )
  LANGUAGE sql
AS
$$
INSERT INTO users.GameRatings (UserId, PartyId, GameId, Rating, ReviewComment)
SELECT _user_id, _party_id, _game_id, _rating, _review_comment
WHERE EXISTS (SELECT 1
              FROM users.GameHistory gh
                     INNER JOIN users.HistoryEvents he ON he.Id = gh.Id AND he.PartyId = gh.PartyId
              WHERE he.AffectedUserId = _user_id
                AND gh.PartyId = _party_id
                AND gh.GameId = _game_id
                AND gh.EndState IS NOT NULL)
ON CONFLICT (UserId, PartyId, GameId)
  DO UPDATE SET Rating        = EXCLUDED.Rating,
                ReviewComment = EXCLUDED.ReviewComment,
                UpdatedDate   = NOW()
RETURNING Id, UserId, PartyId, GameId, Rating, ReviewComment, CreatedDate, UpdatedDate
$$;
