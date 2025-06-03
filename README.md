# Intuitive Care – Desafio Técnico

## O uso do **[site](https://site-intuitive-care.vercel.app/)** pode ocorrer um delay na primeira interação de cerca de 2 minutos por conta do servidor ficar em sleep em inatividade

Este repositório contém a solução para o desafio técnico proposto pela Intuitive Care, dividido em 4 testes distintos.
---
## Disclaimer: O link de conexão com o database está inteiro, com a senha, por otimizar o deploy, mas em um ambiente ideial seria utilizada uma variável de sistema protegida, como DBPASSWORD ou algo do tipo


## ✅ Requisitos

Antes de iniciar, certifique-se de ter o Python 3 instalado no seu ambiente, além do `pip`.

Instale as dependências abaixo com o seguinte comando:

```bash
pip install requests beautifulsoup4 pdfplumber pandas
```

**Requisitos Python:**
- `requests`
- `os`
- `zipfile`
- `beautifulsoup4` 
- `pdfplumber`
- `pandas`

---

## 🧪 Teste 1 — Coleta de Dados (Scraping)

**Como executar:**
```bash
cd Teste1
python Scraping.py
```

**Saída:**  
Os arquivos extraídos serão salvos na pasta `data/` localizada na raiz do repositório.

---

## 🧪 Teste 2 — Transformação de Dados PDF → Tabela


**Como executar:**
```bash
cd Teste2
python transformacao_de_dados.py
```

**Saída:**  
Os arquivos resultantes também são salvos na pasta `data/` no root do projeto.

---

## 🧪 Teste 3 — Banco de Dados (PostgreSQL)

**Descrição:**  
Cria o banco de dados PostgreSQL, popula as tabelas e realiza análises com SQL.

### Passo 1: Preparar o ambiente
No terminal, execute:

```bash
cd Teste3
python preparacao.py
```

### Passo 2: Criar e popular o banco (duas opções):

**Usando psql via terminal:**

No terminal dentro da pasta `Teste3`, abra o `psql` e execute:

```psql
\i criacao_database.sql
\i preencher_tabelas.sql
```

**Ou usando pgAdmin:**

1. Abra o pgAdmin.
2. Crie um banco de dados conforme o script `criacao_database.sql`.
3. Execute os dois scripts diretamente no servidor.
4. ⚠️ Os scripts de **top 10 despesas** só funcionam corretamente via pgAdmin.

---

## 🧪 Teste 4 — Aplicação Web

**Como acessar:**  
Acesse a aplicação online no seguinte link:

🔗 **[https://site-intuitive-care.vercel.app/](https://site-intuitive-care.vercel.app/)**

Não é necessário rodar nada localmente para o Teste 4 — ele já está publicado na nuvem.

---

## 📁 Estrutura de Pastas

```
Intuitive-Care/
├── Teste1/
├── Teste2/
├── Teste3/
├── Teste4/
├── data/
└── README.md
```

