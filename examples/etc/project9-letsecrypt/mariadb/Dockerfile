FROM mariadb:10.1.20

RUN rm -f /etc/mysql/conf.d/*

COPY config/* /etc/mysql/conf.d/
COPY sql/* /docker-entrypoint-initdb.d/
