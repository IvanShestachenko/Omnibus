# 🚍 Bus2Holiday — Enterprise Bus Transportation System

*Semester project EAR — CTU FEL*

## 🎯 Project Goal

The goal of this semester project is to **design and implement an enterprise information system** for a bus transportation company (inspired by FlixBus).
The project focuses on building a **multi-layered enterprise-level application** with emphasis on:
- backend system architecture design,
- use of modern technologies,
- security and testing.

---

## ⚙️ Technology Stack

### Backend
| Technology | Version |
|---|---|
| **Java** | 21 |
| **Spring Boot** | 3.5.6 |
| **Spring Security** | JWT authentication |
| **JPA / Hibernate** | ORM |
| **PostgreSQL** | Database |
| **Flyway** | Migrations (prepared) |
| **Lombok** | Boilerplate reduction |
| **JUnit 5 + Mockito** | Testing |
| **Testcontainers** | Integration tests |

### Frontend
| Technology | Version |
|---|---|
| **React** | 19.x |
| **TypeScript** | 5.9 |
| **Vite** | 7.x |
| **React Router** | 7.x |
| **Axios** | HTTP client |

---

## 📁 Project Structure

```
bus2holiday/
├── src/main/java/cz/cvut/ear/bus2holiday/
│   ├── config/              # Configuration (Security, CORS, JWT filter)
│   ├── controller/          # REST controllers
│   ├── dao/                 # JPA repositories
│   ├── dto/
│   │   ├── mapper/          # Entity → DTO mapping
│   │   ├── request/         # Request DTOs
│   │   └── response/        # Response DTOs
│   ├── exception/           # Global exception handling
│   ├── model/               # JPA entities
│   │   └── enums/           # Enumerations (UserRole, TripStatus, ...)
│   ├── security/            # JWT provider, SecurityUtils, UserDetails
│   ├── service/             # Business logic
│   └── utils/               # Utility classes
├── src/main/resources/
│   ├── application.properties
│   └── data.sql             # Initial seed data
├── src/test/                # Unit + integration tests
├── frontend/                # React SPA
│   ├── src/
│   │   ├── api/             # API client (Axios)
│   │   ├── components/      # UI components (Button, Card, Input, Header, Footer)
│   │   ├── context/         # Auth context (React Context API)
│   │   └── pages/           # Pages (Home, Search, Trip, Reservations, Login, Register)
│   └── vite.config.ts
└── pom.xml
```

---

## 🚀 Getting Started

### Prerequisites
- Java 21+
- Node.js 18+
- PostgreSQL with a `bus2holiday` database

### Backend
```bash
# Configure variables in application.properties:
#   spring.datasource.url, username, password
#   jwt.secret

./mvnw spring-boot:run
# Backend runs at http://localhost:8081
```

### Frontend
```bash
cd frontend
npm install
npm run dev
# Frontend runs at http://localhost:5173
```

---

## 🧩 Key Features

### 👤 User & Role Management
- Registration, login, JWT authentication
- Role-based authorization (**Admin** / **User** / **Driver**)
- User profile management

### 🚌 Bus & Route Management
- Vehicle fleet tracking with seat capacities
- Driver assignment to buses
- Route definition with stops (segment-based routes)

### 🕓 Trip Scheduling
- Creation of individual trips (departure, arrival, capacity)
- Trip modification and deletion
- Seat availability display

### 🔍 Trip Search
- Filtering by city, date, price, availability
- Overview of upcoming trips
- Public API (no authentication required)

### 🎟️ Reservations & Ticket Sales
- Seat selection on route segments
- Ticket purchase and online payment
- Ticket cancellation (min. 15 minutes before departure)

### 🚛 Driver Module
- Overview of assigned trips
- Availability management

### 🧾 Administration Module
- Management of users, routes, buses, and drivers
- Full CRUD access

---

## 🔒 Security

- **Spring Security** with JWT tokens (24h expiration)
- **Role-based access control (RBAC)**: `user`, `driver`, `admin`
- **Method-level security**: `@PreAuthorize` on controllers
- **CORS**: configured for `http://localhost:*`
- **Input validation**: `@Valid` on request DTOs
- **Centralized exception handling**: `GlobalExceptionHandler`

---

## 👥 System Roles

| Role | Description |
|---|---|
| **Admin** | Full access. Manages users, roles, routes, buses, drivers, and orders. |
| **User** | Searches trips, buys and cancels tickets, selects seats, tracks reservations. |
| **Driver** | Views assigned trips, manages availability. |

---

## 📡 API Endpoints

### Public (no authentication)
| Method | Endpoint | Description |
|---|---|---|
| POST | `/api/auth/login` | Login |
| POST | `/api/auth/register` | Registration |
| GET | `/api/trips/search` | Search trips |
| GET | `/api/trips/{id}` | Trip details |
| GET | `/api/trips/{id}/available-seats` | Available seats |
| GET | `/api/routes/**` | Routes and stops |

### Authenticated (USER / DRIVER / ADMIN)
| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/reservations` | My reservations |
| POST | `/api/reservations` | Create reservation |
| DELETE | `/api/reservations/{id}` | Cancel reservation |
| POST | `/api/reservations/{id}/pay` | Pay for reservation |
| GET | `/api/users/me` | My profile |
| GET | `/api/drivers/me/trips` | My trips (driver) |

### Admin only
| Method | Endpoint | Description |
|---|---|---|
| CRUD | `/api/buses/**` | Bus management |
| CRUD | `/api/routes/**` | Route management |
| CRUD | `/api/trips/**` | Trip management |
| CRUD | `/api/drivers/**` | Driver management |
| CRUD | `/api/users/**` | User management |

---

## 🧪 Testing

```bash
./mvnw test
```

- **Unit tests**: JUnit 5 + Mockito
- **Integration tests**: Testcontainers (PostgreSQL)
- Test profile: `@Profile("test")` — separate Security configuration

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

Controllers accept and return **DTOs** (Data Transfer Objects), not raw JPA entities.
Mapping is handled by `*Mapper` components (`UserMapper`, `BusMapper`, `TripMapper`, `DriverMapper`, `RouteMapper`, `ReservationMapper`).
