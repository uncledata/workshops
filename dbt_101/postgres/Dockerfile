FROM postgres:13-alpine
ENV POSTGRES_PASSWORD=nopswd
ENV POSTGRES_DB db
COPY init.sql /docker-entrypoint-initdb.d/