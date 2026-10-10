CREATE OR REPLACE FUNCTION check_effect_history_created(
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
     FROM users.EffectHistory
     WHERE UserEffectId = NEW.UserEffectId
       AND PartyId = NEW.PartyId)
  THEN
    RAISE EXCEPTION 'UserEffectId % already has history in PartyId %', NEW.UserEffectId, NEW.PartyId;
  END IF;

  RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER check_effect_history_created
  BEFORE INSERT
  ON users.EffectHistory
  FOR EACH ROW
EXECUTE FUNCTION check_effect_history_created();
