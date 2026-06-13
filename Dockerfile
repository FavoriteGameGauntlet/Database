FROM postgres:17-alpine
COPY schemas/ /docker-entrypoint-initdb.d/
COPY functions/ /tmp/functions/
RUN find /tmp/functions -name '*.sql' | xargs cat > /docker-entrypoint-initdb.d/20_functions.sql
