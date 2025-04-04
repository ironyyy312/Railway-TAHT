FROM python:3.10-slim

# Nginx kuruyoruz
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Proje klasörünü belirleyin
WORKDIR /app

# Python bağımlılıklarını yükleyin
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Tüm dosyaları kopyalayın (ws_server.py, bagislar.json, tahta.html, sure.html, entrypoint.sh, nginx.conf vs.)
COPY . /app

# Nginx konfigürasyonunu yerleştirin (nginx.conf'ı default.conf'a kopyalayabilirsiniz)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# entrypoint.sh (LF formatlı) dosyanızı kopyalayıp çalıştırma izni verin
RUN chmod +x /app/entrypoint.sh

# Railway genelde 80 portunu açar
EXPOSE 80

# Container başlarken hem Nginx'i hem Python'u başlatmak için entrypoint.sh kullanıyoruz
ENTRYPOINT ["/app/entrypoint.sh"]
