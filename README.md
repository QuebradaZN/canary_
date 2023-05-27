# Elysiera

## Setting up server

Install dependencies:

```sh
sudo apt update -y
sudo apt install -y gdb git jq unzip libtool ca-certificates curl zip unzip tar nginx mysql-server ufw tmux neovim
sudo apt install software-properties-common apt-transport-https -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update -y
sudo apt install php8.1 php8.1-cli php8.1-curl php8.1-fpm php8.1-gd php8.1-mysql php8.1-xml php8.1-zip php8.1-bcmath php8.1-mbstring -y
```

Setup firewall:

```sh
sudo ufw allow 22/tcp
sudo ufw allow 7171/tcp
sudo ufw allow 7172/tcp
sudo ufw allow 8245/tcp

# Cloudflare IPs
for cfip in `curl -sw '\n' https://www.cloudflare.com/ips-v{4,6}`; do sudo ufw allow proto tcp from $cfip to any port 80,443 comment 'Cloudflare IP'; done

sudo ufw enable
sudo ufw reload
```

Configure nginx (`/etc/nginx/sites-enabled/default`):

```nginx
server {
	listen 80 default_server;
	listen [::]:80 default_server;

	root /var/www/html;

	# Add index.php to the list if you are using PHP
	index index.php  index.html index.htm index.nginx-debian.html;

	server_name _;

	location / {
		try_files $uri $uri/ /index.php?$args;
	}

	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
	}

	location ~ /\.ht {
		deny all;
	}
}
```

Start and enable nginx:

```sh
sudo service nginx start
sudo systemctl enable nginx
```

Setup MySQL (`sudo mysql`):

```sql
CREATE USER 'tibia'@'localhost' IDENTIFIED WITH mysql_native_password BY '<password>';
GRANT ALL PRIVILEGES ON *.* TO 'tibia'@'localhost' WITH GRANT OPTION; 
CREATE DATABASE tibia;
```

Setup deploy keys:

```sh
ssh-keygen -t ecdsa -q -f "$HOME/.ssh/id_ecdsa" -N ""
cat ~/.ssh/id_ecdsa.pub # use this in the canary repo
sudo ssh-keygen -t ecdsa -q -f "/root/.ssh/id_ecdsa" -N ""
sudo cat /root/.ssh/id_ecdsa.pub # use this on the canaryaac repo
```

Clone repositories:

```sh
git clone git@github.com:elysiera/canary
chmod -R a+r ~
sudo su
cd /var/www/html
rm -f *
git init .
git remote add origin git@github.com:elysiera/canaryaac
git fetch origin
git reset --hard origin/elysiera
chown -R www-data.www-data /var/www/*
git config --global --add safe.directory /var/www/html
```

Setup website `.env` (`/var/www/html/.env`):

```sh
URL='https://elysiera.com'
SERVER_PATH='/home/ubuntu/canary'

# Database connection
DB_HOST='127.0.0.1'
DB_NAME='tibia'
DB_USER='tibia'
DB_PASS='<db-password>'
DB_PORT='3306'

# Website configs
MAINTENANCE=false
DEV_MODE=false

# PagSeguro
PAGSEGURO_EMAIL=''
PAGSEGURO_TOKEN=''

# Mercado Pago
MERCADOPAGO_TOKEN=''
MERCADOPAGO_KEY=''
MERCADOPAGO_CLIENTID=''
MERCADOPAGO_SECRET=''

# Paypal
PAYPAL_CLIENTID=''
PAYPAL_SECRET=''

# Mail
MAIL_SMTP='smtp://localhost'
MAIL_WEB='no-reply@elysiera.com'

# Outfits Folder
OUTFITS_FOLDER='./resources/images/charactertrade/outfits'
```

Don't forget to add `GITHUB_TOKEN` to `~/.profile`. Now you can run `./update.sh` and `./start.sh` (don't forget `tmux`).

### Canary docs

* [Gitbook](https://docs.opentibiabr.com/projects/canary).
* [Wiki](https://github.com/opentibiabr/canary/wiki).
