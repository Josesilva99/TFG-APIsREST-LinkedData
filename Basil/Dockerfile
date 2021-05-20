FROM ubuntu:20.04

#FICHEROS PARA REALIZAR LAS PRUEBAS
#-Ejemplo 1-
COPY ./Ejemplos/Ejemplo1/alias.txt .
COPY ./Ejemplos/Ejemplo1/query1.sparql .
COPY ./Ejemplos/Ejemplo1/user1.json .

#-Ejemplo 2-
COPY ./Ejemplos/Ejemplo2/query2.sparql .
COPY ./Ejemplos/Ejemplo2/user2.json .
#----------------------------------
COPY script.sh .
COPY basil.ini .
COPY run.sh .
COPY pom.xml .
RUN apt-get -y update && apt-get -y upgrade 
RUN apt-get -y install  wget openjdk-11-jdk unzip maven
RUN apt-get -y install nano curl
RUN wget https://github.com/basilapi/basil/archive/refs/tags/v0.8.0.zip -O /tmp/basil.zip
RUN cd /tmp && unzip basil.zip
RUN cp pom.xml /tmp/basil-0.8.0/server/
RUN cp basil.ini /tmp/basil-0.8.0/
RUN cd /tmp/basil-0.8.0 && mvn clean install
RUN apt-get -y install mysql-server
RUN wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java_8.0.24-1ubuntu18.04_all.deb
RUN apt install ./mysql-connector-java_8.0.24-1ubuntu18.04_all.deb
RUN export CLASSPATH=/usr/share/java/mysql-connector-java-8.0.24.jar
RUN ./script.sh
EXPOSE 8080

