CREATE OR REPLACE FUNCTION create_user_item(
  _user_id INTEGER,
  _party_id INTEGER,
  _item_id INTEGER,
  _actor_user_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS TABLE (
    id            INTEGER,
    user_id       INTEGER,
    party_id      INTEGER,
    item_id       INTEGER,
    uses_left     INTEGER,
    received_date TIMESTAMP
  )
  LANGUAGE sql
AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _actor_user_id, _party_id, 'item', 'added', _source_event_id)
      RETURNING Id, AffectedUserId, PartyId),

  item_history AS (
    INSERT INTO users.ItemHistory (Id, PartyId, ItemId, UsesLeft)
      SELECT he.Id, he.PartyId, _item_id, i.UseCount
      FROM history_event he
             INNER JOIN party.Items i ON i.Id = _item_id AND i.PartyId = he.PartyId)

INSERT
INTO users.Items (UserId, PartyId, ItemId, UsesLeft)
SELECT he.AffectedUserId, he.PartyId, _item_id, i.UseCount
FROM history_event he
       INNER JOIN party.Items i ON i.Id = _item_id AND i.PartyId = he.PartyId
RETURNING Id, UserId, PartyId, ItemId, UsesLeft, ReceivedDate
$$;
