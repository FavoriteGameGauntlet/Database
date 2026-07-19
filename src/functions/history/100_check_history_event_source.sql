CREATE OR REPLACE FUNCTION check_history_event_source(
)
  RETURNS TRIGGER
  LANGUAGE plpgsql AS
$$
DECLARE
  _source_type users.HistoryEventType;
BEGIN
  IF NEW.SourceEventId IS NOT NULL THEN
    SELECT Type
    INTO _source_type
    FROM users.HistoryEvents
    WHERE Id = NEW.SourceEventId
      AND PartyId = NEW.PartyId;

    IF _source_type IS NULL THEN
      RAISE EXCEPTION 'SourceEventId % not found in PartyId %', NEW.SourceEventId, NEW.PartyId;
    END IF;

    IF _source_type NOT IN ('manual', 'wheel_row', 'exchange', 'effect', 'item', 'perk') THEN
      RAISE EXCEPTION 'HistoryEvents % (Type=%) cannot be used as a source', NEW.SourceEventId, _source_type;
    END IF;
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS check_history_event_source ON users.HistoryEvents;
CREATE TRIGGER check_history_event_source
  BEFORE INSERT
  ON users.HistoryEvents
  FOR EACH ROW
EXECUTE FUNCTION check_history_event_source();

CREATE OR REPLACE FUNCTION check_party_point_history_source(
)
  RETURNS TRIGGER
  LANGUAGE plpgsql AS
$$
DECLARE
  _source_type users.HistoryEventType;
BEGIN
  SELECT Type
  INTO _source_type
  FROM users.HistoryEvents
  WHERE Id = NEW.SourceEventId
    AND PartyId = NEW.PartyId;

  IF _source_type IS NULL THEN
    RAISE EXCEPTION 'SourceEventId % not found in PartyId %', NEW.SourceEventId, NEW.PartyId;
  END IF;

  IF _source_type NOT IN ('manual', 'wheel_row', 'exchange', 'effect', 'item', 'perk') THEN
    RAISE EXCEPTION 'HistoryEvents % (Type=%) cannot be used as a source', NEW.SourceEventId, _source_type;
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS check_party_point_history_source ON party.PointHistory;
CREATE TRIGGER check_party_point_history_source
  BEFORE INSERT
  ON party.PointHistory
  FOR EACH ROW
EXECUTE FUNCTION check_party_point_history_source();
