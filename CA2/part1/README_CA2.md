⚙️ Tutorial – CA2 (Build Tools com Gradle)
🎓 Unidade Curricular

Configuração e Gestão de Sistemas (COGSI)
Professor: Luís Nogueira
Estudante: Esveraldo Lopes
Ano Letivo: 2025/2026
Instituição: ISEP – Instituto Superior de Engenharia do Porto

🧭 Índice

1️⃣ Objetivo

2️⃣ Ferramentas Utilizadas

3️⃣ Estrutura Inicial do Projeto

4️⃣ Implementação das Tarefas Personalizadas

5️⃣ Explicação das Tarefas

6️⃣ Execução das Tarefas no Terminal

7️⃣ Parte 2 – Relatório de Dependências com Gradle

8️⃣ Conclusões e Referências

1️⃣ Objetivo

Aplicar o uso da ferramenta Gradle Build Tool para automatizar tarefas de build, backup e relatórios, consolidando práticas modernas de integração contínua.

2️⃣ Ferramentas Utilizadas
Ferramenta	Função	Versão
Gradle	Ferramenta de build	9.1.0
Java	Linguagem base	21
Git Bash	Terminal de execução	Windows 11
VS Code	Editor de código	Atual
JDK	Compilação e execução	Oracle JDK 21
3️⃣ Estrutura Inicial do Projeto

Após executar o comando gradle init, o projeto foi criado com a seguinte estrutura:

part1/
├── app/
│   ├── src/
│   │   ├── main/java/org/example/App.java
│   │   └── test/java/org/example/AppTest.java
│   ├── build.gradle
├── settings.gradle
└── build.gradle

4️⃣ Implementação das Tarefas Personalizadas

As seguintes tarefas foram definidas no ficheiro build.gradle do projeto principal:

// 1️⃣ Tarefa para compilar e gerar o JAR
tasks.register('buildApp') {
    group = 'CA2'
    description = 'Compila o projeto e gera o ficheiro JAR.'
    dependsOn 'build'
}

// 2️⃣ Tarefa para criar backup das fontes
tasks.register('backupSources', Copy) {
    group = 'CA2'
    description = 'Cria uma cópia dos ficheiros fonte em backup/'
    from 'src'
    into layout.projectDirectory.dir('backup')
}

// 3️⃣ Tarefa para comprimir o backup num ficheiro zip
tasks.register('zipBackup', Zip) {
    group = 'CA2'
    description = 'Compacta a pasta backup num ficheiro zip.'
    from layout.projectDirectory.dir('backup')
    archiveFileName = 'backup.zip'
    destinationDirectory = layout.buildDirectory.dir('distributions')
}

5️⃣ Explicação das Tarefas
Tarefa	Tipo	Função	Output
buildApp	Execução	Compila o projeto e gera o ficheiro .jar	build/libs/
backupSources	Cópia	Cria uma cópia dos ficheiros fonte	backup/
zipBackup	Compressão	Cria um ficheiro ZIP do backup	build/distributions/backup.zip

6️⃣ Execução das Tarefas no Terminal

As tarefas foram executadas sequencialmente no terminal:

./gradlew buildApp
./gradlew backupSources
./gradlew zipBackup
ls backup
ls build/distributions


✅ Resultados obtidos:

backup/
├── main/
│   └── java/org/example/App.java

build/distributions/
└── backup.zip

7️⃣ Parte 2 – Relatório de Dependências com Gradle

Nesta segunda parte, foi adicionada uma tarefa personalizada para gerar automaticamente um relatório de dependências do projeto.

📄 Código da Tarefa
tasks.register('dependencyReport') {
    group = 'CA2'
    description = 'Gera um relatório com todas as dependências do projeto.'

    def dependenciesProvider = providers.provider {
        configurations.compileClasspath.resolvedConfiguration.resolvedArtifacts.collect { dep ->
            "${dep.moduleVersion.id.group}:${dep.name}:${dep.moduleVersion.id.version}"
        }
    }

    def reportFileProvider = project.layout.buildDirectory.file("reports/dependencies.txt")

    doLast {
        def reportFile = reportFileProvider.get().asFile
        reportFile.parentFile.mkdirs()
        reportFile.text = ''
        dependenciesProvider.get().each { line ->
            reportFile << line + "\n"
        }
        println "📄 Relatório de dependências criado em: ${reportFile.absolutePath}"
    }
}

🧪 Execução e Resultado

Comando utilizado:

./gradlew dependencyReport


📘 Resultado esperado:

📄 Relatório de dependências criado em:
C:\Users\EngMScEsveraldoLopes\Documents\Projetos\COGSI2526-1242220\CA2\part1\build\reports\dependencies.txt

BUILD SUCCESSFUL in 1s


📂 Conteúdo do ficheiro dependencies.txt:

org.junit.jupiter:junit-jupiter:5.10.0
com.google.code.gson:gson:2.10.1

8️⃣ Conclusões e Referências
🧩 Conclusões

O trabalho CA2 permitiu compreender a flexibilidade do Gradle na automação de processos, bem como:

Criar e gerir tarefas personalizadas;

Integrar scripts para backup, compressão e relatórios automáticos;

Aplicar boas práticas de build automation num contexto real;

Compreender as diferenças entre tarefas padrão e customizadas.

📚 Referências

Documentação oficial do Gradle

Guia rápido de Gradle para Java

Plugin application no Gradle

Guia de tarefas personalizadas no Gradle

📅 Data: 25/10/2025
✍️ Autor: Esveraldo Lopes
🏛️ Instituição: ISEP – Instituto Superior de Engenharia do Porto
