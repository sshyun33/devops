FROM mariadb:10.1.20

RUN rm -f /etc/mysql/conf.d/*

ADD config/* /etc/mysql/conf.d/
ADD sql/* /docker-entrypoint-initdb.d/
