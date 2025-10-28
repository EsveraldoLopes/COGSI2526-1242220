# ��� Tutorial – CA3 (Virtualização e Provisionamento)

### ��� Unidade Curricular
**Configuração e Gestão de Sistemas (COGSI)**  
**Professor:** Luís Nogueira  
**Estudante:** Esveraldo Lopes  
**Ano Letivo:** 2025/2026  
**Instituição:** ISEP – Instituto Superior de Engenharia do Porto  

---

## 1️⃣ Objetivo

Implementar uma solução de **virtualização e provisionamento automático** utilizando **Vagrant** e **Shell Script**.  
O objetivo é compreender o processo de criação e configuração automatizada de uma máquina virtual Ubuntu Linux.

---

## 2️⃣ Ferramentas Utilizadas

| Ferramenta | Função | Versão |
|-------------|--------|--------|
| **Vagrant** | Gestão de máquinas virtuais | 2.4.0 |
| **VirtualBox** | Hipervisor (execução das VMs) | 7.x |
| **Ubuntu Server** | Sistema operativo convidado | 22.04 LTS |
| **Shell Script** | Automação de configuração (provisionamento) | — |
| **Git Bash** | Terminal de execução | Windows 11 |

---

## 3️⃣ Estrutura de Ficheiros

Após a configuração inicial do projeto, a estrutura ficou assim:

```bash
CA3/
├── Vagrantfile
├── provision.sh
└── README_CA3.md
4️⃣ Configuração da Máquina Virtual
��� Ficheiro Vagrantfile
O ficheiro principal do Vagrant define o sistema base, a rede e o script de provisionamento automático.

ruby
Copiar código
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.hostname = "ca3-vm"
  config.vm.network "private_network", ip: "192.168.56.10"
  config.vm.provision "shell", path: "provision.sh"
end
5️⃣ Script de Provisionamento (provision.sh)
O script executa automaticamente a instalação de pacotes essenciais quando a VM é criada.

bash
Copiar código
#!/bin/bash
echo "��� Iniciando provisionamento do ambiente..."

# Atualizar pacotes e instalar ferramentas básicas
sudo apt-get update -y
sudo apt-get install -y vim git curl net-tools

echo "✅ Provisionamento concluído com sucesso!"
echo "��� Pacotes instalados: vim, git, curl, net-tools"
��� O Vagrant chama este script automaticamente durante o vagrant up.

6️⃣ Execução dos Comandos Principais
6.1 Iniciar a máquina virtual
bash
Copiar código
vagrant up
6.2 Aceder à máquina
bash
Copiar código
vagrant ssh
6.3 Verificar IP e pacotes instalados
bash
Copiar código
ip a | grep 192
git --version
vim --version
curl --version
6.4 Encerrar ou destruir a VM
bash
Copiar código
vagrant halt      # Desliga a máquina
vagrant destroy   # Remove completamente a VM
7️⃣ Verificação de Sucesso
Durante o vagrant up, o terminal apresentou as mensagens:

cpp
Copiar código
default: ✅ Provisionamento concluído com sucesso!
default: ��� Pacotes instalados: vim, git, curl, net-tools
E dentro da VM, a execução de:

bash
Copiar código
vagrant@ca3-vm:~$ git --version
vagrant@ca3-vm:~$ ip a
confirmou que a máquina estava operacional e corretamente configurada.

8️⃣ Conclusões
Com este exercício, foi possível compreender:

O funcionamento de Vagrant como ferramenta de gestão de ambientes virtuais;

O papel do VirtualBox como hipervisor;

O uso de scripts de provisionamento (Shell) para automatizar configurações;

O conceito de infraestrutura como código (IaC);

A importância da reprodutibilidade de ambientes em DevOps e administração de sistemas.

9️⃣ Referências
Vagrant Official Documentation

VirtualBox User Manual

Ubuntu Server Documentation

Shell Scripting Guide

��� Data: 28/10/2025
✍️ Autor: Esveraldo Lopes
���️ Instituição: ISEP – Instituto Superior de Engenharia do Porto


