#!/usr/bin/env bash
CONFIG_PATH=/data/options.json

SERVER_ADDR=$(jq --raw-output ".server_addr" $CONFIG_PATH)
SERVER_PORT=$(jq --raw-output ".server_port" $CONFIG_PATH)
USER=$(jq --raw-output ".user" $CONFIG_PATH)
TOKEN=$(jq --raw-output ".token" $CONFIG_PATH)
FRP_VERSION=$(jq --raw-output ".frp_version" $CONFIG_PATH)

cat <<EOF > /etc/frpc.ini
[common]
server_addr = ${SERVER_ADDR}
server_port = ${SERVER_PORT}
user = ${USER}
token = ${TOKEN}
EOF

echo "Starting FRPC v${FRP_VERSION} with server ${SERVER_ADDR}:${SERVER_PORT}"
/usr/local/bin/frpc -c /etc/frpc.ini 2>&1
