CREATE OR REPLACE FUNCTION delete_user_item(
  _user_id INTEGER,
  _party_id INTEGER,
  _user_item_id INTEGER,
  _actor_user_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
WITH
  deleted_item AS (
    DELETE FROM users.Items
      WHERE Id = _user_item_id
        AND UserId = _user_id
        AND PartyId = _party_id
      RETURNING Id, ItemId),

  history_event AS (
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action, SourceEventId)
      SELECT _user_id, _actor_user_id, _party_id, 'item', 'removed', _source_event_id
      FROM deleted_item
      RETURNING Id, PartyId),

  item_history AS (
    INSERT INTO users.ItemHistory (Id, PartyId, ItemId, UserItemId)
      SELECT he.Id, he.PartyId, di.ItemId, di.Id
      FROM history_event he
             CROSS JOIN deleted_item di)

SELECT 1
$$;
