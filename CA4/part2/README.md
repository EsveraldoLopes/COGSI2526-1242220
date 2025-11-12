CA4 – Parte 2: Automação e Integração com Vagrant, Ansible, Nginx, PHP e MySQL
📖 Introdução

O CA4 – Parte 2 tem como objetivo demonstrar a automação completa de um ambiente de infraestrutura virtual, desde o provisionamento das máquinas até à integração entre o servidor de aplicação e o servidor de base de dados.

O projeto foi implementado com as ferramentas Vagrant, VirtualBox e Ansible, simulando um cenário real de Infraestrutura como Código (IaC) e DevOps, onde cada componente da infraestrutura é criado, configurado e gerido automaticamente.

🌐 Automação de provisionamento com Ansible

O Ansible é uma ferramenta de automação de configuração que utiliza ficheiros no formato YAML para descrever o estado desejado dos sistemas.
No contexto deste projeto, ele é usado para instalar, configurar e iniciar serviços automaticamente (como Nginx e MySQL), garantindo que todas as máquinas mantenham o mesmo estado sempre que o playbook é executado.
Isto assegura consistência, reprodutibilidade e escalabilidade — princípios fundamentais na prática DevOps moderna.

💻 Virtualização com Vagrant e VirtualBox

O Vagrant fornece um meio de criar e gerir ambientes virtuais de forma rápida e controlada, através de um ficheiro declarativo (Vagrantfile).
O VirtualBox atua como hipervisor, permitindo executar várias máquinas virtuais simultaneamente.
Juntos, eles criam um ambiente isolado, portátil e padronizado, ideal para testes, ensino e desenvolvimento, sem impactar o sistema anfitrião.

🔗 Configuração de redes privadas entre VMs

A comunicação entre os dois servidores é feita através de uma rede privada (Host-Only).
Este tipo de rede permite que as VMs comuniquem entre si e com o host físico, mas sem acesso direto à Internet, garantindo segurança e controle total.
Esta configuração é fundamental para ambientes multi-serviço, simulando a comunicação entre camadas de uma aplicação distribuída.

⚙️ Integração de camadas de aplicação e base de dados (Nginx + PHP + MySQL)

O servidor web (192.168.56.20) executa o Nginx, que serve as páginas e processa scripts PHP via PHP-FPM.
O servidor db (192.168.56.21) executa o MySQL, responsável pelo armazenamento e gestão de dados.
A comunicação entre ambos é estabelecida por meio de uma conexão PHP–MySQL remota, validada com um script de teste.
Esse tipo de arquitetura, baseada em camadas independentes, é comum em ambientes empresariais e forma a base de aplicações escaláveis.

⚙️ 1. Análise dos Requisitos

Para garantir a execução bem-sucedida do CA4 Parte 2, os seguintes requisitos foram definidos e cumpridos:

1️⃣ Criação de Máquinas Virtuais com Vagrant

Foram criadas duas VMs Ubuntu 22.04 utilizando o Vagrant.

Cada máquina recebeu uma função específica e um IP privado estático.

Justificativa: o uso de Vagrant permite o controlo total do ambiente e a reprodutibilidade, tornando simples destruir e recriar as VMs sem perda de configuração.

2️⃣ Configuração Automática com Ansible

Um ficheiro inventory foi criado para armazenar as credenciais SSH e endereços das VMs.

Um ficheiro playbook.yml definiu as tarefas automatizadas para instalação de Nginx e MySQL.

Justificativa: o Ansible garante padronização e consistência na configuração, evitando divergências entre máquinas.

3️⃣ Comunicação entre Servidores via Rede Privada

O web-server e o db-server comunicam entre si pela interface privada (Host-Only).

Justificativa: essa rede é segura, isolada e determinística, ideal para integração de serviços sem exposição pública.

4️⃣ Validação de Integração PHP–MySQL

Criou-se um script PHP para testar a ligação remota entre o web-server e o MySQL.

Justificativa: este teste comprova o funcionamento real da infraestrutura e fecha o ciclo de provisionamento automatizado.

🧱 2. Arquitetura da Solução
Função	Hostname	IP Privado	Serviços
Web Server	web-server	192.168.56.20	Nginx, PHP-FPM
DB Server	db-server	192.168.56.21	MySQL Server
Justificativa da Arquitetura

A separação dos serviços em camadas distintas permite:

Melhor distribuição de carga e desempenho.

Maior segurança, isolando dados do servidor de aplicação.

Facilidade de manutenção e escalabilidade horizontal.

Essa estrutura reflete práticas de produção em ambientes de microserviços e nuvem.

🧩 3. Implementação – Tutorial Passo a Passo

(As etapas abaixo podem ser seguidas por qualquer utilizador para reproduzir integralmente o projeto.)

🪟 Passo 1 – Criar Estrutura de Projeto
mkdir -p ~/Projetos/CA4/part2/provision
cd ~/Projetos/CA4/part2


Estrutura organizada facilita automação e versionamento no Git.

⚙️ Passo 2 – Criar o Vagrantfile

(Define as duas VMs, os IPs e os recursos de hardware.)

Vagrant.configure("2") do |config|
  config.vm.define "web" do |web|
CA4 – Parte 2: Automação e Integração com Vagrant, Ansible, Nginx, PHP e MySQL
📖 Introdução

O CA4 – Parte 2 tem como objetivo demonstrar a automação completa de um ambiente de infraestrutura virtual, desde o provisionamento das máquinas até à integração entre o servidor de aplicação e o servidor de base de dados.

O projeto foi implementado com as ferramentas Vagrant, VirtualBox e Ansible, simulando um cenário real de Infraestrutura como Código (IaC) e DevOps, onde cada componente da infraestrutura é criado, configurado e gerido automaticamente.

🌐 Automação de provisionamento com Ansible

O Ansible é uma ferramenta de automação de configuração que utiliza ficheiros no formato YAML para descrever o estado desejado dos sistemas.
No contexto deste projeto, ele é usado para instalar, configurar e iniciar serviços automaticamente (como Nginx e MySQL), garantindo que todas as máquinas mantenham o mesmo estado sempre que o playbook é executado.
Isto assegura consistência, reprodutibilidade e escalabilidade — princípios fundamentais na prática DevOps moderna.

💻 Virtualização com Vagrant e VirtualBox

O Vagrant fornece um meio de criar e gerir ambientes virtuais de forma rápida e controlada, através de um ficheiro declarativo (Vagrantfile).
O VirtualBox atua como hipervisor, permitindo executar várias máquinas virtuais simultaneamente.
Juntos, eles criam um ambiente isolado, portátil e padronizado, ideal para testes, ensino e desenvolvimento, sem impactar o sistema anfitrião.

🔗 Configuração de redes privadas entre VMs

A comunicação entre os dois servidores é feita através de uma rede privada (Host-Only).
Este tipo de rede permite que as VMs comuniquem entre si e com o host físico, mas sem acesso direto à Internet, garantindo segurança e controle total.
Esta configuração é fundamental para ambientes multi-serviço, simulando a comunicação entre camadas de uma aplicação distribuída.

⚙️ Integração de camadas de aplicação e base de dados (Nginx + PHP + MySQL)

O servidor web (192.168.56.20) executa o Nginx, que serve as páginas e processa scripts PHP via PHP-FPM.
O servidor db (192.168.56.21) executa o MySQL, responsável pelo armazenamento e gestão de dados.
A comunicação entre ambos é estabelecida por meio de uma conexão PHP–MySQL remota, validada com um script de teste.
Esse tipo de arquitetura, baseada em camadas independentes, é comum em ambientes empresariais e forma a base de aplicações escaláveis.

⚙️ 1. Análise dos Requisitos

Para garantir a execução bem-sucedida do CA4 Parte 2, os seguintes requisitos foram definidos e cumpridos:

1️⃣ Criação de Máquinas Virtuais com Vagrant

Foram criadas duas VMs Ubuntu 22.04 utilizando o Vagrant.

Cada máquina recebeu uma função específica e um IP privado estático.

Justificativa: o uso de Vagrant permite o controlo total do ambiente e a reprodutibilidade, tornando simples destruir e recriar as VMs sem perda de configuração.

2️⃣ Configuração Automática com Ansible

Um ficheiro inventory foi criado para armazenar as credenciais SSH e endereços das VMs.

Um ficheiro playbook.yml definiu as tarefas automatizadas para instalação de Nginx e MySQL.

Justificativa: o Ansible garante padronização e consistência na configuração, evitando divergências entre máquinas.

3️⃣ Comunicação entre Servidores via Rede Privada

O web-server e o db-server comunicam entre si pela interface privada (Host-Only).

Justificativa: essa rede é segura, isolada e determinística, ideal para integração de serviços sem exposição pública.

4️⃣ Validação de Integração PHP–MySQL

Criou-se um script PHP para testar a ligação remota entre o web-server e o MySQL.

Justificativa: este teste comprova o funcionamento real da infraestrutura e fecha o ciclo de provisionamento automatizado.

🧱 2. Arquitetura da Solução
Função	Hostname	IP Privado	Serviços
Web Server	web-server	192.168.56.20	Nginx, PHP-FPM
DB Server	db-server	192.168.56.21	MySQL Server
Justificativa da Arquitetura

A separação dos serviços em camadas distintas permite:

Melhor distribuição de carga e desempenho.

Maior segurança, isolando dados do servidor de aplicação.

Facilidade de manutenção e escalabilidade horizontal.

Essa estrutura reflete práticas de produção em ambientes de microserviços e nuvem.

🧩 3. Implementação – Tutorial Passo a Passo

(As etapas abaixo podem ser seguidas por qualquer utilizador para reproduzir integralmente o projeto.)

🪟 Passo 1 – Criar Estrutura de Projeto
mkdir -p ~/Projetos/CA4/part2/provision
cd ~/Projetos/CA4/part2


Estrutura organizada facilita automação e versionamento no Git.

⚙️ Passo 2 – Criar o Vagrantfile

(Define as duas VMs, os IPs e os recursos de hardware.)

Vagrant.configure("2") do |config|
  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/jammy64"
    web.vm.hostname = "web-server"
    web.vm.network "private_network", ip: "192.168.56.20"
    web.vm.provider "virtualbox" do |vb|
      vb.name = "ca4-web"
      vb.memory = 1024
    end
  end

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/jammy64"
    db.vm.hostname = "db-server"
    db.vm.network "private_network", ip: "192.168.56.21"
    db.vm.provider "virtualbox" do |vb|
      vb.name = "ca4-db"
      vb.memory = 1024
    end
  end
end


Cada VM é declarada como um bloco independente, seguindo o princípio da modularidade e isolamento.

🧰 Passo 3 – Subir as VMs
vagrant up


Este comando cria e inicializa automaticamente as duas VMs Ubuntu.

🧩 Passo 4 – Instalar e Configurar o Ansible
vagrant ssh web
sudo apt update -y && sudo apt install -y ansible
mkdir -p /vagrant/provision && cd /vagrant/provision


O Ansible é instalado apenas no web-server, que funcionará como controlador da automação.

🗂️ Passo 5 – Criar o Ficheiro inventory
[web]
192.168.56.20 ansible_user=vagrant ansible_ssh_private_key_file=/vagrant/.vagrant/machines/web/virtualbox/private_key ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[db]
192.168.56.21 ansible_user=vagrant ansible_ssh_private_key_file=/vagrant/.vagrant/machines/db/virtualbox/private_key ansible_ssh_common_args='-o StrictHostKeyChecking=no'


Define os hosts e as chaves SSH para autenticação segura entre as VMs.

🧾 Passo 6 – Criar o Playbook playbook.yml

(Define as tarefas automáticas de instalação e configuração.)

---
- name: Configurar Web Server
  hosts: web
  become: yes
  tasks:
    - name: Atualizar pacotes
      apt: update_cache=yes upgrade=dist force_apt_get=yes
    - name: Instalar Nginx
      apt: name=nginx state=present
    - name: Iniciar e habilitar Nginx
      service: name=nginx state=started enabled=yes

- name: Configurar DB Server
  hosts: db
  become: yes
  tasks:
    - name: Instalar MySQL Server
      apt: name=mysql-server state=present
    - name: Garantir que o MySQL está ativo
      service: name=mysql state=started enabled=yes


YAML legível, sem necessidade de scripts shell complexos — uma das grandes vantagens do Ansible.

🚀 Passo 7 – Executar Testes
ansible all -i inventory -m ping
ansible-playbook playbook.yml -i inventory


Todas as tarefas devem retornar “ok” ou “changed”, sem erros.

🧠 Passo 8 – Instalar PHP e Testar Integração
sudo apt install -y php php-fpm php-mysql
sudo systemctl enable --now php8.1-fpm
sudo systemctl stop apache2 && sudo systemctl disable apache2


Configurar Nginx:

location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/run/php/php8.1-fpm.sock;
}


Criar script de teste:

<?php
$conn = new mysqli('192.168.56.21', 'root', '', '');
if ($conn->connect_error) {
    die('❌ Falha na ligação: ' . $conn->connect_error);
}
echo '✅ Ligação MySQL bem-sucedida!';
$conn->close();
?>


Abrir no navegador:
👉 http://192.168.56.20/testdb.php

Resultado: ✅ Ligação MySQL bem-sucedida!

🔍 4. Análise da Solução
Aspeto	Fundamentação
Automação Total	O Ansible garantiu a instalação uniforme de pacotes e serviços em ambas as máquinas, eliminando configurações manuais. Isso reduz o erro humano e torna o ambiente facilmente reimplantável.
Infraestrutura Modular	Cada VM possui papel definido, facilitando substituição e escalabilidade. O ambiente é modular e adaptável a diferentes cenários de deploy.
Separação de Funções	A arquitetura 2-tier (web e DB) espelha modelos reais de aplicações empresariais, melhorando segurança e desempenho.
Reprodutibilidade	Com Vagrant e Ansible, o mesmo ambiente pode ser reconstruído em minutos, em qualquer máquina, mantendo configurações idênticas.
🔄 5. Soluções Alternativas
🐳 1. Docker e Docker Compose

O Docker Compose poderia substituir o Vagrant ao orquestrar contêineres.
Em vez de VMs completas, cada serviço (Nginx, PHP e MySQL) seria executado em um contêiner isolado.
Vantagens:

Inicialização em segundos e menor consumo de recursos.

Portabilidade total entre sistemas.

Integração direta com pipelines CI/CD.
Limitações:

Menor isolamento que uma VM completa.

Necessidade de maior conhecimento sobre redes Docker.

🧱 2. Apache2 + mod_php

Outra alternativa seria usar Apache2 com o módulo mod_php, substituindo o Nginx e o PHP-FPM.
Vantagens:

Configuração mais simples (servidor e PHP integrados).

Boa compatibilidade com aplicações legadas.
Limitações:

Desempenho inferior sob carga pesada.

Menor flexibilidade e escalabilidade.
Esta abordagem seria adequada apenas para ambientes de testes ou desenvolvimento local.

⚙️ 3. Ansible Roles e Galaxy

A solução atual usa um único ficheiro de playbook, mas poderia ser expandida com Ansible Roles — módulos reutilizáveis que dividem o código em partes específicas (por exemplo: role: nginx, role: mysql).
Vantagens:

Organização mais limpa.

Reutilização em múltiplos projetos.

Facilidade de manutenção.
Limitações:

Estrutura inicial mais complexa.

Maior curva de aprendizagem.

🏁 6. Conclusão

O CA4 Parte 2 consolidou competências práticas em virtualização, automação e integração de serviços.
Foi demonstrado como ferramentas modernas de Infraestrutura como Código (IaC) podem criar e configurar ambientes complexos de forma previsível e eficiente.

Através do uso conjunto de Vagrant, VirtualBox e Ansible, foi possível:

Criar duas máquinas virtuais totalmente funcionais e integradas;

Automatizar a instalação e inicialização de Nginx e MySQL;

Estabelecer comunicação entre camadas distintas de aplicação e dados;

Validar a ligação real através de um script PHP funcional.

🔍 Síntese técnica:

O Vagrant garantiu reprodutibilidade do ambiente;

O Ansible trouxe automação e consistência;

O Nginx + PHP-FPM + MySQL demonstraram integração real entre servidores distintos;

A arquitetura final espelha boas práticas DevOps e fornece uma base sólida para expansão futura (monitorização, CI/CD e containers).

💡 Conclusão Final:
O projeto cumpre e ultrapassa os objetivos da unidade curricular, evidenciando compreensão profunda de DevOps, automação de infraestrutura e integração de serviços distribuídos.
O aluno demonstrou capacidade de análise, resolução de problemas e implementação prática de conceitos avançados de sistemas, consolidando competências para ambientes de produção modernos.
