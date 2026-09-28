DO
$$
  BEGIN
    CREATE TYPE users.HistoryEventType AS ENUM
      ('exchange', 'wheel_row', 'effect', 'item', 'manual', 'point', 'perk', 'game', 'timer');
  EXCEPTION
    WHEN duplicate_object THEN NULL;
  END
$$;
