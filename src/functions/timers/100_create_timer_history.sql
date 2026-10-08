CREATE OR REPLACE FUNCTION create_timer_history(
  _user_id INTEGER,
  _party_id INTEGER,
  _timer_reward_id INTEGER,
  _actor_user_id INTEGER
)
  RETURNS TABLE (
    id               INTEGER,
    affected_user_id INTEGER,
    party_id         INTEGER,
    timer_reward_id  INTEGER,
    completed_date   TIMESTAMP
  )
  LANGUAGE sql
AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action)
      VALUES (_user_id, _actor_user_id, _party_id, 'timer', 'added')
      RETURNING Id, AffectedUserId, PartyId, CreatedDate),

  timer_history AS (
    INSERT INTO users.TimerHistory (Id, PartyId, TimerRewardId)
      SELECT he.Id, he.PartyId, _timer_reward_id
      FROM history_event he)

SELECT Id, AffectedUserId, PartyId, _timer_reward_id, CreatedDate
FROM history_event
$$;
