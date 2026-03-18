# 📋 Project Report: Bus2Holiday

> **Semester Project for Enterprise Applications (EAR)** > **Academic Year:** 2025/2026

---

## 📑 Table of Contents

- [Application Description](#-application-description)
- [Application Structure](#-application-structure)
- [Installation Guide](#-installation-guide)
- [Lessons Learned During the Project](#-lessons-learned-during-the-project)
- [Conclusion](#-conclusion)

---

## 🚍 Application Description

**Bus2Holiday** is a backend information system for managing international bus transport, inspired by the FlixBus platform. The application provides a complete REST API for ticket reservations, management of buses, routes, drivers, and users.

### Main Functionalities

| 👤 For Customers (USER) | 🚗 For Drivers (DRIVER) | 🔐 For Administrators (ADMIN) |
| :--- | :--- | :--- |
| ✅ Registration & JWT auth | 📋 Overview of assigned trips | 👥 User and role management |
| 🔍 Connection search | 👥 Passenger lists | 🚌 Fleet management |
| 🎫 Ticket reservation | ⏰ Availability management | 🗺️ Route and stop definitions |
| 💺 Seat selection | 🔔 Change notifications | 📊 Statistics and revenue |
| 💳 Payment operations | | |

### 🛠️ Technology Stack

| Category | Technology | Version |
| :--- | :--- | :--- |
| **Framework** | Spring Boot | 3.5.6 |
| **Database** | PostgreSQL | 15+ |
| **ORM** | Spring Data JPA / Hibernate | - |
| **Security** | Spring Security + JWT | 0.12.3 |
| **Migration** | Flyway | - |
| **Testing** | JUnit 5 + Testcontainers | - |
| **Build Tool** | Maven | - |
| **Java** | OpenJDK | 21 (LTS) |
| **Containerization** | Docker + Docker Compose | - |

---

## 🏗️ Application Structure

The application follows a classic **multi-tier architecture** for enterprise applications:

```text
bus2holiday/
├── 🎮 controller/          # REST API endpoints (7 controllers)
│   ├── AuthController
│   ├── BusController
│   ├── DriverController
│   ├── ReservationController
│   ├── RouteController
│   ├── UserController
│   └── DebugController
│
├── ⚙️ service/             # Business logic (7 services)
│   └── [BusService, DriverService, ReservationService, ...]
│
├── 💾 dao/                 # Data Access Objects (11 repositories)
│   └── [BusRepository, UserRepository, TripRepository, ...]
│
├── 📊 model/               # JPA entities (17 entities)
│   ├── User, Driver, Bus
│   ├── Route, RouteStop, Terminal
│   ├── Trip, Reservation
│   └── enums/ (UserRole, BusStatus, TripStatus, ...)
│
├── 📦 dto/                 # Data Transfer Objects (20 DTOs)
│   └── mapper/            # MapStruct mappers
│
├── 🔒 security/            # Security layer (7 classes)
│   ├── JwtTokenProvider
│   ├── UserDetailsServiceImpl
│   └── model/ (UserDetails, LoginStatus)
│
├── ⚠️ exception/           # Custom exceptions (6 classes)
└── 🔧 config/              # Spring configuration (3 classes)

📐 Data Model - Key Relationships
erDiagram
    USER ||--o| DRIVER : "1:1"
    USER ||--o{ RESERVATION : "1:N"
    TRIP ||--o{ RESERVATION : "1:N"
    ROUTE ||--o{ TRIP : "1:N"
    BUS ||--o{ TRIP : "1:N"
    DRIVER ||--o{ TRIP : "1:N"
    ROUTE ||--o{ ROUTE_STOP : "1:N"
    TERMINAL ||--o{ ROUTE_STOP : "1:N"
    RESERVATION ||--o{ RESERVATION_PASSENGER : "1:N"
    TRIP ||--o{ BOOKED_SEGMENT : "1:N"

    USER {
        uuid id PK
        string email UK
        string password_hash
        enum role
    }

    TRIP {
        uuid id PK
        uuid route_id FK
        uuid bus_id FK
        uuid driver_id FK
        decimal price
        timestamp departure_datetime
        enum status
    }

    RESERVATION {
        uuid id PK
        uuid user_id FK
        uuid trip_id FK
        string booking_reference UK
        decimal total_amount
        enum status
    }

📥 Installation Guide
Prerequisites

    ☕ JDK 21 or higher

    📦 Maven 3.9+

    🐘 PostgreSQL 15+ (or Docker)

    🔧 Git

💡 Lessons Learned
4.1 Technology Evaluation
✅ Spring Boot 3.5.6 (Java 21)

    Pros: Excellent integration, auto-configuration, Virtual Threads support.

    Cons: Newer versions have less community documentation available.

✅ JWT Authentication

    Pros: Stateless and scalable.

    Cons: Complex token revocation and refresh logic.

✅ Spring Data JPA + Hibernate

    Pros: Minimal boilerplate.

    Cons: Faced N+1 problems and Circular References during JSON serialization.

    Solution: Used @JsonIgnore and planned to migrate fully to the DTO pattern.

4.2 Unexpected Issues
🔴 Issue 1: Infinite Recursion

    Cause: Bidirectional JPA relationships (Route ↔ RouteStop).

    Fix: Applied @JsonIgnore on the child side.

🔴 Issue 2: Flyway Circular Dependency

    Cause: Dependency loop between dataSource, flyway, and entityManagerFactory.

    Fix: Temporarily disabled Flyway in favor of data.sql for the development phase.

👥 Authors

    Mykhailo Plokhin

    Ivan Shestachenko
