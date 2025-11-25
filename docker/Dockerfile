FROM postgres:16-alpine

ENV LANG=en_US.utf8

# Optional: install pgtop/perf tools
RUN apk add --no-cache procps

# optionally add schema/bootstrap SQL inside
# Seed schema/index definitions
COPY init/ /docker-entrypoint-initdb.d/

# Helpful default configs
COPY postgres.conf /etc/postgresql/postgresql.conf

CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]


