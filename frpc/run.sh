#!/usr/bin/with-contenv bashio
# 启动 frpc

CONFIG_FILE="/data/options.json"
TMP_FRPC_INI="/tmp/frpc.ini"

bashio::log.info "Generating frpc.ini from options.json..."

# 生成配置文件
cat > "$TMP_FRPC_INI" <<EOF
[common]
server_addr = $(bashio::config 'frp_server')
server_port = $(bashio::config 'frp_server_port')
token = $(bashio::config 'frp_token')
EOF

for tunnel in $(bashio::config 'tunnels|keys'); do
    name=$(bashio::config "tunnels[${tunnel}].name")
    type=$(bashio::config "tunnels[${tunnel}].type")
    local_host=$(bashio::config "tunnels[${tunnel}].local_host")
    local_port=$(bashio::config "tunnels[${tunnel}].local_port")
    remote_port=$(bashio::config "tunnels[${tunnel}].remote_port")
    subdomain=$(bashio::config "tunnels[${tunnel}].subdomain")

    echo "[${name}]" >> "$TMP_FRPC_INI"
    echo "type = ${type}" >> "$TMP_FRPC_INI"
    echo "local_ip = ${local_host}" >> "$TMP_FRPC_INI"
    echo "local_port = ${local_port}" >> "$TMP_FRPC_INI"

    if [ "$type" = "tcp" ]; then
        echo "remote_port = ${remote_port}" >> "$TMP_FRPC_INI"
    fi

    if [ "$type" = "http" ]; then
        echo "subdomain = ${subdomain}" >> "$TMP_FRPC_INI"
    fi

done

bashio::log.info "Starting frpc..."
exec frpc -c "$TMP_FRPC_INI"
