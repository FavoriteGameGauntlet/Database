CREATE OR REPLACE FUNCTION does_user_game_exist(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS BOOLEAN
  LANGUAGE sql AS
$$
SELECT EXISTS (SELECT 1
               FROM users.Games
               WHERE UserId = _user_id
                 AND PartyId = _party_id
                 AND State = 'current')
$$;
