CREATE OR REPLACE FUNCTION check_item_history_created(
)
  RETURNS TRIGGER
  LANGUAGE plpgsql AS
$$
DECLARE
  _action users.HistoryActionType;
BEGIN
  SELECT Action
  INTO _action
  FROM users.HistoryEvents
  WHERE Id = NEW.Id
    AND PartyId = NEW.PartyId;

  IF _action = 'added' AND EXISTS
    (SELECT 1
     FROM users.ItemHistory
     WHERE UserItemId = NEW.UserItemId
       AND PartyId = NEW.PartyId)
  THEN
    RAISE EXCEPTION 'UserItemId % already has history in PartyId %', NEW.UserItemId, NEW.PartyId;
  END IF;

  RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER check_item_history_created
  BEFORE INSERT
  ON users.ItemHistory
  FOR EACH ROW
EXECUTE FUNCTION check_item_history_created();
