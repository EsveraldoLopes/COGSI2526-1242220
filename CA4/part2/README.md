# 🧩 CA4 – Parte 2: Automação de Provisionamento com Ansible e Vagrant

## 📘 Introdução
...  # 🧩 CA4 – Parte 2: Automação de Provisionamento com Ansible e Vagrant

## 📑 Índice
- [📘 Introdução](#-introdução)
  - [🧱 Tecnologias Utilizadas](#-tecnologias-utilizadas)
- [⚙️ Análise de Requisitos](#️-análise-de-requisitos)
- [🧰 Implementação Passo a Passo](#-implementação-passo-a-passo)
  - [1️⃣ Criar e iniciar as VMs](#1️⃣-criar-e-iniciar-as-vms)
  - [2️⃣ Instalar o Ansible na máquina Web](#2️⃣-instalar-o-ansible-na-máquina-web)
  - [3️⃣ Configurar o inventário](#3️⃣-configurar-o-inventário)
  - [4️⃣ Testar conectividade entre as VMs](#4️⃣-testar-conectividade-entre-as-vms)
  - [5️⃣ Executar o Playbook](#5️⃣-executar-o-playbook)
  - [6️⃣ Executar o Playbook (execução real)](#6️⃣-executar-o-playbook-execução-real)
  - [7️⃣ Configurar PHP e testar ligação MySQL](#7️⃣-configurar-php-e-testar-ligação-mysql)
  - [8️⃣ Testar no navegador](#8️⃣-testar-no-navegador)
- [🔍 Análise da Solução](#-análise-da-solução)
- [🔄 Soluções Alternativas](#-soluções-alternativas)
- [🧠 Conclusão](#-conclusão)
- [📎 Referências](#-referências)

---

## 📘 Introdução

Este projeto implementa a **automação completa de provisionamento e configuração** de duas máquinas virtuais integradas — uma para a camada de aplicação (**Web Server**) e outra para a camada de base de dados (**Database Server**) — usando **Vagrant, VirtualBox e Ansible**.

A proposta é aplicar conceitos de **Infraestrutura como Código (IaC)** e **DevOps**, mostrando como criar, configurar e orquestrar ambientes automaticamente a partir de scripts reprodutíveis.

### 🧱 Tecnologias Utilizadas

| Tecnologia | Função |
|-------------|--------|
| **Vagrant + VirtualBox** | Criação e gestão automatizada de máquinas virtuais |
| **Ansible** | Ferramenta de automação de configuração (provisionamento remoto) |
| **Nginx + PHP-FPM** | Servidor web leve e eficiente para processamento PHP |
| **MySQL Server** | Sistema de gestão de bases de dados relacional |
| **Rede Host-Only** | Comunicação privada entre as VMs sem acesso externo |

---

## ⚙️ Análise de Requisitos

Para a execução desta parte do projeto, foram definidos os seguintes requisitos técnicos:

1. **Criação de duas VMs:**
   - `web-server` – IP: `192.168.56.20`
   - `db-server` – IP: `192.168.56.21`
   - Configuração feita via Vagrantfile com rede *host-only*.

2. **Instalação do Ansible no Web Server**
   - O Ansible é instalado diretamente na VM `web-server` para atuar como **control node**, gerindo a segunda máquina (`db-server`).

3. **Inventário Ansible**
   - Criação do ficheiro `/vagrant/provision/inventory` com as credenciais SSH e IPs das VMs.

4. **Criação de Playbook de Automação**
   - Implementação do ficheiro `playbook.yml` que instala e configura automaticamente:
     - Nginx no `web-server`
     - MySQL no `db-server`

5. **Testes de conectividade SSH**
   - Verificação do acesso entre as VMs através de chaves privadas.

6. **Implementação de Script PHP de Conexão**
   - Criação do ficheiro `testdb.php` para validar a ligação entre o servidor web e a base de dados MySQL.

---

## 🧰 Implementação Passo a Passo

### 1️⃣ Criar e iniciar as VMs
```bash
vagrant up
vagrant ssh web
2️⃣ Instalar o Ansible na máquina Web
bash
Copiar código
sudo apt update -y
sudo apt install ansible -y
🔍 O Ansible atua como orquestrador, conectando-se via SSH a outras VMs definidas no inventário.

3️⃣ Configurar o inventário
Arquivo: /vagrant/provision/inventory

ini
Copiar código
[web]
192.168.56.20 ansible_user=vagrant ansible_ssh_private_key_file=~/.ssh/id_rsa

[db]
192.168.56.21 ansible_user=vagrant ansible_ssh_private_key_file=~/.ssh/id_rsa_db
4️⃣ Testar conectividade entre as VMs
bash
Copiar código
ansible all -i inventory -m ping
✅ Saída esperada:

ruby
Copiar código
192.168.56.20 | SUCCESS => { "ping": "pong" }
192.168.56.21 | SUCCESS => { "ping": "pong" }
5️⃣ Executar o Playbook
Arquivo: /vagrant/provision/playbook.yml

yaml
Copiar código
--- 
- name: Configurar Web Server
  hosts: web
  become: yes
  tasks:
    - name: Atualizar pacotes
      apt:
        update_cache: yes
    - name: Instalar Nginx
      apt:
        name: nginx
        state: present
    - name: Garantir que Nginx está ativo
      service:
        name: nginx
        state: started
        enabled: yes

- name: Configurar DB Server
  hosts: db
  become: yes
  tasks:
    - name: Instalar MySQL
      apt:
        name: mysql-server
        state: present
    - name: Garantir que MySQL está ativo
      service:
        name: mysql
        state: started
        enabled: yes
6️⃣ Executar o Playbook (execução real)
bash
Copiar código
ansible-playbook playbook.yml -i inventory
✅ Saída esperada:

nginx
Copiar código
PLAY RECAP
192.168.56.20 : ok=4  changed=2  failed=0
192.168.56.21 : ok=3  changed=1  failed=0
7️⃣ Configurar PHP e testar ligação MySQL
bash
Copiar código
sudo apt install php php-mysql -y
sudo systemctl stop apache2
sudo systemctl disable apache2
sudo systemctl restart nginx
Arquivo: /var/www/html/testdb.php

php
Copiar código
<?php
$conn = new mysqli('192.168.56.21', 'root', '', '');
if ($conn->connect_error) {
    die('❌ Falha na ligação: ' . $conn->connect_error);
}
echo '✅ Ligação MySQL bem-sucedida!';
$conn->close();
?>
8️⃣ Testar no navegador
Aceder a:

arduino
Copiar código
http://192.168.56.20/testdb.php
✅ Saída esperada:

Copiar código
✅ Ligação MySQL bem-sucedida!
🔍 Análise da Solução
Aspeto	Descrição
Automação Total	Todas as configurações foram aplicadas automaticamente via Ansible, reduzindo erros manuais.
Infraestrutura Reprodutível	O uso de Vagrant garante que o mesmo ambiente pode ser criado em qualquer máquina.
Separação de Funções	A arquitetura foi dividida em Web e DB para espelhar sistemas reais em produção.
Comunicação Segura	Conexão via SSH e chaves privadas entre as VMs.

🔄 Soluções Alternativas
1️⃣ Docker Compose

Poderia substituir Vagrant, criando os containers web e db via YAML.

Reduz recursos e tempo de inicialização.

Ideal para ambientes de desenvolvimento rápido.

2️⃣ Terraform + Ansible

Terraform geraria as VMs na cloud (AWS, Azure).

O Ansible continuaria a fazer a configuração.

Indicado para ambientes híbridos e escaláveis.

3️⃣ LXD Containers

Substitui VirtualBox por containers de sistema.

Mais leve e rápido para simular múltiplos hosts Ubuntu.

Requer menor overhead e integra bem com Ansible.

🧠 Conclusão
O trabalho demonstrou de forma prática a aplicação dos princípios de DevOps e Infraestrutura como Código, integrando Vagrant, Ansible, Nginx, PHP e MySQL num ambiente totalmente automatizado.

Criaram-se duas VMs comunicantes via rede privada.

O Ansible geriu a configuração remota, instalando e ativando serviços essenciais.

A validação com testdb.php comprovou a integração entre camadas.

💡 Conclusão técnica:
O aluno demonstrou domínio na gestão de ambientes virtualizados, automação de configurações e integração de serviços — competências centrais na área de DevOps e Cloud Engineering.

📎 Referências
Vagrant Documentation

Ansible User Guide

Nginx + PHP-FPM Setup

MySQL Secure Installation
