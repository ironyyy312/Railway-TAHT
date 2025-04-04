#!/bin/sh
# Nginx'i arka planda çalıştır
nginx &

# Python WebSocket sunucunuzu başlat
python /app/ws_server.py
