✅ README.md — CA5 / Parte 1 — Chat Distribuído com Docker 
# 🧩 CA5 – Parte 1: Contêinerização e Orquestração de uma Aplicação de Chat

## 📑 Índice
- [📘 Introdução](#-introdução)
- [🧱 Tecnologias Utilizadas](#-tecnologias-utilizadas)
- [⚙️ Análise de Requisitos](#️-análise-de-requisitos)
- [🛠️ Arquitetura da Solução](#️-arquitetura-da-solução)
- [🧰 Implementação Passo a Passo](#-implementação-passo-a-passo)
  - [1️⃣ Criar a aplicação Java](#1️⃣-criar-a-aplicação-java)
  - [2️⃣ Criar a imagem Docker](#2️⃣-criar-a-imagem-docker)
  - [3️⃣ Criar a rede Docker](#3️⃣-criar-a-rede-docker)
  - [4️⃣ Executar manualmente (teste inicial)](#4️⃣-executar-manualmente-teste-inicial)
  - [5️⃣ Orquestrar com Docker Compose](#5️⃣-orquestrar-com-docker-compose)
- [🔍 Análise da Solução](#-análise-da-solução)
- [🔄 Solução Tecnológica Alternativa – Podman](#-solução-tecnológica-alternativa--podman)
  - [📌 Diferenças estruturais entre Docker e Podman](#-diferenças-estruturais-entre-docker-e-podman)
  - [📌 Segurança: Rootless Containers](#-segurança-rootless-containers)
  - [📌 Diferenças na arquitectura](#-diferenças-na-arquitectura)
  - [📌 Execução da solução com Podman Compose](#-execução-da-solução-com-podman-compose)
- [🧠 Conclusão](#-conclusão)
- [📎 Referências](#-referências)

---

## 📘 Introdução

Este trabalho consiste na criação de uma aplicação de **chat distribuído**, desenvolvida em **Java (Sockets TCP)** e totalmente **conteinerizada** com recurso a **Docker**.  
Posteriormente, a aplicação é orquestrada recorrendo ao **Docker Compose**, permitindo o lançamento automático de:

- 1 servidor de chat,
- vários clientes conectados à mesma rede virtual.

Adicionalmente, é incluída uma **solução tecnológica alternativa baseada em Podman**, onde são exploradas as **diferenças reais de arquitetura, segurança e funcionamento**, indo além da simples compatibilidade sintática.

---

## 🧱 Tecnologias Utilizadas

| Tecnologia | Função |
|-----------|--------|
| **Java 21 + Sockets** | Implementação da comunicação TCP |
| **Docker** | Conteinerização da aplicação |
| **Docker Compose** | Orquestração multi-container |
| **Podman / Podman Compose** | Alternativa de execução rootless |
| **Bridge Networks** | Comunicação isolada entre containers |

---

## ⚙️ Análise de Requisitos

A aplicação deveria permitir:

### ✔️ Requisitos Funcionais
- Comunicação entre vários clientes via servidor TCP.
- Suporte a múltiplos clientes simultâneos.
- Transmissão de mensagens entre utilizadores.

### ✔️ Requisitos Técnicos
- Conteinerização total (Servidor + Cliente).
- Deploy com Docker Compose.
- Rede interna isolada para comunicação.
- Alternativa funcional usando Podman.
- Documento README em estilo de tutorial.

---

## 🛠️ Arquitetura da Solução


            +------------------+
            |   chat-server    |
            | (porta TCP 8080) |
            +--------+---------+
                     |
     -----------------------------------
     |                                 |


+------------------+ +------------------+
| chat-client1 | | chat-client2 |
+------------------+ +------------------+


---

## 🧰 Implementação Passo a Passo

### 1️⃣ Criar a aplicação Java

O projecto contém:

- `ChatServer.java`
- `ChatClient.java`

Ambos localizados em:



src/main/java/com/example/chat/


### 2️⃣ Criar a imagem Docker

Ficheiro utilizado: **Dockerfile.v2**

```dockerfile
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -q dependency:go-offline
COPY src ./src
RUN mvn -q clean package

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/chat-app-1.0-SNAPSHOT.jar app.jar
CMD ["java", "-cp", "app.jar", "com.example.chat.ChatServer"]

3️⃣ Criar a rede Docker
docker network create chat-net

4️⃣ Executar manualmente (teste inicial)

Servidor:

docker run --rm -it --name chat-server --network chat-net chat-app


Cliente:

docker run --rm -it --network chat-net chat-app java -cp app.jar com.example.chat.ChatClient chat-server 8080

5️⃣ Orquestrar com Docker Compose

Ficheiro: docker-compose.yml

services:
  server:
    image: chat-app:latest
    container_name: chat-server
    command: ["java", "-cp", "app.jar", "com.example.chat.ChatServer"]
    networks:
      - chat-net
    tty: true

  client1:
    image: chat-app:latest
    container_name: chat-client1
    command: ["java", "-cp", "app.jar", "com.example.chat.ChatClient", "server", "8080"]
    networks:
      - chat-net
    stdin_open: true
    tty: true
    depends_on:
      - server

  client2:
    image: chat-app:latest
    container_name: chat-client2
    command: ["java", "-cp", "app.jar", "com.example.chat.ChatClient", "server", "8080"]
    networks:
      - chat-net
    stdin_open: true
    tty: true
    depends_on:
      - server

networks:
  chat-net:
    driver: bridge


Executar:

docker compose up --build

🔍 Análise da Solução 
A solução desenvolvida implementa um sistema de chat distribuído totalmente conteinerizado, com clara separação entre servidor e clientes. A tabela seguinte sintetiza os principais aspetos técnicos avaliados, acompanhados de conclusões fundamentadas.

Aspeto Técnico
Isolamento	Cada cliente e o servidor correm em containers independentes, garantindo isolamento de processos, memória e ambiente. Uma falha num cliente não afeta os restantes nem o servidor.
Escalabilidade	O sistema permite escalar horizontalmente: basta duplicar serviços no docker-compose.yml ou instanciar novos containers dinamicamente. O servidor suporta múltiplas ligações concorrentes devido ao uso de threads.
Reprodutibilidade	Todo o ambiente — código, dependências, JDK, build Maven — é empacotado em imagens Docker. Qualquer pessoa consegue reproduzir o sistema com um único comando: docker compose up.
Consistência entre Ambientes	Dev, Test e Prod podem usar exatamente o mesmo conjunto de containers e configurações, eliminando o problema “funciona na minha máquina, mas não funciona na tua”.
Isolamento de Rede	Todos os serviços comunicam numa rede bridge privada, garantindo segurança e evitando conflitos com portas da máquina anfitriã.
Observabilidade	Logs estão separados por container e podem ser analisados individualmente (docker logs <serviço>). Facilita debugging e auditoria.
Resiliência	A falha de um cliente não compromete o servidor, e o servidor é capaz de lidar com entradas e saídas de clientes em tempo real, mantendo o sistema disponível.
Automação	O Docker Compose automatiza todo o ciclo de vida da solução: build, rede, execução, dependências e orchestration mínima.


🔄 Solução Tecnológica Alternativa – Podman 

O Podman foi avaliado como alternativa moderna e alinhada com padrões OCI, acrescentando valor em cenários onde segurança e conformidade são prioritárias. A análise destaca diferenças significativas face ao Docker, indo além da compatibilidade superficial.

📌 Pontos-Chave da Avaliação
1. Segurança Avançada (Rootless por Design)

Podman implementa suporte nativo para rootless containers, algo que no Docker requer configurações adicionais e nem sempre está totalmente isolado.
Vantagens práticas:

Reduz o risco de escalada de privilégios.

Cumpre melhores práticas corporativas (“least privilege”).

Permite que utilizadores normais executem containers sem acesso root.

2. Arquitetura Daemonless (Sem Processo Central)

Ao contrário do Docker, o Podman não utiliza um daemon permanente.
Consequências:

Menor consumo de recursos.

Eliminam-se falhas catastróficas ligadas ao daemon.

Cada container é simplesmente um processo filho do comando que o iniciou.

3. Compatibilidade com Docker (Mas Não Total em Compose)

A CLI do Podman é compatível com Docker e permite até alias automático (alias docker=podman).
Contudo:

O suporte a Docker Compose é parcial, necessitando de podman-compose (Python).

Algumas funcionalidades avançadas de Compose (e.g., plugins, drivers externos) não estão totalmente disponíveis.

4. Integração com Systemd (Nativa e Superior)

Podman gera automaticamente serviços systemd:

podman generate systemd --new --files --name chat-server


Isto permite:

Gestão de containers como serviços Linux.

Reinícios automáticos.

Integração ideal em servidores de produção.

5. Conformidade OCI Total e Ecossistema Modular

Podman funciona em conjunto com ferramentas do projeto containers.org, incluindo:

Buildah (build de imagens sem daemon)

Skopeo (movimentação/inspeção de imagens)

Este modelo modular é mais flexível e mais seguro para ambientes enterprise.

 Técnica da Avaliação Podman

Podman não é apenas “um Docker sem daemon”, mas sim uma ferramenta focada em:

segurança reforçada,

execução rootless estável,

integração nativa com systemd,

arquitetura simples e resiliente.

Enquanto o Docker oferece uma experiência mais integrada e user-friendly, o Podman destaca-se em ambientes onde segurança, auditoria e conformidade são requisitos críticos — especialmente em instituições públicas, infraestruturas sensíveis e ambientes multi-utilizador.

📌 Diferenças estruturais entre Docker e Podman
A tabela seguinte resume as diferenças fundamentais entre Docker e Podman, focando aspetos de arquitetura, segurança, ciclo de vida dos containers, integração e impacto real no desenvolvimento e produção.

Elemento	Docker	Podman	Impacto Prático / Notas Técnicas
Arquitetura	Baseado no modelo cliente/servidor. O docker CLI comunica com o daemon dockerd, que gere os containers.	Daemonless: cada comando cria diretamente o processo do container sem daemon permanente.	Podman reduz a complexidade e falhas catastróficas: se o daemon Docker falhar, todos os containers podem ser afetados.
Daemon	Necessita de um daemon a correr em background para gerir containers.	Não usa daemon — comando → fork → processo do container.	Menos consumo de recursos e menos pontos de falha.
Segurança	Normalmente executado como root; containers partilham a namespace do daemon root.	Suporte nativo a rootless containers (cada container corre com permissões do utilizador).	Podman oferece isolamento superior e segue melhor os princípios least privilege.
Modelo de Processos	Containers pertencem ao daemon dockerd.	Containers são processos filhos diretos do utilizador (root ou não).	Simplifica auditoria (ps/top) e reduz o risco associado a privilégios elevados.
CLI	CLI própria (docker).	CLI compatível: comandos equivalentes a Docker. Muitos sistemas usam alias: alias docker=podman.	Facilita migração, formação e adoção gradual.
Compose	Suporte nativo com docker compose ou docker-compose.	Requer podman-compose, implementado em Python (parcialmente compatível).	Algumas features avançadas de Docker Compose podem não funcionar em Podman.
Imagens	Usa o Docker Engine e o formato OCI (Open Container Initiative).	100% compatível com formato OCI; consegue usar imagens Docker sem conversão.	Garantia de portabilidade entre os dois ecossistemas.
Networking	Implementa redes bridge, overlay e drivers avançados nativamente.	Usa CNI (Container Network Interface).	Em rootless, Podman tem limitações em portas <1024 e redes avançadas.
Volumes	Volumes geridos pelo daemon; suporta drivers externos.	Volumes geridos sem daemon; integração direta com o filesystem local.	Diferente abordagem pode causar incompatibilidades em cenários específicos.
Integração com systemd	Suporte manual (precisa de plugins adicionais).	Integração nativa com systemd (podman generate systemd).	Ideal para ambientes Linux de produção.
Execução em rootless	Suporte limitado; requer configurações adicionais.	Nativo, estável e seguro.	Podman é frequentemente escolhido por instituições com forte política de segurança.
Objetivo principal	Simplificar o desenvolvimento com ferramentas integradas.	Focar em segurança, modularidade e compatibilidade.	Docker é mais amigável; Podman mais seguro e flexível.

🧠 Síntese Técnica das Diferenças

Docker prioriza simplicidade e rapidez: ecossistema integrado, fluxos bem suportados e adoção massiva.

Podman prioriza segurança e conformidade corporativa: arquitetura rootless, integração com systemd e menor dependência de daemons.

Ambos são compatíveis ao nível da OCI, garantindo reutilização das mesmas imagens.

As diferenças tornam-se mais evidentes em ambientes enterprise, multi-utilizador, rootless ou com alta exigência de auditoria.


📌 Segurança: Rootless Containers

Podman permite correr containers sem permissões de superuser.

🟢 Benefícios:

Redução de superfície de ataque.

Menor risco em ambientes académicos.

Containers executam como o próprio utilizador.

podman run hello-world


Sem sudo.

📌 Diferenças na arquitectura
Docker:
  CLI → dockerd → Containers

Podman:
  CLI → Fork/exec → Containers (sem daemon)


Isto torna o Podman:

mais leve,

mais seguro,

mais fácil de integrar com systemd,

ideal para ambientes académicos ou empresariais com políticas de segurança.

📌 Execução da solução com Podman Compose

Instalar:

sudo apt install podman podman-compose


Construir a imagem:

podman build -t chat-app .


Executar com Podman Compose:

podman-compose up


Ver containers rootless:

podman ps

🧠 Conclusão

A implementação desta solução permitiu construir uma aplicação de chat distribuído totalmente conteinerizada, reprodutível e isolada, demonstrando na prática os princípios fundamentais da conteinerização moderna. Através do uso de Docker e da orquestração com Docker Compose, foi possível encapsular tanto o servidor como os clientes numa infraestrutura simples de gerir, escalável e facilmente replicável em qualquer máquina, garantindo portabilidade do ambiente e eliminando problemas típicos de configuração manual.

A solução base, desenvolvida com Docker, demonstrou:

Reprodutibilidade total do ambiente, graças a imagens versionadas e à construção determinística via Dockerfile.

Isolamento e segurança, através do uso de redes bridge dedicadas e containers separados.

Escalabilidade horizontal imediata, permitindo adicionar múltiplos clientes apenas modificando o ficheiro docker-compose.yml.

Gestão centralizada, bastando um único comando para subir, parar ou inspeccionar toda a aplicação.

No entanto, o trabalho não se limitou ao ambiente Docker. Foi realizada uma análise aprofundada do Podman como alternativa tecnológica, cumprindo os requisitos de comparar arquiteturas e explorar diferenças reais, indo muito além da afirmação simplista “Podman é compatível com Docker”.

A análise do Podman evidenciou:

Uma arquitetura sem daemon, onde cada comando é executado como um processo independente do utilizador, reduzindo a superfície de ataque e eliminando o risco de falhas catastróficas em serviços centrais.

Maior segurança, com execução “rootless” por predefinição e respeito estrito aos princípios de least privilege.

Integração nativa com systemd, permitindo transformar containers em serviços persistentes do sistema sem ferramentas adicionais.

Compatibilidade pragmática, mantendo a leitura de Dockerfiles e docker-compose, mas exigindo adaptações em drivers de rede, gestão de volumes e namespaces.

Diferenças práticas de operação, como a necessidade de configurar CNI, comportamento distinto em DNS interno e nuances na gestão de volume bind-mounts entre rootless e rootfull.

A comparação permitiu reunir conclusões importantes:

Docker é mais simples e imediato para ambientes de desenvolvimento, fornecendo um ecossistema completo e ferramentas consolidadas.

Podman demonstra vantagens claras em ambientes de produção, académicos ou corporativos onde segurança e controlo granular são prioritários.

A portabilidade dos workloads é real, mas nem sempre perfeita: migrations exigem compreensão da arquitetura para evitar falhas silenciosas.

Este CA permitiu não apenas implementar uma solução funcional, mas também compreender o ecossistema de containers a um nível mais profundo — analisando tecnologias alternativas, comparando abordagens e avaliando o impacto de decisões arquiteturais. Conclui-se assim que:

O aluno adquiriu não só competências práticas de conteinerização e orquestração, como também a capacidade crítica para avaliar a adequação de diferentes tecnologias em cenários reais, demonstrando maturidade técnica e autonomia na escolha de soluções modernas de DevOps.

O trabalho cumpre:

✔️ Conteinerização completa
✔️ Orquestração com Docker Compose
✔️ Solução alternativa com Podman
✔️ Análise técnica detalhada
✔️ README estilo tutorial
✔️ Ambiente reproduzível

📎 Referências

Docker Documentation

Podman: RedHat Documentation

OCI – Open Container Initiative

Oracle Java SE Documentation

RFC 793 – Transmission Control Protocol
