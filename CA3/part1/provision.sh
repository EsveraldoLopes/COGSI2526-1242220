#!/bin/bash
# 🧰 Script de Provisionamento - CA3
# Instalação automática de pacotes básicos e personalização do ambiente

echo "🚀 Iniciando o provisionamento da máquina virtual..."

# Atualizar repositórios e sistema
sudo apt-get update -y && sudo apt-get upgrade -y

# Instalar pacotes úteis
sudo apt-get install -y vim git curl net-tools

# Mensagem final
echo "✅ Provisionamento concluído com sucesso!"
echo "📦 Pacotes instalados: vim, git, curl, net-tools"
