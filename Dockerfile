FROM openjdk:8-jdk

ARG NODE_VERSION=v10.15.3
ARG NODE_BASE_URL=https://nodejs.org/dist

RUN mkdir -p /usr/share/node \
  && curl -fsSL -o /tmp/nodejs.tar.gz ${NODE_BASE_URL}/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz \
  && tar -xzf /tmp/nodejs.tar.gz -C /usr/share/node --strip-components=1 \
  && rm -f /tmp/nodejs.tar.gz \
  && ln -s /usr/share/node/bin/node /usr/bin/node \
  && ln -s /usr/share/node/bin/npm /usr/bin/npm \
  && npm install -g yarn \
  && ln -s /usr/share/node/bin/yarn /usr/bin/yarn

ARG MAVEN_VERSION=3.6.3
ARG USER_HOME_DIR="/root"
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

CMD ["mvn"]
