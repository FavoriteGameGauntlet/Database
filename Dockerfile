FROM postgres:17-alpine
COPY schemas/ /docker-entrypoint-initdb.d/
COPY functions/ /docker-entrypoint-initdb.d/
