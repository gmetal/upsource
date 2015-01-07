# Upsource server environment for ubuntu precise (14.04 LTS).
# version 0.0.1
# Start with ubuntu precise (LTS).
FROM ubuntu:14.04
MAINTAINER gmetaxas <gmetaxas@gmail.com>
# Never ask for confirmations
ENV DEBIAN_FRONTEND noninteractive
RUN echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections
# Update apt
RUN apt-get update
# First, install add-apt-repository and bzip2
RUN apt-get -y install python-software-properties bzip2
#install add-apt-repository
RUN apt-get -y install software-properties-common wget
# Install apache ant
RUN wget http://archive.apache.org/dist/ant/binaries/apache-ant-1.8.4-bin.tar.gz
RUN tar -xvzf apache-ant-1.8.4-bin.tar.gz
RUN mv apache-ant-1.8.4 /usr/local/apache-ant
#Install unzip
RUN apt-get -y install unzip

# Add ant to PATH
ENV ANT_HOME /usr/local/apache-ant
ENV PATH $PATH:$ANT_HOME/bin

# Download and install upsource
RUN wget http://download.jetbrains.com/upsource/upsource-1.0.12551.zip 
RUN unzip upsource-1.0.12551.zip
RUN mv Upsource /usr/local/upsource

#OpenJDK 1.7 is a requirement for upsource
RUN sudo apt-get update && sudo apt-get install -y openjdk-7-jdk

#Export JAVA_HOME and setup hosts 
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-amd64
RUN export PATH=~/bin:$JAVA_HOME/bin:$PATH
RUN echo \"127.0.0.1 upsource-docker\" >> /etc/hosts
RUN echo \"upsource-docker\" > /etc/hostname
RUN /usr/local/upsource/bin/upsource.sh configure --listen-port 8081
EXPOSE 8081
VOLUME ["/usr/local/upsource/conf/data"]
