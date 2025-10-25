# 🧾 Tutorial – CA1 (Version Control com Git e GitHub)

### 🎓 Unidade Curricular
**Configuração e Gestão de Sistemas (COGSI)**  
**Professor:** Luís Nogueira  
**Estudante:** Esveraldo Lopes  
**Ano Letivo:** 2025/2026  
**Instituição:** Universidade Lusófona do Porto  

---
## 1️⃣ Objetivo
Aplicar o **controlo de versões** com **Git** e **GitHub**, usando boas práticas: criação de branches, commits descritivos, tags e histórico.  
O projeto base usado foi o **Spring PetClinic**.

---

## 2️⃣ Ferramentas Utilizadas
| Ferramenta | Função | Versão/Notas |
|---|---|---|
| Git | Controlo de versões | 2.47.0 |
| GitHub | Repositório remoto | — |
| Git Bash | Terminal | Windows 11 |
| VS Code | Editor | Atual |
| Maven | Build tool do projeto base | 3.9.x |
| Java | Linguagem do projeto | 17+ |

---

---

## 3️⃣ Estrutura Inicial (Spring PetClinic)

A estrutura inicial do projeto foi baseada no código original do **Spring PetClinic**, que serviu como ponto de partida para as modificações realizadas durante o CA1.

```bash
spring-framework-petclinic/
├── src/main/java/org/springframework/samples/petclinic/model/Vet.java
├── src/main/webapp/WEB-INF/jsp/vets/
│   ├── createOrUpdateVetForm.jsp
│   └── vetList.jsp
├── pom.xml
└── README.md
```
---
## 4️⃣ Desenvolvimento – Passo a Passo

Nesta secção são descritos, de forma sequencial e explicativa, todos os passos realizados para aplicar o **controlo de versões com Git e GitHub** no contexto do projeto **Spring PetClinic**.

---
### 🔹 Passo 1 – Clonar o repositório base

Primeiro, o projeto PetClinic foi clonado a partir do repositório GitHub:

```bash
git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic

```

---

### 🔹 Passo 2 – Criação do repositório do aluno (CA1)

Depois de explorar o código original, foi criado o repositório **pessoal no GitHub** com o nome  
`COGSI2526-1242220`, para alojar todas as tarefas práticas da unidade curricular.

Primeiro, foi removido o *remote* original (do projeto PetClinic) e associado o novo repositório do aluno:

```bash
git remote remove origin
git remote add origin https://github.com/EsveraldoLopes/COGSI2526-1242220.git
git push -u origin main
```
---

### 🔹 Passo 3 – Criação da branch de trabalho para o CA1

Para organizar o desenvolvimento e manter o histórico limpo, foi criada uma **branch específica** para o CA1.  
Isso permite separar as alterações desta atividade do código principal (`main`).

```bash
git checkout -b ca1-version-control
```

---

### 🔹 Passo 4 – Alteração no código (adição do campo "Licença Profissional")

Nesta etapa, foi feita uma modificação real no código do projeto **Spring PetClinic**, adicionando um novo campo chamado  
`professionalLicenseNumber` à classe `Vet.java` e ao formulário JSP de criação/edição de veterinários.

#### 🧩 4.1 Alteração na classe `Vet.java`

Ficheiro:  
`src/main/java/org/springframework/samples/petclinic/model/Vet.java`

```java
// Novo atributo adicionado
private String professionalLicenseNumber;

public String getProfessionalLicenseNumber() {
    return professionalLicenseNumber;
}

public void setProfessionalLicenseNumber(String professionalLicenseNumber) {
    this.professionalLicenseNumber = professionalLicenseNumber;
}
```
#### 🧩 4.2 Alteração no formulário JSP

Ficheiro:  
`src/main/webapp/WEB-INF/jsp/vets/createOrUpdateVetForm.jsp`

```jsp
<tr>
  <th><label for="professionalLicenseNumber">Licença Profissional:</label></th>
  <td><input type="text" id="professionalLicenseNumber" name="professionalLicenseNumber"
      value="${vet.professionalLicenseNumber}" /></td>
</tr>
```
---

### 🔹 Passo 5 – Teste e execução da aplicação (verificação funcional)

Após as alterações no código, foi necessário **testar a aplicação** para garantir que tudo continuava funcional e que o novo campo “Licença Profissional” aparecia corretamente no formulário.

#### ⚙️ 5.1 Compilação e execução

Para iniciar o projeto com o *Spring Boot*, foi utilizado o *wrapper* do Maven incluído no repositório:

```bash
./mvnw spring-boot:run
```
Durante a execução, o terminal apresentou a mensagem:


#### 🌐 5.2 Verificação no navegador

No navegador, ao aceder a:http://localhost:8080/vets


✅ Foi confirmado que:
- A aplicação **compila e corre sem erros**;
- O campo **“Licença Profissional”** aparece no formulário de criação/edição de veterinários;
- As informações são **guardadas e exibidas corretamente**.

---
---

### 🔹 Passo 6 – Versionamento e publicação no GitHub

Após verificar que a aplicação estava funcional, as alterações foram preparadas para envio ao GitHub.  
O objetivo foi manter um **histórico limpo**, com commits descritivos e uma tag de versão.

#### 📦 6.1 Adicionar e confirmar as alterações

```bash
git add .
git commit -m "feat(CA1): adicionar professionalLicenseNumber em Vet e no formulário JSP"
```
#### 🏷️ 6.2 Criar uma *tag* identificando a versão CA1

Após o commit, foi criada uma **tag** para marcar a versão final do trabalho prático CA1.

```bash
git tag -a v1.2.0 -m "Versão CA1 – adição do campo Licença Profissional"
```

---

## 7️⃣ Conclusões e Referências

### 🧩 Conclusões

Com este trabalho prático (CA1), foi possível consolidar o uso do **Git e GitHub** como ferramentas essenciais para o **controlo de versões** em projetos de software.

As principais aprendizagens foram:

- Compreensão do ciclo de versionamento (clone → branch → commit → tag → push);
- Aplicação de boas práticas de commits e gestão de histórico;
- Integração entre código Java real (Spring PetClinic) e versionamento remoto;
- Documentação técnica das alterações no código.

O resultado final é um repositório funcional, documentado e versionado de acordo com padrões profissionais de desenvolvimento colaborativo.

---

### 📚 Referências

- [Documentação oficial do Git](https://git-scm.com/doc)  
- [Documentação do GitHub](https://docs.github.com)  
- [Spring PetClinic – Projeto base](https://github.com/spring-projects/spring-petclinic)  
- [Maven Wrapper](https://maven.apache.org/wrapper/)  
- [Guia de boas práticas de commits](https://www.conventionalcommits.org/)

---

📅 **Data:** 17/10/2025  
✍️ **Autor:** *Esveraldo Lopes*  
🏛️ **Instituição:** *ISEP – Instituto Superior de Engenharia do Porto*

