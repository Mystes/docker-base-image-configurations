FROM lwieske/java-8:jdk-8u112-slim

ENV JAVA_VERSION=jdk-8u112-slim \
    WSO2_ESB_VERSION=5.0.0 \
    JAVA_OPTS="-Xmx2048m -XX:MaxPermSize=512m -Dfile.encoding=UTF-8"

ENV WSO2_ESB_HOME=/opt/wso2esb-$WSO2_ESB_VERSION

ENV \
    ESB_CONFIG_DIR=/config \
    ESB_CARBONAPPS_DIR=/carbonapps \
    ESB_DEPLOY_DIR=/deploy \
    ESB_HOME_CONFIG_DIR=$WSO2_ESB_HOME/repository/conf \
    ESB_HOME_CARBONAPPS_DIR=$WSO2_ESB_HOME/repository/deployment/server/carbonapps \
    ESB_HOME_DEPLOY_DIR=$WSO2_ESB_HOME/repository/deployment/server/synapse-configs

EXPOSE \
    8243 \
    8280 \
    9763 \
    9443

RUN \
    mkdir /opt && \
    cd /opt && \
    apk add --update wget bash && \
    wget --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download"  http://product-dist.wso2.com/products/enterprise-service-bus/$WSO2_ESB_VERSION/wso2esb-$WSO2_ESB_VERSION.zip && \
    unzip wso2esb-$WSO2_ESB_VERSION.zip -d /opt && \
    rm -f wso2esb-$WSO2_ESB_VERSION.zip

COPY ./docker-entrypoint.sh /

RUN \
    chmod +x /docker-entrypoint.sh && \
    chmod +x $WSO2_ESB_HOME/bin/*.sh && \
    apk del wget && \
    rm -rf /tmp/* /var/cache/apk/* && \
    mv $ESB_HOME_CONFIG_DIR $ESB_CONFIG_DIR && \
    ln -s $ESB_CONFIG_DIR $ESB_HOME_CONFIG_DIR && \
    rm -rf /tmp/* /var/cache/apk/* && \
    mkdir $ESB_CARBONAPPS_DIR && \
    rm -rf $ESB_HOME_CARBONAPPS_DIR && \
    ln -s $ESB_CARBONAPPS_DIR $ESB_HOME_CARBONAPPS_DIR && \
    mkdir $ESB_DEPLOY_DIR && \
    mv $ESB_HOME_DEPLOY_DIR /synapse-configs-base && \
    ln -s $ESB_DEPLOY_DIR $ESB_HOME_DEPLOY_DIR

WORKDIR $WSO2_ESB_HOME/bin

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["./wso2server.sh"]
