CREATE OR REPLACE FUNCTION get_game_review(
  _user_id INTEGER,
  _party_id INTEGER,
  _game_id INTEGER
)
  RETURNS TABLE (
    review_comment TEXT
  )
  LANGUAGE sql
AS
$$
SELECT gh.ReviewComment
FROM users.GameHistory gh
       INNER JOIN users.HistoryEvents he ON he.Id = gh.Id AND he.PartyId = gh.PartyId
WHERE he.UserId = _user_id
  AND gh.PartyId = _party_id
  AND gh.GameId = _game_id
  AND gh.ReviewComment IS NOT NULL
ORDER BY he.CreatedDate DESC
LIMIT 1
$$;
