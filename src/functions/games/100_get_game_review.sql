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
SELECT ReviewComment
FROM users.Games
WHERE UserId = _user_id
  AND PartyId = _party_id
  AND GameId = _game_id
$$;
