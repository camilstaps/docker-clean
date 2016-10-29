FROM debian:jessie
MAINTAINER Camil Staps <info@camilstaps.nl>

RUN apt-get update && apt-get install -qq curl gcc libc6-dev make

RUN mkdir -p /opt/clean
WORKDIR /opt/clean

ENV CLEAN_HOME /opt/clean
ENV PATH /opt/clean/bin:/opt/clean/exe:$PATH

CMD ["clm", "-h"]
