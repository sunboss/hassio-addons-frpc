ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.0.0
FROM ${BUILD_FROM}

# 安装 FRP
RUN apk add --no-cache curl unzip \
    && curl -L https://github.com/fatedier/frp/releases/download/v0.59.0/frp_0.59.0_linux_amd64.tar.gz -o /tmp/frp.tar.gz \
    && tar -xzf /tmp/frp.tar.gz -C /tmp \
    && mv /tmp/frp_0.59.0_linux_amd64/frpc /usr/bin/frpc \
    && chmod +x /usr/bin/frpc \
    && rm -rf /tmp/*

# 拷贝 rootfs 里的 s6 服务定义
COPY rootfs /

# 镜像标签
LABEL \
    io.hass.version="1.0.0" \
    io.hass.type="addon" \
    io.hass.name="FRPC"
