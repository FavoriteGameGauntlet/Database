CREATE OR REPLACE FUNCTION create_manual_history(
  _party_id INTEGER,
  _actor_user_id INTEGER,
  _entries JSONB,
  _source_event_id INTEGER DEFAULT NULL
)
  RETURNS TABLE
  (
    id            INTEGER,
    user_id       INTEGER,
    party_id      INTEGER,
    actor_user_id INTEGER,
    change_id     INTEGER,
    created_date  TIMESTAMP
  )
  LANGUAGE sql
AS
$$
WITH
  change AS (SELECT (create_user_change_from_jsonb(_party_id, _entries) ->> 'change_id')::integer AS change_id),

  affected_users AS (SELECT DISTINCT (entry ->> 'user_id')::integer AS user_id
                     FROM jsonb_array_elements(_entries) AS entry),

  history_event AS (
    INSERT INTO users.HistoryEvents (UserId, PartyId, Type, Action, SourceEventId)
      SELECT au.user_id, _party_id, 'manual', 'added', _source_event_id
      FROM affected_users au
      RETURNING Id, UserId, PartyId, CreatedDate),

  manual_history AS (
    INSERT INTO users.ManualHistory (Id, PartyId, UserId, ChangeId)
      SELECT he.Id, he.PartyId, _actor_user_id, c.change_id
      FROM history_event he,
           change c)

SELECT he.Id, he.UserId, he.PartyId, _actor_user_id, c.change_id, he.CreatedDate
FROM history_event he,
     change c
$$;
