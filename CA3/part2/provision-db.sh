#!/bin/bash
set -e

echo "💾 Iniciando provisionamento da VM DB..."

# Atualizar pacotes
sudo apt-get update -y

# Instalar MySQL
sudo apt-get install -y mysql-server

# Configurar MySQL para aceitar conexões externas
sudo sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Reiniciar o serviço
sudo systemctl restart mysql
sudo systemctl enable mysql

# Criar base de dados e utilizador remoto
sudo mysql -e "CREATE DATABASE ca3db;"
sudo mysql -e "CREATE USER 'webuser'@'%' IDENTIFIED BY 'vagrant';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ca3db.* TO 'webuser'@'%';"
sudo mysql -e "FLUSH PRIVILEGES;"

echo "✅ Provisionamento concluído: MySQL Server pronto!"
