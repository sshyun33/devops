FROM mysql:5.5.54

RUN rm -f /etc/mysql/conf.d/*

COPY config/* /etc/mysql/conf.d/
COPY sql/* /docker-entrypoint-initdb.d/
