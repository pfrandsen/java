FROM resin/rpi-raspbian:jessie
MAINTAINER Peter Frandsen <pfrandsen@gmail.com>
LABEL decription="Raspberry Pi OpenJDK Java 8 JRE"

# This is based on hypriot/rpi-java (see https://github.com/hypriot/rpi-java)
# Updated from wheezy to jessie to use Java 8

# Install dependencies
RUN apt-get update &&  \
    apt-get install -y openjdk-8-jre --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Define JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-armhf

# Define default command
CMD ["bash"]
