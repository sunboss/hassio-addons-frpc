ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.3.2
FROM ${BUILD_FROM}

# 设置工作目录
WORKDIR /app

# 下载 frpc
RUN apk add --no-cache curl \
  && FRP_VERSION=$(curl -s https://api.github.com/repos/fatedier/frp/releases/latest | grep tag_name | cut -d '"' -f4 | sed 's/v//') \
  && wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz -O frp.tar.gz \
  && tar -xzf frp.tar.gz --strip-components=1 \
  && mv frpc /usr/local/bin/frpc \
  && chmod +x /usr/local/bin/frpc \
  && rm -rf frp.tar.gz

# 拷贝运行脚本
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
