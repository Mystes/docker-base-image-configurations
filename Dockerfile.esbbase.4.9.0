FROM anapsix/alpine-java:jdk8

ENV WSO2_ESB_HOME=/opt/wso2esb-4.9.0 \
    JAVA_OPTS="-Xmx2048m -XX:MaxPermSize=512m -Dfile.encoding=UTF-8"

WORKDIR /opt

RUN apk add --update wget && \
    wget "https://www.dropbox.com/s/g9q8s57ulwexxth/wso2esb-4.9.0_with_patch.zip" && \
    unzip wso2esb-4.9.0_with_patch.zip && \
    rm -f wso2esb-4.9.0_with_patch.zip && \
    chmod +x $WSO2_ESB_HOME/bin/*.sh && \
    apk del wget && \
    rm -rf /tmp/* /var/cache/apk/*

EXPOSE 9443

CMD ["sh", "-c", "${WSO2_ESB_HOME}/bin/wso2server.sh"]
