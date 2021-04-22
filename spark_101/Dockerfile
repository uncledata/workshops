FROM openjdk:8-slim-buster

ARG POLYNOTE_VERSION="0.4.0"
ARG SCALA_VERSION="2.12"
ARG DIST_TAR="polynote-dist.tar.gz"

WORKDIR /opt

RUN apt update -y && \
    apt install -y wget python3 python3-dev python3-pip build-essential

COPY requirements.txt requirements.txt
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

RUN wget -q https://github.com/polynote/polynote/releases/download/$POLYNOTE_VERSION/$DIST_TAR && \
    tar xfzp $DIST_TAR && \
    echo "DIST_TAR=$DIST_TAR" && \
    rm $DIST_TAR

RUN pip3 install -r ./polynote/requirements.txt

# to wrap up, we create (safe)user
ENV UID 1000
ENV NB_USER polly

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${UID} \
    ${NB_USER}

# allow user access to the WORKDIR
RUN chown -R ${NB_USER}:${NB_USER} /opt/

# start image as (safe)user
USER ${NB_USER}

# expose the (internal) port that polynote runs on
EXPOSE 8192

# use the same scala version for server
ENV POLYNOTE_SCALA_VERSION ${SCALA_VERSION}

# start polynote on container run
ENTRYPOINT ["./polynote/polynote.py"]
