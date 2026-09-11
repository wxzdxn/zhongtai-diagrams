#!/bin/bash
# 发布中台图示到公网(临时链接,进程关闭即失效)
cd "$(dirname "$0")"
pkill -f "http.server 8899" 2>/dev/null
nohup python3 -m http.server 8899 --bind 127.0.0.1 > /tmp/httpserver.log 2>&1 &
sleep 1
echo "本地服务已启动,正在建立公网隧道...（约 20 秒）"
~/bin/cloudflared tunnel --url http://127.0.0.1:8899 --no-autoupdate 2>&1 | tee /tmp/tunnel.log | grep -o "https://[a-z0-9-]*\.trycloudflare\.com" | head -1
