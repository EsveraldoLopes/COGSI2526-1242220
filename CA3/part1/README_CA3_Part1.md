# CA3 - Parte 1: Ambiente de Desenvolvimento Automatizado

## 🧰 Objetivo
Criar uma máquina virtual Vagrant configurada automaticamente para um ambiente de desenvolvimento com Git, Java, Maven e Gradle.  
O provisionamento instala dependências, clona projetos e compila o código automaticamente.

---

## ⚙️ Vagrantfile

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"
  config.vm.hostname = "ca3-part1"
  config.vm.network "private_network", ip: "192.168.56.10"
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", path: "provision.sh"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "ca3-part1"
    vb.memory = "2048"
    vb.cpus = 2
  end
end
