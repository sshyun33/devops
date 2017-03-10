FROM mariadb:10.1.20

MAINTAINER sshyun33@gmail.com

ADD employees_db/employees.sql /docker-entrypoint-initdb.d/
ADD employees_db/*.dump /
