# FRPC Add-on for Home Assistant

## 功能
在 Home Assistant 内运行 frpc 客户端，支持多架构 (amd64, armv7, arm64)。

## 安装
1. 在 Home Assistant ➝ Supervisor ➝ Add-on Store ➝ Repositories 添加：
   ```
   https://github.com/sunboss/hassio-addons-frpc
   ```
2. 找到 **FRPC Client** 并安装。
3. 在 Add-on 配置中设置你的 `server_addr`、`server_port`、`user`、`token`。
4. 可选：修改 `frp_version` 来指定 FRP 版本（默认 0.61.0）。
5. 启动加载项即可。
