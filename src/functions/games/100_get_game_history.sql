CREATE OR REPLACE FUNCTION get_game_history(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS TABLE (
    id              INTEGER,
    game_id         INTEGER,
    name            TEXT,
    action          TEXT,
    time_spent      INTERVAL,
    rating          INTEGER,
    review_comment  TEXT,
    end_state       TEXT,
    source_event_id INTEGER,
    created_date    TIMESTAMP
  )
  LANGUAGE sql
AS
$$
SELECT gh.Id,
       gh.GameId,
       g.Name,
       he.Action,
       gh.TimeSpent,
       gh.Rating,
       gh.ReviewComment,
       gh.EndState,
       he.SourceEventId,
       he.CreatedDate
FROM users.GameHistory gh
       INNER JOIN users.HistoryEvents he ON he.Id = gh.Id AND he.PartyId = gh.PartyId
       INNER JOIN party.Games g ON g.Id = gh.GameId AND g.PartyId = gh.PartyId
WHERE he.AffectedUserId = _user_id
  AND gh.PartyId = _party_id
ORDER BY he.CreatedDate DESC
$$;
