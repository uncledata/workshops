#base image
FROM openjdk:11-jre-slim

RUN apt-get update

# install wget
RUN apt-get install -y bash tini libc6 libpam-modules krb5-user libnss3 procps wget

# Python dependencies
WORKDIR /opt/app
COPY requirements.txt requirements.txt
RUN apt-get install python3.7 -y
RUN apt-get install python3-pip -y
RUN apt-get upgrade python3 -y
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

# Spark Dependencies
WORKDIR /opt/spark/work-dir

RUN wget https://apache.mirror.serveriai.lt/spark/spark-3.1.1/spark-3.1.1-bin-hadoop3.2.tgz
RUN tar -xvf spark-3.1.1-bin-hadoop3.2.tgz

RUN mv spark-3.1.1-bin-hadoop3.2/* /opt/spark
WORKDIR /opt/spark
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
ENV PYSPARK_PYTHON=python3

