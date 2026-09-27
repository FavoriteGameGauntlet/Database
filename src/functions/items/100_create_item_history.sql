CREATE OR REPLACE FUNCTION create_item_history(
  _user_id INTEGER,
  _party_id INTEGER,
  _item_id INTEGER,
  _uses_left INTEGER,
  _source_event_id INTEGER
)
  RETURNS TABLE (
    id               INTEGER,
    affected_user_id INTEGER,
    party_id         INTEGER,
    item_id          INTEGER,
    uses_left        INTEGER,
    used_date        TIMESTAMP
  )
  LANGUAGE sql
AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (AffectedUserId, ActorUserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _user_id, _party_id, 'item', 'changed', _source_event_id)
      RETURNING Id, AffectedUserId, PartyId, CreatedDate),

  item_history AS (
    INSERT INTO users.ItemHistory (Id, PartyId, ItemId, UsesLeft)
      SELECT he.Id, he.PartyId, _item_id, _uses_left
      FROM history_event he)

SELECT Id, AffectedUserId, PartyId, _item_id, _uses_left, CreatedDate
FROM history_event
$$;
