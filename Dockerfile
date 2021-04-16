FROM tomcat:9.0.31-jdk11-openjdk

WORKDIR $CATALINA_HOME 

EXPOSE 8080

RUN rm -rf $CATALINA_HOME/webapps/examples

ENV BIMSERVER_APP $CATALINA_HOME/webapps/
ENV BIMSERVER_WAR_URL https://github.com/opensourceBIM/BIMserver/releases/download/v1.5.162/bimserverwar-1.5.162.war

RUN set -x \
	&& wget "$BIMSERVER_WAR_URL" -O ROOT.war \	
	&& cp ROOT.war $BIMSERVER_APP \
	&& rm ROOT.war	\
	&& rm $CATALINA_HOME/conf/server.xml


COPY server.xml $CATALINA_HOME/conf/
RUN chown -R root $CATALINA_HOME/conf/server.xml

RUN mkdir /usr/local/bimserver \
    && mkdir /usr/local/bimserver/home \
    && chown -R root  /usr/local/bimserver/home

VOLUME /usr/local/bimserver/home

CMD catalina.sh run