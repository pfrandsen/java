FROM pfrandsen/openjdk-jre8
MAINTAINER Peter Frandsen <pfrandsen@gmail.com>
LABEL decription="Raspberry Pi Wildfly 10 on OpenJDK Java 8 JRE"

# from https://hub.docker.com/r/jboss/wildfly/~/dockerfile/

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 10.0.0.CR5
ENV WILDFLY_SHA1 002e86fcf3f761b3b5c86dbf3fc200f2b43ef66e
ENV JBOSS_HOME /opt/jboss/wildfly

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place

# RUN cd $HOME \
#    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
#    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
#    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
#    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
#    && rm wildfly-$WILDFLY_VERSION.tar.gz

# need to copy file manually for now as Snappy Ubuntu for Raspberry Pi does not have curl
COPY wildfly-10.0.0.CR5.tar.gz /tmp/wildfly-10.0.0.CR5.tar.gz

RUN cd $HOME \
    && mv /tmp/wildfly-$WILDFLY_VERSION.tar.gz . \
    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mkdir -p $JBOSS_HOME && rmdir $JBOSS_HOME \
    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
    && rm wildfly-$WILDFLY_VERSION.tar.gz


# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

# Expose the ports we're interested in
EXPOSE 8080

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
