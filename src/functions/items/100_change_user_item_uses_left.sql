CREATE OR REPLACE FUNCTION change_user_item_uses_left(
  _user_id INTEGER,
  _party_id INTEGER,
  _user_item_id INTEGER,
  _uses_left INTEGER,
  _actor_user_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS INTEGER
  LANGUAGE sql AS
$$
WITH
  target_item AS (
    SELECT Id, ItemId
    FROM users.Items
    WHERE Id = _user_item_id
      AND UserId = _user_id
      AND PartyId = _party_id),

  history_event AS (
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action, SourceEventId)
      SELECT _user_id, _actor_user_id, _party_id, 'item', 'changed', _source_event_id
      FROM target_item
      RETURNING Id, PartyId),

  item_history AS (
    INSERT INTO users.ItemHistory (Id, PartyId, ItemId, UserItemId, UsesLeft)
      SELECT he.Id, he.PartyId, ti.ItemId, ti.Id, _uses_left
      FROM history_event he
             CROSS JOIN target_item ti),

  updated_item AS (
    UPDATE users.Items
      SET UsesLeft = _uses_left
      WHERE Id = _user_item_id
        AND UserId = _user_id
        AND PartyId = _party_id
        AND _uses_left > 0)

SELECT Id
FROM history_event
$$;
