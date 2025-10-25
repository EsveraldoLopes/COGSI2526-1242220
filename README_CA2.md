# ⚙️ Tutorial – CA2 (Build Tools com Gradle)

### 🎓 Unidade Curricular
**Configuração e Gestão de Sistemas (COGSI)**  
**Professor:** Luís Nogueira  
**Estudante:** Esveraldo Lopes  
**Ano Letivo:** 2025/2026  
**Instituição:** ISEP – Instituto Superior de Engenharia do Porto  

---

## 1️⃣ Objetivo

Implementar e compreender o uso do **Gradle Build Tool**, criando **tarefas personalizadas** para:
- Compilar e gerar o ficheiro JAR do projeto;
- Criar **backups automáticos** dos ficheiros fonte;
- Compactar o backup num ficheiro **ZIP**.

---

## 2️⃣ Ferramentas Utilizadas

| Ferramenta | Função | Versão |
|-------------|--------|---------|
| Gradle | Ferramenta de build | 9.1.0 |
| Java | Linguagem base | 21 |
| Git Bash | Terminal de execução | Windows 11 |
| VS Code | Editor de código | Atual |
| JDK | Compilação e execução | Oracle JDK 21 |

---

## 3️⃣ Estrutura Inicial do Projeto

Após executar `gradle init`, o projeto foi inicializado com a seguinte estrutura:

```bash
part1/
├── app/
│   ├── src/
│   │   ├── main/java/org/example/App.java
│   │   └── test/java/org/example/AppTest.java
│   ├── build.gradle
├── settings.gradle
└── build.gradle
```
---

## 4️⃣ Implementação das Tarefas Personalizadas

As seguintes tarefas foram definidas no ficheiro build.gradle do projeto principal.


```bash
// // 1️⃣ Tarefa para compilar e gerar o JAR
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
---

## 5️⃣ Explicação das Tarefas


| Tarefa | Tipo | Função | Output |
|--------|------|--------|--------|
| `buildApp` | Execução | Compila o projeto e gera o ficheiro `.jar` | `build/libs/` |
| `backupSources` | Cópia | Cria uma cópia dos ficheiros fonte | `backup/` |
| `zipBackup` | Compressão | Cria um ficheiro ZIP do backup | `build/distributions/backup.zip` |

---

## 6️⃣ Execução das Tarefas no Terminal

#### 1️⃣ Compilar o projeto e gerar o `.jar`
```bash
./gradlew buildApp
```

```bash
./gradlew backupSources

```

```bash
./gradlew zipBackup
```

```bash
ls backup
```

```bash
ls build/distributions
```

```bash
├── main/
│   └── java/org/example/App.java

build/distributions/
└── backup.zip
```

---

## 7️⃣ Conclusões e Referências

### 🧩 Conclusões

Com este trabalho prático (**CA2 – Build Tools com Gradle**), foi possível:

- Explorar o uso do **Gradle** como ferramenta moderna de *build automation*;  
- Criar e executar **tarefas personalizadas** (compilar, fazer *backup* e comprimir código-fonte);  
- Compreender a diferença entre **tarefas padrão** e **tarefas definidas pelo utilizador**;  
- Utilizar corretamente a **estrutura de diretórios e ficheiros** (`src/`, `build/`, `backup/`);  
- Consolidar boas práticas de documentação e automatização de processos em projetos Java.

Este exercício reforçou a importância de ferramentas de automação na integração contínua e gestão eficiente de projetos.

---

### 📚 Referências

- [Documentação oficial do Gradle](https://docs.gradle.org)  
- [Guia rápido de Gradle para Java](https://docs.gradle.org/current/userguide/building_java_projects.html)  
- [Plugin `application` no Gradle](https://docs.gradle.org/current/userguide/application_plugin.html)  
- [Guia de tarefas personalizadas no Gradle](https://docs.gradle.org/current/userguide/more_about_tasks.html)  

---

📅 **Data:** 25/10/2025  
✍️ **Autor:** *Esveraldo Lopes*  
🏛️ **Instituição:** *ISEP – Instituto Superior de Engenharia do Porto*


