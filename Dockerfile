FROM tomcat:9.0.31-jdk11-openjdk

WORKDIR $CATALINA_HOME 

EXPOSE 8080

RUN rm -rf $CATALINA_HOME/webapps/examples

ENV BIMSERVER_APP $CATALINA_HOME/webapps/
ENV BIMSERVER_WAR_URL https://github.com/opensourceBIM/BIMserver/releases/download/v1.5.162/bimserverwar-1.5.162.war
RUN set -x \
	&& wget "$BIMSERVER_WAR_URL" -O ROOT.war \	
	&& cp ROOT.war $BIMSERVER_APP \
	&& rm ROOT.war 	

ENV BIM_SITE_ADDRESS="http://localhost:8080" \
	BIM_SMTP_SERVER="fakesmtp.example.org" \
	BIM_SMTP_SENDER="fake.sender@example.org" \
	BIM_ADMIN_NAME="Admin User" \
	BIM_ADMIN_USERNAME="admin@bimserver.org" \
	BIM_ADMIN_PASSWORD="admin"

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["bimserver"]
