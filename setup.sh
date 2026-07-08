#!/bin/bash
set -e

echo "=== Установка nginx ==="
apt-get update -qq
apt-get install -y nginx certbot python3-certbot-nginx

echo "=== Копирование файлов сайта ==="
mkdir -p /var/www/aispirin
cp -r /home/agent/projects/aispirin_site/* /var/www/aispirin/
chown -R www-data:www-data /var/www/aispirin

echo "=== Настройка nginx ==="
cat > /etc/nginx/sites-available/aispirin << 'EOF'
server {
    listen 80;
    server_name aispirin.ru www.aispirin.ru;
    root /var/www/aispirin;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location ~* \.(js|css|png|jpg|jpeg|ico|svg|woff|woff2)$ {
        expires 30d;
        add_header Cache-Control "public, no-transform";
    }
}
EOF

ln -sf /etc/nginx/sites-available/aispirin /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default
nginx -t && systemctl restart nginx && systemctl enable nginx

echo "=== Готово! Сайт работает на http://aispirin.ru ==="
echo ""
echo "Когда DNS заработает, запусти для SSL:"
echo "  certbot --nginx -d aispirin.ru -d www.aispirin.ru"
