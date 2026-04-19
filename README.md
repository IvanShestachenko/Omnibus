# 🚍 Bus2Holiday — Enterprise Bus Transportation System

*Semester project EAR/NSS — CTU FEL*

> **Semester Project for Enterprise Applications (EAR)** > **Academic Year:** 2025/2026

[![Java](https://img.shields.io/badge/Java-21-orange?logo=openjdk)](https://openjdk.org/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.5.6-brightgreen?logo=springboot)](https://spring.io/projects/spring-boot)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue?logo=postgresql)](https://www.postgresql.org/)
[![React](https://img.shields.io/badge/React-19-61DAFB?logo=react)](https://react.dev/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.9-3178C6?logo=typescript)](https://www.typescriptlang.org/)

<img width="1919" height="824" alt="image" src="https://github.com/user-attachments/assets/04437448-c7dc-41b2-b042-20fc5500843e" />

## 🎯 Project Goal

The goal of this semester project is to **design and implement an enterprise information system** for a bus transportation company (inspired by FlixBus).
The project focuses on building a **multi-layered enterprise-level application** with emphasis on:
- backend system architecture design,
- use of modern technologies (Spring Boot 3, JWT, Testcontainers),
- security, data integrity, and testing.

---

## ⚙️ Technology Stack

### Backend
| Technology | Version | Purpose |
|---|---|---|
| **Java** | 21 | Core language |
| **Spring Boot** | 3.5.6 | Application framework |
| **Spring Security** | 6.x | JWT authentication & authorization |
| **JPA / Hibernate** | 6.6 | ORM with native PostgreSQL enum support |
| **PostgreSQL** | 15 | Primary database |
| **Flyway** | 11.x | Database migrations (prepared) |
| **Lombok** | 1.18 | Boilerplate reduction |
| **JUnit 5 + Mockito** | 5.12 | Unit testing |
| **Testcontainers** | 1.21 | Integration tests with real PostgreSQL |

### Frontend
| Technology | Version | Purpose |
|---|---|---|
| **React** | 19.x | UI framework |
| **TypeScript** | 5.9 | Type safety |
| **Vite** | 7.x | Build tooling & dev server |
| **React Router** | 7.x | Client-side routing |
| **Axios** | — | HTTP client |

---

## 📁 Project Structure

```
bus2holiday/
├── src/main/java/cz/cvut/ear/bus2holiday/
│   ├── config/              # Security, CORS, JWT filter configuration
│   ├── controller/          # REST controllers
│   ├── dao/                 # JPA repositories (Spring Data)
│   ├── dto/
│   │   ├── mapper/          # Entity → DTO mapping
│   │   ├── request/         # Inbound request DTOs
│   │   └── response/        # Outbound response DTOs
│   ├── exception/           # Global exception handling (GlobalExceptionHandler)
│   ├── model/               # JPA entities
│   │   └── enums/           # Enumerations (UserRole, TripStatus, BusStatus, ...)
│   ├── security/            # JWT provider, SecurityUtils, UserDetailsService
│   ├── service/             # Business logic layer
│   └── utils/               # Utility helpers
├── src/main/resources/
│   ├── application.properties    # Main configuration
│   └── data.sql                  # Initial seed data (runs on startup)
├── src/test/
│   ├── java/.../
│   │   ├── TestContainerConfig.java    # Shared Testcontainers base class
│   │   ├── controller/                 # Controller integration tests
│   │   ├── dao/                        # Repository (named query) tests
│   │   └── service/                    # Service integration tests
│   └── resources/
│       └── application.properties      # Test-specific overrides (Testcontainers)
├── frontend/                # React SPA
│   ├── src/
│   │   ├── api/             # Axios API client
│   │   ├── components/      # Reusable UI components (Button, Card, Header, Footer)
│   │   ├── context/         # Auth context (React Context API)
│   │   └── pages/           # Pages (Home, Search, Trip, Reservations, Login, Register)
│   └── vite.config.ts
├── docker-compose.yml       # PostgreSQL + app containerization
├── Dockerfile
└── pom.xml
```

---

## 🚀 Getting Started

### Prerequisites
- **Java 21+**
- **Node.js 18+**
- **Docker** (recommended) or a local PostgreSQL 15 instance

---

### Option A — Docker Compose (Recommended)

Starts PostgreSQL + the Spring Boot app in one command:

```bash
docker-compose up --build
# Backend: http://localhost:8080
```

---

### Option B — Local Development

#### 1. Database

Create a local PostgreSQL database:

```sql
CREATE DATABASE bus2holiday;
```

#### 2. Backend

Configure `src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/bus2holiday
spring.datasource.username=YOUR_USER
spring.datasource.password=YOUR_PASSWORD
jwt.secret=YOUR_SECRET_KEY_MIN_32_CHARS
```

Then run:
```bash
./mvnw spring-boot:run
# Backend: http://localhost:8081
```

On first startup, Hibernate auto-creates all tables and enum types, then `data.sql` seeds the initial data.

**Default seed accounts** (from `data.sql`):
| Email | Password | Role |
|---|---|---|
| `admin@bus2holiday.com` | `password` | Admin |
| `john@example.com` | `password` | User |
| `driver@example.com` | `password` | Driver |

#### 3. Frontend

```bash
cd frontend
npm install
npm run dev
# Frontend: http://localhost:5173
```

---

## 🧩 Key Features

### 👤 User & Role Management
- Registration, login, JWT authentication (24h tokens)
- Role-based authorization: **Admin** / **User** / **Driver**
- User profile management (update name, phone)

### 🚌 Bus & Route Management
- Vehicle fleet tracking with seat capacities and layouts
- Driver assignment to buses
- Route definition with stops (segment-based routes)

### 🕓 Trip Scheduling
- Creation of individual trips (departure/arrival datetime, price, capacity)
- Trip modification, status management, cancellation
- Real-time seat availability via segment-based booking model

### 🔍 Trip Search
- Filtering by origin, destination, date, price, availability
- Public API endpoint — no authentication required

### 🎟️ Reservations & Ticket Sales
- Segment-based seat selection (`fromStopOrder` → `toStopOrder`)
- **Pessimistic locking** prevents double-booking under concurrent load
- Online payment simulation
- Ticket cancellation (minimum 15 minutes before departure)

### 🚛 Driver Module
- Overview of assigned trips
- Availability management

### 🧾 Administration Module
- Full CRUD for users, routes, buses, trips, and drivers
- Role assignment and user management

---

## 🔒 Security

- **JWT tokens** — stateless authentication, 24h expiration
- **RBAC** — `user`, `driver`, `admin` roles via `@PreAuthorize`
- **Method-level security** on all controllers
- **CORS** — configured for `http://localhost:*`
- **Input validation** — `@Valid` + Bean Validation on all request DTOs
- **Centralized exception handling** — `GlobalExceptionHandler` with consistent error responses

---

## 👥 System Roles

| Role | Description |
|---|---|
| **Admin** | Full access. Manages users, roles, routes, buses, drivers, and reservations. |
| **User** | Searches trips, creates and cancels reservations, pays for tickets. |
| **Driver** | Views assigned trips, manages own availability. |

---

## 📡 API Endpoints

### Public (no authentication required)
| Method | Endpoint | Description |
|---|---|---|
| `POST` | `/api/auth/login` | Login, returns JWT |
| `POST` | `/api/auth/register` | New user registration |
| `GET` | `/api/trips/search` | Search trips by criteria |
| `GET` | `/api/trips/{id}` | Trip details |
| `GET` | `/api/trips/{id}/available-seats` | Available seats for a trip |
| `GET` | `/api/routes` | All routes |
| `GET` | `/api/routes/{id}` | Route details with stops |

### Authenticated (any role)
| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/api/users/me` | My profile |
| `PUT` | `/api/users/{id}` | Update my profile |
| `GET` | `/api/reservations` | My reservations |
| `POST` | `/api/reservations` | Create a reservation |
| `DELETE` | `/api/reservations/{id}` | Cancel a reservation |
| `POST` | `/api/reservations/{id}/pay` | Pay for a reservation |
| `GET` | `/api/drivers/me/trips` | My trips (driver only) |

### Admin only
| Method | Endpoint | Description |
|---|---|---|
| `GET/POST` | `/api/buses` | List / create buses |
| `GET/PATCH/DELETE` | `/api/buses/{id}` | Get / update status / delete bus |
| `GET/POST` | `/api/routes` | List / create routes |
| `POST/DELETE` | `/api/routes/{id}/stops` | Add / remove route stops |
| `POST/PUT/DELETE` | `/api/trips` | Manage trips |
| `GET/POST/DELETE` | `/api/drivers` | Manage drivers |
| `GET/DELETE` | `/api/users` | List / delete users |

---

## 🧪 Testing

```bash
# Run all tests (requires Docker for Testcontainers)
./mvnw test
```

### Test Infrastructure
- **Testcontainers** — each test suite spins up an isolated PostgreSQL 15 container
- `TestContainerConfig` — shared abstract base class with a single static container instance
- `ddl-auto=create-drop` in test profile — clean schema on every context load
- `preparedStatementCacheQueries=0` — prevents PostgreSQL cached plan errors across contexts
- **`@Transactional`** on all test classes — automatic rollback after each test

### Test Coverage
| Type | Framework | Location |
|---|---|---|
| Unit tests | JUnit 5 + Mockito | `service/` |
| Repository tests | `@Transactional` + EntityManager | `dao/` |
| Controller tests | MockMvc + Testcontainers | `controller/` |
| Service integration | Full Spring context | `service/` |

---

## 🏗️ Architecture

```
┌─────────────┐     ┌───────────────┐     ┌─────────────┐     ┌──────────────┐
│  Frontend   │────▶│  Controller   │────▶│   Service   │────▶│  Repository  │
│  (React)    │◀────│  (REST API)   │◀────│  (Business) │◀────│   (JPA)      │
└─────────────┘     └───────────────┘     └─────────────┘     └──────────────┘
                           │                                         │
                    ┌──────┴──────┐                           ┌──────┴──────┐
                    │  DTO/Mapper │                           │ PostgreSQL  │
                    └─────────────┘                           └─────────────┘
```

- **Controllers** accept and return **DTOs only** — no JPA entities exposed to the API layer
- **Mappers** handle entity ↔ DTO conversion (`UserMapper`, `BusMapper`, `TripMapper`, `ReservationMapper`, etc.)
- **Services** contain all business logic and enforce transactional boundaries
- **Repositories** use Spring Data JPA with custom JPQL queries where needed

---

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines.

---

*CTU FEL — EAR/NSS Semester Project*
