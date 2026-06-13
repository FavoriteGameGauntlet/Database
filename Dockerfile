FROM postgres:17-alpine
COPY tables/ /docker-entrypoint-initdb.d/
COPY functions/games/ /docker-entrypoint-initdb.d/
COPY functions/points/ /docker-entrypoint-initdb.d/
COPY functions/sysparams/ /docker-entrypoint-initdb.d/
COPY functions/timers/ /docker-entrypoint-initdb.d/
COPY functions/users/ /docker-entrypoint-initdb.d/
COPY functions/wheel/ /docker-entrypoint-initdb.d/
