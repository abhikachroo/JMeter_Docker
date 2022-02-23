# Lightweight distro
FROM alpine:3

ARG JMETER_VERSION="5.4.3"
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN ${JMETER_HOME}/bin

## Installing java and dependencies
ARG TZ="Europe/Amsterdam"
ENV TZ ${TZ}
RUN    apk update \
	&& apk upgrade \
	&& apk add ca-certificates \
	&& update-ca-certificates \
	&& apk add --update openjdk8-jre tzdata curl unzip bash \
	&& apk add --no-cache nss \
	&& rm -rf /var/cache/apk/* \	
	&& mkdir -p /opt  \
	&& mkdir -p /opt/tests  \
	&& mkdir -p /opt/results  \

WORKDIR	/opt/

RUN apk add --update python3 py3-pip 
RUN python3 -m venv s4_venv
RUN s4_venv/bin/pip install s4cmd
  
# Set global PATH such that "jmeter" command is found
ENV PATH $PATH:$JMETER_BIN

COPY ./apache-jmeter-5.4.3 /opt/apache-jmeter-5.4.3/
COPY ./entry.sh /opt/apache-jmeter-5.4.3/bin
COPY tests /opt/tests 
WORKDIR	${JMETER_BIN}


CMD ["sh","/opt/apache-jmeter-5.4.3/bin/entry.sh"]
