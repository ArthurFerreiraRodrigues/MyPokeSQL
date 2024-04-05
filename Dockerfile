FROM mysql:latest

COPY ./scripts /docker-entrypoint-initdb.d

WORKDIR /etc/mysql

ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD

ENV MYSQL_DATABASE=$MYSQL_DATABASE
ENV MYSQL_USER=$MYSQL_USER
ENV MYSQL_PASSWORD=$MYSQL_PASSWORD
ENV MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD

ADD ./data.sql /etc/mysql/data.sql
ADD ./populate.py /etc/mysql/populate.py

RUN set -xe \
    && apt-get update -y \
    && apt-get install -y python3-pip

RUN cp /etc/mysql/data.sql /docker-entrypoint-initdb.d
RUN pip install mysql-connector-python
RUN python3 /etc/mysql/populate.py

EXPOSE 3306
