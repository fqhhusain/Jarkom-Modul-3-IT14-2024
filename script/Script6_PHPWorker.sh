service nginx start
service php7.3-fpm start

mkdir -p /var/www/eldia.it14.com

wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1TvebIeMQjRjFURKVtA32lO9aL7U2msd6' -O /root/bangsaEldia.zip
unzip -o /root/bangsaEldia.zip -d /var/www/eldia.it14.com

cp /etc/nginx/sites-available/default /etc/nginx/sites-available/eldia.it14.com
ln -s /etc/nginx/sites-available/eldia.it14.com /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

echo '
server {
  listen 80;
  listen [::]:80;

  root /var/www/eldia.it14.com;
  index index.php index.html index.htm;

  server_name eldia.it14.com;

  location / {
    try_files $uri $uri/ =404;
  }

  location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
  }

  location ~ /\.ht {
    deny all;
  }
}' > /etc/nginx/sites-available/eldia.it14.com

service nginx restart
