FROM jboss/wildfly:10.1.0.Final

ENV USER team
ENV GROUP team

RUN /opt/jboss/wildfly/bin/add-user.sh ${USER} ${GROUP} --silent

#ADD *.war /opt/jboss/wildfly/standalone/deployments/
