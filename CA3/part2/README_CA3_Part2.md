# 🧩 CA3 – Parte 2: Arquitetura com Múltiplas VMs (Web + DB)

## 📘 Objetivo
Configurar um ambiente distribuído com **duas máquinas virtuais Vagrant**:
- **web-server** – Servidor de aplicação (Nginx e cliente MySQL)
- **db-server** – Servidor de base de dados (MySQL)

Esta configuração demonstra a comunicação entre serviços em diferentes VMs e a automatização de provisionamento.

---

## ⚙️ Estrutura do Projeto


---

## 🏗️ Arquitetura da Rede

| Máquina       | Hostname     | IP              | Função                     |
|----------------|---------------|------------------|-----------------------------|
| web-server     | `web-server`  | 192.168.56.10    | Servidor Web (Nginx + MySQL client) |
| db-server      | `db-server`   | 192.168.56.11    | Servidor de Base de Dados (MySQL)   |

A rede privada permite comunicação direta entre as duas VMs.

---

## 📄 **Vagrantfile**
O `Vagrantfile` define duas VMs e executa os scripts de provisionamento automaticamente:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"

  # 🖥️ Máquina Web
  config.vm.define "web" do |web|
    web.vm.hostname = "web-server"
    web.vm.network "private_network", ip: "192.168.56.10"
    web.vm.provision "shell", path: "provision-web.sh"
    web.vm.provider "virtualbox" do |vb|
      vb.name = "ca3-part2-web"
      vb.memory = 1024
      vb.cpus = 1
    end
  end

  # 💾 Máquina DB
  config.vm.define "db" do |db|
    db.vm.hostname = "db-server"
    db.vm.network "private_network", ip: "192.168.56.11"
    db.vm.provision "shell", path: "provision-db.sh"
    db.vm.provider "virtualbox" do |vb|
      vb.name = "ca3-part2-db"
      vb.memory = 1024
      vb.cpus = 1
    end
  end
end
