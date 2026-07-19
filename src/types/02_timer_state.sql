DO
$$
  BEGIN
    CREATE TYPE users.TimerState AS ENUM ('created', 'running', 'paused');
  EXCEPTION
    WHEN duplicate_object THEN NULL;
  END
$$;
