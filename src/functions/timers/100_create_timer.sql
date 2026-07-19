CREATE OR REPLACE FUNCTION create_timer(
  _user_id INTEGER,
  _party_id INTEGER,
  _game_id INTEGER,
  _duration INTERVAL
)
  RETURNS TABLE (
    id           INTEGER,
    user_id      INTEGER,
    party_id     INTEGER,
    game_id      INTEGER,
    state        TEXT,
    duration     INTERVAL,
    created_date TIMESTAMP
  )
  LANGUAGE sql
AS
$$
INSERT INTO users.Timers (UserId, PartyId, GameId, Duration)
VALUES (_user_id, _party_id, _game_id, _duration)
RETURNING Id, UserId, PartyId, GameId, State, Duration, CreatedDate
$$;
