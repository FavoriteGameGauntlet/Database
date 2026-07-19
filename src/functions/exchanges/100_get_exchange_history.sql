CREATE OR REPLACE FUNCTION get_exchange_history(
  _user_id INTEGER,
  _party_id INTEGER
)
  RETURNS TABLE (
    id          INTEGER,
    user_id     INTEGER,
    party_id    INTEGER,
    exchange_id INTEGER,
    name        TEXT,
    description TEXT,
    used_date   TIMESTAMP
  )
  LANGUAGE sql
AS
$$
SELECT eh.Id,
       he.UserId,
       eh.PartyId,
       eh.ExchangeId,
       e.Name,
       e.Description,
       he.CreatedDate
FROM users.ExchangeHistory eh
       INNER JOIN users.HistoryEvents he ON he.Id = eh.Id AND he.PartyId = eh.PartyId
       INNER JOIN party.Exchanges e ON e.PartyId = eh.PartyId AND e.Id = eh.ExchangeId
WHERE he.UserId = _user_id
  AND eh.PartyId = _party_id
ORDER BY he.CreatedDate DESC
$$;
