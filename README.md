# Survey GraphQL API

## Visão Geral

O projeto **Survey GraphQL API** é uma aplicação para coordenar e responder pesquisas de forma eficiente e segura. Construído em Ruby on Rails, utiliza GraphQL para interação com os dados e JWT para autenticação, permitindo que diferentes tipos de usuários (coordenadores e respondentes) participem do ciclo de vida de uma pesquisa, desde sua criação até a coleta de respostas.

## Finalidade do Projeto

Este projeto foi desenvolvido com a finalidade de servir como teste para um processo seletivo de estágio. Ele demonstra o uso de tecnologias como Ruby on Rails, GraphQL e JWT em um cenário de gerenciamento de pesquisas, com foco em funcionalidades de criação, resposta e autenticação de usuários.

## Diagrama UML
<details>
  <summary>Clique para visualizar o diagrama UML</summary>

  ```mermaid
  classDiagram
      class User {
        +id: Integer
        +email: String
        +password_digest: String
        +role: String
        +created_at: DateTime
        +updated_at: DateTime
      }
  
      class Survey {
        +id: Integer
        +title: String
        +start_date: Date
        +end_date: Date
        +closed: Boolean
        +user_id: Integer
        +created_at: DateTime
        +updated_at: DateTime
      }
  
      class Question {
        +id: Integer
        +title: String
        +question_type: Integer
        +survey_id: Integer
        +created_at: DateTime
        +updated_at: DateTime
      }
  
      class Option {
        +id: Integer
        +content: String
        +question_id: Integer
        +created_at: DateTime
        +updated_at: DateTime
      }
  
      class Response {
        +id: Integer
        +content: String
        +user_id: Integer
        +question_id: Integer
        +option_id: Integer
        +created_at: DateTime
        +updated_at: DateTime
      }
  
      User "1" --o "many" Survey : cria
      Survey "1" --o "many" Question : contém
      Question "1" --o "many" Option : tem
      Question "1" --o "many" Response : é respondida
      Option "1" --o "many" Response : é escolhida
      User "1" --o "many" Response : submete
  ````
</details>

## Funcionalidades

- **Usuários**:
  - **Coordenador**: Cria, atualiza e exclui pesquisas, além de gerenciar questões e opções. Pode visualizar as respostas submetidas.
  - **Respondente**: Participa de pesquisas respondendo perguntas e submetendo suas respostas.
  
- **Gerenciamento de Pesquisas**:
  - Criação, atualização e exclusão de pesquisas.
  - Gerenciamento de perguntas e opções associadas.
  - Visualização de pesquisas abertas e fechadas.

- **Respostas**:
  - Submissão de respostas pelos respondentes.
  - Visualização das respostas submetidas pelos coordenadores.

- **Autenticação**:
  - Registro e login de usuários com autenticação JWT.

---

## Tecnologias Utilizadas

- **Ruby on Rails**
- **GraphQL**
- **JWT (JSON Web Token)**
- **PostgreSQL**
- **RSpec**
- **bcrypt**
- **factory-bot-rails**

---

## Funcionalidades e Endpoints

### Queries

- `all_surveys`: Retorna todas as pesquisas.
- `closed_surveys`: Retorna todas as pesquisas fechadas.
- `open_surveys`: Retorna a pesquisa que está aberta atualmente.
- `survey_by_id`: Retorna uma pesquisa específica pelo ID.
- `user_surveys`: Retorna as pesquisas criadas por um usuário específico (coordenador).
- `get_surveys_results`: Retorna a quantidade de respostas de cada opção.
- `options_questions`: Retorna as opções de respostas associadas a uma pergunta.

### Mutations

- **Pesquisas**:
  - `create_survey`: Cria uma nova pesquisa.
  - `update_survey`: Atualiza uma pesquisa existente.
  - `delete_survey`: Exclui uma pesquisa.
  
- **Perguntas**:
  - `create_question`: Cria uma nova pergunta.
  - `update_question`: Atualiza uma pergunta existente.
  - `delete_question`: Exclui uma pergunta.
  
- **Opções**:
  - `create_option`: Cria uma nova opção de resposta.
  - `update_option`: Atualiza uma opção de resposta.
  - `delete_option`: Exclui uma opção de resposta.

- **Respostas**:
  - `create_response`: Cria uma nova resposta para uma pergunta.

- **Usuários**:
  - `create_user`: Registra um novo usuário (coordenador ou respondente).
  - `login_user`: Autentica um usuário e retorna um token JWT.

---

## Instalação e Configuração

### Pré-requisitos

- **Ruby 3.3.5**
- **Rails 7**
- **PostgreSQL**

### Passos para Configuração

1. Clone o repositório:
   ```bash
   git clone https://github.com/ReizeXD/SurveyAPI.git
   cd SurveyAPI
   ````

2. Instale as Depedências
   ```bash
   bundle install
   ```
3. Configure o banco de dados:

  Edite o arquivo config/database.yml para incluir suas credenciais do PostgreSQL.
  Rode as migrações:
````bash
  rails db:create
  rails db:migrate
  ````
4. Carregue dados de exemplo (opcional):

````bash
rails db:seed
````
5. Inicie o servidor:

````bash
rails s
````

6. Acesse o GraphiQL no navegador:

  URL: http://localhost:3000/graphiql

Agora está pronto para utilizar a aplicação, inserindo as queries e mutations.
