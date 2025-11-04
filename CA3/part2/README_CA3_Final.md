🧩 CA3 – Computação em Ambientes Virtuais com Vagrant
📘 Sumário

Este trabalho prático visa configurar ambientes de desenvolvimento automatizados com Vagrant, provisionamento shell, e integração entre duas máquinas virtuais (web e db), simulando um ambiente de servidor web e base de dados.

🚀 Parte 1 – Configuração e Provisionamento Inicial
🎯 Objetivo

Criar uma VM Ubuntu 22.04 com ferramentas de desenvolvimento essenciais (Git, Java, Maven e Gradle), e clonar dois projetos para teste e compilação automatizada.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.hostname = "ca3-part1"
  config.vm.network "private_network", ip: "192.168.56.10"
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "ca3-part1"
    vb.memory = 2048
    vb.cpus = 2
  end

  config.vm.provision "shell", path: "provision.sh"
end
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

