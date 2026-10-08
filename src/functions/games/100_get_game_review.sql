CREATE OR REPLACE FUNCTION get_game_review(
  _user_id INTEGER,
  _party_id INTEGER,
  _game_id INTEGER
)
  RETURNS TABLE (
    rating         INTEGER,
    review_comment TEXT
  )
  LANGUAGE sql
AS
$$
SELECT gr.Rating, gr.ReviewComment
FROM users.GameRatings gr
WHERE gr.UserId = _user_id
  AND gr.PartyId = _party_id
  AND gr.GameId = _game_id
$$;
