FROM python:3.10-slim

# Nginx kurulumu
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Python bağımlılıklarını yükleyin
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Tüm proje dosyalarını kopyalayın (ws_server.py, entrypoint.sh, nginx.conf vb.)
COPY . /app

# Nginx yapılandırma dosyasını kopyalayın
COPY nginx.conf /etc/nginx/conf.d/default.conf

# entrypoint.sh dosyasına çalıştırma izni verin (dosyanın LF formatında olduğundan emin olun)
RUN chmod +x /app/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/app/entrypoint.sh"]
