#!/bin/bash
set -e

echo "🚀 Iniciando provisionamento da VM Web..."

# Atualizar pacotes
sudo apt-get update -y

# Instalar Nginx
sudo apt-get install -y nginx

# Criar página HTML simples
echo "<h1>CA3 - Parte 2: Web Server OK</h1>" | sudo tee /var/www/html/index.html

# Garantir que o serviço está ativo
sudo systemctl enable nginx
sudo systemctl restart nginx

echo "✅ Provisionamento concluído: Web Server pronto!"
