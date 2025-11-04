#!/bin/bash
# ===============================
# Script de Provisionamento - TP7 Ex2
# Autor: Esveraldo Lopes
# Curso: COGSI 2025/2026
# ===============================

echo "🚀 Iniciando provisionamento da VM $(hostname)..."

sudo apt-get update -y

# Instalação condicional baseada no hostname
if [[ $(hostname) == "web-server" ]]; then
  echo "🌐 Instalando Nginx no web-server..."
  sudo apt-get install -y nginx
  sudo systemctl enable nginx
  sudo systemctl start nginx
elif [[ $(hostname) == "db-server" ]]; then
  echo "💾 Instalando MySQL no db-server..."
  sudo apt-get install -y mysql-server
  sudo systemctl enable mysql
  sudo systemctl start mysql
else
  echo "ℹ️ Nenhum pacote específico para esta VM."
fi

echo "✅ Provisionamento concluído para $(hostname)"
