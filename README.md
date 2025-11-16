Vehicle Inventory System

Sistema de inventário de veículos com backend em Spring Boot, banco de dados MySQL e frontend em React.

---

Estrutura do Projeto

vehicle-inventory-project/
├── backend/                 # Código do backend Spring Boot
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/example/vehicles/
│   │   │   │   ├── controller/
│   │   │   │   ├── model/
│   │   │   │   └── service/
│   │   │   └── resources/
│   │   │       └── application.properties
│   │   └── test/
│   └── pom.xml
├── frontend/                # Código do frontend React
│   ├── public/
│   ├── src/
│   ├── package.json
│   └── ...
├── docker-compose.yml       # Arquivo do Docker Compose
└── README.txt               # Este arquivo

---

Requisitos

- Docker e Docker Compose
- Maven (opcional, apenas para build manual do backend)
- Node.js e npm (opcional, apenas para build manual do frontend)

---

Rodando o projeto

1. Clone o repositório:

git clone <url-do-repo>
cd vehicle-inventory-project

2. Suba todos os serviços com Docker Compose:

docker-compose up --build

Isso irá criar:

- Banco de dados MySQL (vehiclesdb)
- API Spring Boot (backend) rodando na porta 8080
- Frontend React (frontend)
