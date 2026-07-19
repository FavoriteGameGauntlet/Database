DO
$$
  BEGIN
    CREATE TYPE users.HistoryActionType AS ENUM ('added', 'changed', 'removed');
  EXCEPTION
    WHEN duplicate_object THEN NULL;
  END
$$;
