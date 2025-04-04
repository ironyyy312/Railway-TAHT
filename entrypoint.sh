#!/bin/sh
nginx &
python /app/ws_server.py
