ARG BUILD_FROM=ghcr.io/hassio-addons/base:14.2.1
FROM $BUILD_FROM

WORKDIR /usr/src

# 设置默认 FRP 版本（可以被 build-arg 覆盖）
ARG FRP_VERSION=0.61.0

# 安装依赖
RUN apk add --no-cache curl jq tar

# 根据架构下载对应的 frpc
RUN ARCH=$(uname -m) &&     case "$ARCH" in       x86_64) FRP_ARCH=amd64 ;;       aarch64) FRP_ARCH=arm64 ;;       armv7l) FRP_ARCH=arm ;;       armhf) FRP_ARCH=arm ;;       *) echo "Unsupported architecture: $ARCH" && exit 1 ;;     esac &&     curl -L "https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_${FRP_ARCH}.tar.gz"     | tar -xz --strip-components=1 -C /usr/local/bin frp_${FRP_VERSION}_linux_${FRP_ARCH}/frpc

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
