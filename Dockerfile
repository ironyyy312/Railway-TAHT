# 1. Aşama: Python uygulamanızı hazırlayın
FROM python:3.10-slim as builder

WORKDIR /app

# Gerekli bağımlılıkları yükleyin
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Tüm proje dosyalarını kopyalayın (ws_server.py, bagislar.json, bagis_log.txt, entrypoint.sh, nginx.conf, HTML dosyaları vs.)
COPY . /app

# 2. Aşama: Nginx ve Python uygulamanızı çalıştıracak imajı oluşturun
FROM nginx:alpine

# Nginx yapılandırma dosyasını kopyalayın
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Python uygulamanızın dosyalarını kopyalayın
COPY --from=builder /app /app

# entrypoint.sh dosyasını kopyalayın (dosyanızın LF formatında olduğundan emin olun)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Railway genellikle 80 portunu kullanır
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
