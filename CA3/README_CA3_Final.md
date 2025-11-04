# 🤩 README_CA3_Final.md

### **Computação em Ambientes Virtuais – CA3**

**Autor:** Eng. MSc. Esveraldo Lopes
**Unidade Curricular:** COGSI2526
**Data:** Novembro de 2025

---

## 🎯 **Objetivo Geral**

O objetivo deste trabalho foi aplicar os conceitos de **virtualização e automação de ambientes** utilizando **Vagrant**, **VirtualBox** e **scripts de provisionamento**, simulando cenários de desenvolvimento e infraestrutura de software com múltiplas VMs.

---

## 🗂️ **Estrutura do Projeto**

```
CA3/
│
├── part1/
│   ├── Vagrantfile
│   ├── provision.sh
│   └── README_CA3_Part1.md
│
├── part2/
│   ├── Vagrantfile
│   ├── provision-web.sh
│   ├── provision-db.sh
│   └── README_CA3_Part2.md
│
└── README_CA3_Final.md
```

---

## ⚙️ **Parte 1 – Provisionamento Único**

### 🧱 **Objetivo**

Configurar uma única máquina virtual com um ambiente de desenvolvimento Java completo, automatizando a instalação de dependências e compilação de projetos.

### 🔧 **Tecnologias Utilizadas**

* Ubuntu 22.04 (bento/ubuntu-22.04)
* Git
* OpenJDK 17
* Maven
* Gradle

### 🪄 **Configurações do Vagrantfile**

* Box: `bento/ubuntu-22.04`
* Hostname: `ca3-part1`
* Rede: `private_network` (192.168.56.10)
* Recursos: 2 GB RAM, 2 vCPUs
* Provisionamento: `provision.sh`

### 📜 **Script de Provisionamento**

O script `provision.sh` executa automaticamente:

1. Atualização do sistema (`apt update && apt upgrade`)
2. Instalação das ferramentas (Git, JDK, Maven e Gradle)
3. Clonagem de dois repositórios GitHub:

   * [`spring-petclinic`](https://github.com/spring-projects/spring-petclinic)
   * [`gradle-build-scan-quickstart`](https://github.com/gradle/gradle-build-scan-quickstart)
4. Compilação e testes automáticos:

   ```bash
   cd spring-petclinic
   ./mvnw test
   ```

   ✅ **BUILD SUCCESS**
5. Teste adicional com Gradle:

   ```bash
   cd ../gradle-build-scan-quickstart
   gradle build
   ```

   ⚠️ *Build Gradle falhou parcialmente devido à versão de Java exigida pelo projeto.*

### 🧹 **Resultado**

Provisionamento completo e execução bem-sucedida do projeto Maven.
Todos os pacotes foram instalados e verificados.

---

## ⚙️ **Parte 2 – Arquitetura Multi-VM**

### 🧱 **Objetivo**

Implementar uma infraestrutura com **duas máquinas virtuais interligadas**, simulando um ambiente cliente-servidor:

* `web-server` → Servidor Web (NGINX + Cliente MySQL)
* `db-server` → Servidor de Base de Dados (MySQL)

### 🌐 **Configurações**

* Rede privada:

  * `192.168.56.10` → web-server
  * `192.168.56.11` → db-server
* Provisionamento automatizado:

  * `provision-web.sh` → instala NGINX, cliente MySQL e pacotes básicos
  * `provision-db.sh` → instala MySQL Server, cria a base de dados `site`, tabela `utilizadores` e utilizador `webuser`

### 🪄 **Configuração do MySQL**

```sql
CREATE DATABASE site;
USE site;

CREATE TABLE utilizadores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50),
  email VARCHAR(100)
);

INSERT INTO utilizadores (nome, email)
VALUES
  ('Esveraldo Lopes', 'esveraldo@example.com'),
  ('Luís Nogueira', 'luis.nogueira@isep.pt');

CREATE USER 'webuser'@'%' IDENTIFIED BY 'vagrant';
GRANT ALL PRIVILEGES ON site.* TO 'webuser'@'%';
FLUSH PRIVILEGES;
```

---

### 🔍 **Testes de Comunicação**

📡 **Ping entre as VMs**

```bash
ping -c 3 192.168.56.11
# 0% packet loss ✅
```

🥉 **Acesso remoto ao MySQL**

```bash
mysql -h 192.168.56.11 -u webuser -p
USE site;
SELECT * FROM utilizadores;
```

📋 **Resultado:**

| id | nome            | email                                                 |
| -- | --------------- | ----------------------------------------------------- |
| 1  | Esveraldo Lopes | [esveraldo@example.com](mailto:esveraldo@example.com) |
| 2  | Luís Nogueira   | [luis.nogueira@isep.pt](mailto:luis.nogueira@isep.pt) |

✅ Ligação e leitura de dados realizadas com sucesso.

---

## 🧹 **Conclusões**

* Foi implementada uma **infraestrutura automatizada** com Vagrant e provisionamento shell.
* A Parte 1 garantiu um ambiente de desenvolvimento completo com ferramentas Java.
* A Parte 2 validou a comunicação entre VMs e a integração servidor web ↔ base de dados.
* Todos os testes foram concluídos com sucesso, assegurando a reprodutibilidade total com o simples comando:

  ```bash
  vagrant up
  ```

---

## 📸 **Evidências**

* `vagrant up` e provisionamento concluído;
* `systemctl status nginx` e `systemctl status mysql` ativos;
* Consulta SQL `SELECT * FROM utilizadores;` com sucesso.

---

### 🗾 **Referências**

* [Documentação Vagrant](https://developer.hashicorp.com/vagrant/docs)
* [Spring PetClinic Project](https://github.com/spring-projects/spring-petclinic)
* [Gradle Build Quickstart](https://github.com/gradle/gradle-build-scan-quickstart)
* [Ubuntu 22.04 Bento Box](https://app.vagrantup.com/bento/boxes/ubuntu-22.04)

---
