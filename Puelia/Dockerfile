FROM ubuntu:20.04
COPY ./Configuracion/config.ttl .
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install  wget openjdk-8-jdk unzip 
RUN mkdir /usr/local/tomcat
RUN mkdir /usr/local/pubby
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.44/bin/apache-tomcat-9.0.44.tar.gz -O /tmp/tomcat.tar.gz
RUN wget http://wifo5-03.informatik.uni-mannheim.de/pubby/download/pubby-0.3.3.zip -O /tmp/pubby.zip

RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cd /tmp && unzip pubby.zip

RUN cp -Rv /tmp/apache-tomcat-9.0.44/* /usr/local/tomcat/
RUN rm -r /usr/local/tomcat/webapps/*
RUN cp -Rv /tmp/pubby-0.3.3/* /usr/local/pubby
RUN cp config.ttl /usr/local/pubby/webapp/WEB-INF/
RUN mkdir /usr/local/tomcat/webapps/ROOT/
RUN cp -r /usr/local/pubby/webapp/* /usr/local/tomcat/webapps/ROOT
EXPOSE 8080
