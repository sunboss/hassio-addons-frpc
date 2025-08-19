#!/usr/bin/with-contenv bashio

CONFIG_PATH=/data/options.json
FRP_SERVER=$(jq -r .frp_server $CONFIG_PATH)
FRP_SERVER_PORT=$(jq -r .frp_server_port $CONFIG_PATH)
FRP_TOKEN=$(jq -r .frp_token $CONFIG_PATH)

cat > /etc/frpc.ini <<EOF
[common]
server_addr = ${FRP_SERVER}
server_port = ${FRP_SERVER_PORT}
token = ${FRP_TOKEN}
EOF

for row in $(jq -c '.tunnels[]' $CONFIG_PATH); do
    NAME=$(echo $row | jq -r .name)
    TYPE=$(echo $row | jq -r .type)
    LOCAL_HOST=$(echo $row | jq -r .local_host)
    LOCAL_PORT=$(echo $row | jq -r .local_port)
    REMOTE_PORT=$(echo $row | jq -r .remote_port)
    SUBDOMAIN=$(echo $row | jq -r .subdomain)

    echo "[$NAME]" >> /etc/frpc.ini
    echo "type = $TYPE" >> /etc/frpc.ini
    echo "local_ip = $LOCAL_HOST" >> /etc/frpc.ini
    echo "local_port = $LOCAL_PORT" >> /etc/frpc.ini

    if [ "$TYPE" = "tcp" ] && [ "$REMOTE_PORT" != "null" ]; then
        echo "remote_port = $REMOTE_PORT" >> /etc/frpc.ini
    fi

    if [ "$TYPE" = "http" ] && [ "$SUBDOMAIN" != "null" ]; then
        echo "subdomain = $SUBDOMAIN" >> /etc/frpc.ini
    fi

    echo "" >> /etc/frpc.ini
done

echo "启动 frpc..."
cat /etc/frpc.ini
exec frpc -c /etc/frpc.ini
