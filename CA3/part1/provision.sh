#!/bin/bash
# ==========================================================
# 🧰 Provisionamento CA3 - Parte 1
# Instala pacotes essenciais + Git + Java 25 + Maven + Gradle
# ==========================================================

set -e
echo "🚀 Iniciando provisionamento da VM CA3 - Parte 1..."

# Atualizar pacotes
sudo apt-get update -y && sudo apt-get upgrade -y

# Adicionar repositório com Java 25 (Azul Zulu)
echo "🔧 Adicionando repositório Azul Zulu para OpenJDK 25..."
sudo apt-get install -y gnupg ca-certificates
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repos.azul.com/azul-repo.key | sudo tee /etc/apt/keyrings/azul.asc
echo "deb [signed-by=/etc/apt/keyrings/azul.asc] https://repos.azul.com/zulu/deb stable main" | sudo tee /etc/apt/sources.list.d/zulu.list

sudo apt-get update -y
sudo apt-get install -y zulu25-jdk

# Instalar outras ferramentas
sudo apt-get install -y git maven gradle

# Mostrar versões instaladas
echo "✅ Ferramentas instaladas:"
git --version
java -version
mvn -version
gradle -version

# Criar diretório de projetos
mkdir -p /home/vagrant/projects
cd /home/vagrant/projects

# Clonar projetos do CA2
echo "📦 Clonando projetos..."
if [ ! -d "spring-petclinic" ]; then
  git clone https://github.com/spring-projects/spring-petclinic.git
fi
if [ ! -d "gradle-build-scan-quickstart" ]; then
  git clone https://github.com/gradle/gradle-build-scan-quickstart.git
fi

# Compilar Spring PetClinic
echo "⚙️ Compilando projeto Spring PetClinic..."
cd spring-petclinic
./mvnw test || echo "⚠️ Aviso: build Maven falhou — verificar logs."
cd ..

# Compilar projeto Gradle
echo "⚙️ Executando Gradle build..."
cd gradle-build-scan-quickstart
gradle build || echo "⚠️ Aviso: build Gradle falhou — verificar logs."

echo "🎉 Provisionamento concluído com sucesso!"

