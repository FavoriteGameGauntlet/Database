CREATE OR REPLACE FUNCTION create_exchange_history(
  _user_id INTEGER,
  _party_id INTEGER,
  _exchange_id INTEGER,
  _actor_user_id INTEGER,
  _source_event_id INTEGER DEFAULT NULL
)
  RETURNS TABLE (
    id               INTEGER,
    affected_user_id INTEGER,
    party_id         INTEGER,
    exchange_id      INTEGER,
    used_date        TIMESTAMP
  )
  LANGUAGE sql
AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _actor_user_id, _party_id, 'exchange', 'added', _source_event_id)
      RETURNING Id, AffectedUserId, PartyId, CreatedDate),

  exchange_history AS (
    INSERT INTO users.ExchangeHistory (Id, PartyId, ExchangeId)
      SELECT he.Id, he.PartyId, _exchange_id
      FROM history_event he)

SELECT Id, AffectedUserId, PartyId, _exchange_id, CreatedDate
FROM history_event
$$;
