DO
$$
  BEGIN
    CREATE TYPE users.GameEndState AS ENUM ('finished', 'cancelled');
  EXCEPTION
    WHEN duplicate_object THEN NULL;
  END
$$;
