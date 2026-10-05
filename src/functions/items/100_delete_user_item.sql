CREATE OR REPLACE FUNCTION delete_user_item(
  _user_id INTEGER,
  _party_id INTEGER,
  _item_id INTEGER,
  _actor_user_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS void
  LANGUAGE sql AS
$$
WITH
  deleted_item AS (
    DELETE FROM users.Items
      WHERE UserId = _user_id
        AND PartyId = _party_id
        AND ItemId = _item_id
      RETURNING ItemId),

  history_event AS (
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action, SourceEventId)
      SELECT _user_id, _actor_user_id, _party_id, 'item', 'removed', _source_event_id
      FROM deleted_item
      RETURNING Id, PartyId),

  item_history AS (
    INSERT INTO users.ItemHistory (Id, PartyId, ItemId)
      SELECT he.Id, he.PartyId, _item_id
      FROM history_event he)

SELECT 1
$$;
