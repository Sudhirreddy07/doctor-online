FROM tomcat:8

# Copy the WAR file to the Tomcat webapps directory
COPY target/*.war /usr/local/tomcat/webapps/do.war

# Replace the default Tomcat connector port (8080) with port 8081 in server.xml
RUN sed -i 's/8080/8081/g' /usr/local/tomcat/conf/server.xml

# Expose port 8081 to the host
EXPOSE 8081

CMD ["catalina.sh", "run"]
