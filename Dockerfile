FROM jenkins:latest

USER root
RUN apt-get update
RUN apt-get install apt-transport-https
RUN echo "deb https://apt.dockerproject.org/repo debian-jessie main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y --force-yes install docker-engine

ADD docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "/bin/bash" ]

