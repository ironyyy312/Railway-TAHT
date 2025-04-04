# 1. Aşama: Python uygulamanızı hazırlayın
FROM python:3.10-slim as builder

WORKDIR /app

# Proje dosyalarınızı kopyalayın
COPY . /app

# Bağımlılıkları yükleyin
RUN pip install --no-cache-dir -r requirements.txt

# 2. Aşama: Nginx ve Python uygulamanızı çalıştırın
FROM nginx:alpine

# Nginx yapılandırma dosyasını kopyalayın
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Python uygulamanızın dosyalarını kopyalayın
COPY --from=builder /app /app

# Railway genellikle 80 portunu kullanır
EXPOSE 80

# Basit bir giriş noktası betiği: Nginx'i ve Python uygulamanızı aynı anda çalıştırın
RUN echo '#!/bin/sh\nnginx &\npython /app/ws_server.py' > /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
