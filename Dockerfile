# Pull base image - ubuntu with java 8
# Syntax: FROM <image>[:<tag>] [AS <name>]
FROM openjdk:8

MAINTAINER Dominik Grzelak "dominik@offbeat-pioneer.net"

# Root
USER root
RUN groupadd -g 1001 ruser
RUN useradd -u 1001 -g staff -m ruser
RUN usermod -a -G ruser,staff ruser

# Pre-requirements
RUN apt-get clean && apt-get update && apt-get install -y --no-install-recommends apt-utils
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y \
        software-properties-common \
        libssl-dev \
        libxml2-dev \
        libreadline-gplv2-dev

## R install

RUN apt-get install -y \
        r-base \
        r-recommended \
        r-base-dev

COPY ./etc/ /etc/

# User
COPY ./home/ruser /home/ruser
RUN chown -R ruser:staff /home/ruser

RUN R CMD INSTALL /home/ruser/Rserve_1.8-5.tar.gz

#USER ruser
WORKDIR /home/ruser
#RUN /home/ruser/start_Rserve.sh
ENTRYPOINT /home/ruser/start_Rserve.sh && /bin/bash
#ENTRYPOINT ["/home/ruser/start_Rserve.sh", "/bin/bash"]