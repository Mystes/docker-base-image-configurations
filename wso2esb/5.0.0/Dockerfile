FROM anapsix/alpine-java:jdk8

ENV WSO2_ESB_HOME=/opt/wso2esb-5.0.0 \
    JAVA_OPTS="-Xmx2048m -XX:MaxPermSize=512m -Dfile.encoding=UTF-8"

WORKDIR /opt

RUN apk add --update wget && \
    wget --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download"  http://product-dist.wso2.com/products/enterprise-service-bus/5.0.0/wso2esb-5.0.0.zip && \
    unzip wso2esb-5.0.0.zip && \
    rm -f wso2esb-5.0.0.zip && \
    chmod +x $WSO2_ESB_HOME/bin/*.sh && \
    apk del wget && \
    rm -rf /tmp/* /var/cache/apk/*

EXPOSE 9443

CMD ["sh", "-c", "${WSO2_ESB_HOME}/bin/wso2server.sh"]
