CREATE OR REPLACE FUNCTION create_item_history(
  _user_id INTEGER,
  _party_id INTEGER,
  _item_id INTEGER,
  _user_effect_id INTEGER,
  _source_event_id INTEGER
)
  RETURNS TABLE (
    id             INTEGER,
    user_id        INTEGER,
    party_id       INTEGER,
    item_id        INTEGER,
    user_effect_id INTEGER,
    used_date      TIMESTAMP
  )
  LANGUAGE sql
AS
$$
WITH
  history_event AS (
    INSERT INTO users.HistoryEvents (UserId, PartyId, Type, Action, SourceEventId)
      VALUES (_user_id, _party_id, 'item', 'changed', _source_event_id)
      RETURNING Id, UserId, PartyId, CreatedDate),

  item_history AS (
    INSERT INTO users.ItemHistory (Id, PartyId, ItemId, UserEffectId)
      SELECT he.Id, he.PartyId, _item_id, _user_effect_id
      FROM history_event he)

SELECT Id, UserId, PartyId, _item_id, _user_effect_id, CreatedDate
FROM history_event
$$;
