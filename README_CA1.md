🧾 Tutorial – CA1 (Version Control com Git e GitHub)
🗂️ Índice

🎓 Unidade Curricular

1️⃣ Objetivo

2️⃣ Ferramentas Utilizadas

3️⃣ Estrutura Inicial (Spring PetClinic)

4️⃣ Desenvolvimento – Passo a Passo

Passo 1 – Clonar o repositório base

Passo 2 – Criação do repositório do aluno

Passo 3 – Criação da branch de trabalho

Passo 4 – Alteração no código

Passo 5 – Teste e execução

Passo 6 – Versionamento e publicação

7️⃣ Conclusões da Parte 1

🧩 Parte 2 – Gestão de Branches e Conflitos

Passo 1 – Branch email-field

Passo 2 – Branch license-update

Passo 3 – Alteração na main

Passo 4 – Merge e resolução de conflito

Passo 5 – Tag final e publicação

✅ Conclusões da Parte 2

🎓 Unidade Curricular

Configuração e Gestão de Sistemas (COGSI)
Professor: Luís Nogueira
Estudante: Esveraldo Lopes
Ano Letivo: 2025/2026
Instituição: ISEP – Instituto Superior de Engenharia do Porto

1️⃣ Objetivo

Aplicar o controlo de versões com Git e GitHub, usando boas práticas: criação de branches, commits descritivos, tags e histórico.
O projeto base usado foi o Spring PetClinic.

2️⃣ Ferramentas Utilizadas
Ferramenta	Função	Versão/Notas
Git	Controlo de versões	2.47.0
GitHub	Repositório remoto	—
Git Bash	Terminal	Windows 11
VS Code	Editor	Atual
Maven	Build tool do projeto base	3.9.x
Java	Linguagem do projeto	17+
3️⃣ Estrutura Inicial (Spring PetClinic)

A estrutura inicial do projeto foi baseada no código original do Spring PetClinic, que serviu como ponto de partida para as modificações realizadas durante o CA1.

spring-framework-petclinic/
├── src/main/java/org/springframework/samples/petclinic/model/Vet.java
├── src/main/webapp/WEB-INF/jsp/vets/
│   ├── createOrUpdateVetForm.jsp
│   └── vetList.jsp
├── pom.xml
└── README.md

4️⃣ Desenvolvimento – Passo a Passo

Nesta secção são descritos, de forma sequencial e explicativa, todos os passos realizados para aplicar o controlo de versões com Git e GitHub no contexto do projeto Spring PetClinic.

🔹 Passo 1 – Clonar o repositório base
git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic

🔹 Passo 2 – Criação do repositório do aluno (CA1)
git remote remove origin
git remote add origin https://github.com/EsveraldoLopes/COGSI2526-1242220.git
git push -u origin main

🔹 Passo 3 – Criação da branch de trabalho para o CA1
git checkout -b ca1-version-control

🔹 Passo 4 – Alteração no código (adição do campo “Licença Profissional”)
🧩 4.1 Alteração na classe Vet.java
private String professionalLicenseNumber;

public String getProfessionalLicenseNumber() {
    return professionalLicenseNumber;
}

public void setProfessionalLicenseNumber(String professionalLicenseNumber) {
    this.professionalLicenseNumber = professionalLicenseNumber;
}

🧩 4.2 Alteração no formulário JSP
<tr>
  <th><label for="professionalLicenseNumber">Licença Profissional:</label></th>
  <td><input type="text" id="professionalLicenseNumber" name="professionalLicenseNumber"
      value="${vet.professionalLicenseNumber}" /></td>
</tr>

🔹 Passo 5 – Teste e execução da aplicação
./mvnw spring-boot:run


🌐 Aceder a http://localhost:8080/vets

✅ Aplicação funcional, campo visível e dados persistidos.

🔹 Passo 6 – Versionamento e publicação no GitHub
git add .
git commit -m "feat(CA1): adicionar professionalLicenseNumber em Vet e no formulário JSP"
git tag -a v1.2.0 -m "Versão CA1 – adição do campo Licença Profissional"
git push origin ca1-version-control
git push origin --tags

7️⃣ Conclusões da Parte 1

Consolidação do uso do Git e GitHub para versionamento de código.

Criação de commits descritivos, branches e tags.

Integração de boas práticas de controlo de versões num projeto real (Spring PetClinic).

🧩 Parte 2 – Gestão de Branches e Resolução de Conflitos

Nesta segunda parte, foi explorado o controlo de versões avançado, incluindo criação de múltiplas branches e resolução manual de conflitos.

🔹 Passo 1 – Criação da branch email-field
git checkout -b email-field

private String email;

public String getEmail() { return email; }
public void setEmail(String email) { this.email = email; }

git add .
git commit -m "feat(CA1-part2): adicionar campo email à classe Vet"
git tag -a v1.3.0 -m "Versão CA1-Part2 – Campo email adicionado"

🔹 Passo 2 – Criação da branch license-update
git checkout -b license-update

private String contactEmail;

public String getContactEmail() { return contactEmail; }
public void setContactEmail(String contactEmail) { this.contactEmail = contactEmail; }

git add src/main/java/org/springframework/samples/petclinic/model/Vet.java
git commit -m "chore(CA1-part2): renomear campo email para contactEmail (branch license-update)"

🔹 Passo 3 – Alteração paralela na branch main
git checkout main

private String emailAddress;

public String getEmailAddress() { return emailAddress; }
public void setEmailAddress(String emailAddress) { this.emailAddress = emailAddress; }

git add src/main/java/org/springframework/samples/petclinic/model/Vet.java
git commit -m "chore(CA1-part2): renomear campo email para emailAddress (branch main)"

🔹 Passo 4 – Merge e resolução manual de conflito
git merge license-update


💡 O Git identificou conflito no ficheiro Vet.java.
Após análise, decidiu-se manter a versão contactEmail:

private String contactEmail;

public String getContactEmail() { return contactEmail; }
public void setContactEmail(String contactEmail) { this.contactEmail = contactEmail; }

git add src/main/java/org/springframework/samples/petclinic/model/Vet.java
git commit -m "fix(CA1-part2): resolução de conflito entre main e license-update"

🔹 Passo 5 – Criação da tag final e publicação no GitHub
git tag -a ca1-part2 -m "CA1 – Parte 2 concluída (Gestão de branches e resolução de conflito)"
git push origin main
git push origin --tags

✅ Conclusões da Parte 2

Prática de criação e gestão de branches independentes;

Compreensão do processo de merge e resolução manual de conflitos;

Uso de tags para marcar marcos de desenvolvimento;

Consolidação das boas práticas de versionamento colaborativo.

📅 Data: 25/10/2025
✍️ Autor: Esveraldo Lopes
🏛️ Instituição: ISEP – Instituto Superior de Engenharia do Porto