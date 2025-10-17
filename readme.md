# 🧾 Relatório de Submissão – CA1 (Version Control)

**Disciplina:** Configuração e Gestão de Sistemas  
**Professor:** Luís Nogueira  
**Autor:** Esveraldo Carlos da Silva Lopes  
**Data:** 17 de Outubro de 2025  

---

## 🎯 Objetivo do Trabalho

Aplicar conceitos de **controlo de versões com Git** utilizando a aplicação **Spring PetClinic** como base de estudo.  
O trabalho demonstrou competências práticas na criação de branches, gestão de tags, e resolução manual de conflitos.

---

## ⚙️ Etapas de Desenvolvimento

| Etapa | Descrição | Tag / Estado |
|-------|------------|--------------|
| **1** | Criação da pasta `CA1` e cópia da aplicação base *Spring PetClinic* | `v1.1.0` |
| **2** | Adição do campo `professionalLicenseNumber` à classe `Vet` e ao formulário JSP | `v1.2.0` |
| **3** | Criação da branch `email-field` e adição do campo `email` à classe `Vet` (versão sem JSP) | `v1.3.0` |
| **4** | Simulação e resolução manual de conflito entre branches (`license-update` e `main`), consolidando o campo `email` | `ca1-part2` |

---

## 💻 Principais Comandos Git Utilizados

```bash
git checkout -b email-field
git add .
git commit -m "Adicionado campo email à classe Vet e ao formulário JSP (branch email-field)"
git checkout main
git merge email-field
git tag v1.3.0

git checkout -b license-update
git commit -m "Alterado campo email para emailAddress (branch license-update)"

git checkout main
git commit -m "Alterado campo email para contactEmail (branch main)"

git merge license-update
git add .
git commit -m "Resolução de conflito entre main e license-update no campo email"
git tag ca1-part2
git push origin main --tags

