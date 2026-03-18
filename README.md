📋 Project Report: Bus2Holiday

    Semester Project for Enterprise Applications (EAR) > Academic Year: 2025/2026

📑 Table of Contents

    Application Description

    Application Structure

    Installation Guide

    Lessons Learned During the Project

    Conclusion

🚍 Application Description

Bus2Holiday is a backend information system for managing international bus transport, inspired by the FlixBus platform. The application provides a complete REST API for ticket reservations, management of buses, routes, drivers, and users.
Main Functionalities

<table>
<tr>
<td width="33%">
👤 For Customers (USER)

    ✅ Registration and JWT authentication

    🔍 Connection search

    🎫 Ticket reservation

    💺 Seat selection

    💳 Payment operations

</td>
<td width="33%">
🚗 For Drivers (DRIVER)

    📋 Overview of assigned trips

    👥 Passenger lists

    ⏰ Availability management

    🔔 Change notifications

</td>
<td width="33%">
🔐 For Administrators (ADMIN)

    👥 User and role management

    🚌 Fleet management

    🗺️ Route and stop definitions

    📊 Statistics and revenue

</td>
</tr>
</table>
🛠️ Technology Stack
Category	Technology	Version
Framework	Spring Boot	3.5.6
Database	PostgreSQL	15+
ORM	Spring Data JPA / Hibernate	-
Security	Spring Security + JWT	0.12.3
Migration	Flyway	-
Testing	JUnit 5 + Testcontainers	-
Build Tool	Maven	-
Java	OpenJDK	21 (LTS)
Containerization	Docker + Docker Compose	-
🏗️ Application Structure

The application follows the classic multi-tier architecture of enterprise applications:

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
Code snippet

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

🔌 REST API Architecture

All endpoints return JSON and adhere to RESTful conventions:
Method	Purpose	Example
GET	Read data	GET /api/buses
POST	Create	POST /api/buses
PUT	Full update	PUT /api/buses/{id}
PATCH	Partial update	PATCH /api/buses/{id}/status
DELETE	Delete	DELETE /api/buses/{id}

    [!NOTE]
    Authorization is handled via JWT tokens in the header Authorization: Bearer <token>

📥 Installation Guide
Prerequisites

    ☕ JDK 21 or higher

    📦 Maven 3.9+

    🐘 PostgreSQL 15+ (or Docker)

    🔧 Git

📝 Step 1: Clone the Repository
Bash

git clone <repository-url>
cd bus2holiday

🐳 Step 2: Run the Database

Option A - Docker (Recommended):
Bash

docker-compose up -d postgres

Credentials:

    🗄️ Database: appdb

    👤 User: app

    🔑 Password: app

    🔌 Port: 5432

Option B - Local PostgreSQL:
SQL

CREATE DATABASE bus2holiday;
CREATE USER thera WITH PASSWORD '1702';
GRANT ALL PRIVILEGES ON DATABASE bus2holiday TO thera;

⚙️ Step 3: Application Configuration

Edit the file src/main/resources/application.properties:
Properties

# For Docker:
spring.datasource.url=jdbc:postgresql://localhost:5432/appdb
spring.datasource.username=app
spring.datasource.password=app

# Or for local PostgreSQL:
spring.datasource.url=jdbc:postgresql://localhost:5432/bus2holiday
spring.datasource.username=thera
spring.datasource.password=1702

# JWT Configuration
jwt.secret=404E635266556A586E3272357538782F413F4428472B4B6250645367566B5970
jwt.expiration=86400000

🚀 Step 4: Compilation and Execution
Bash

# Compile project
mvn clean install

# Run application
mvn spring-boot:run

✅ The application will be running at http://localhost:8081
📊 Step 5: Test Data Initialization

The application automatically creates the schema and populates test data using data.sql:

Test Accounts:
Email	Password	Role
admin@bus2holiday.com	password123	🔐 ADMIN
john@example.com	password123	👤 USER
jane@example.com	password123	👤 USER
driver1@bus2holiday.com	password123	🚗 DRIVER
driver2@bus2holiday.com	password123	🚗 DRIVER

Test data includes:

    ✅ 5 Users (Admin, Customers, Drivers)

    🏢 5 Terminals (Prague, Brno, Vienna, Budapest, Bratislava)

    🚌 4 Buses

    🗺️ 5 Routes with stops

    🎫 3 Scheduled trips

🧪 Step 6: API Testing

Login (Obtaining a JWT token):
Bash

curl -X POST http://localhost:8081/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@bus2holiday.com",
    "password": "password123"
  }'

Response:
JSON

{
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "tokenType": "Bearer",
  "expiresIn": 86400000
}

Example - List of Buses:
Bash

curl -X GET http://localhost:8081/api/buses \
  -H "Authorization: Bearer <your-token>"

📮 Testing with Postman

A collection with sample requests is available in the postman/ directory.
🐋 Running with Docker Compose

For a fully containerized environment:
Bash

docker-compose up --build

✅ Running Tests
Bash

# Unit + Integration tests with Testcontainers
mvn test

    [!TIP]
    Testcontainers automatically downloads the PostgreSQL Docker image and runs isolated tests.

💡 Lessons Learned During the Project
4.1 Technologies Used and Their Evaluation
✅ Spring Boot 3.5.6 (Java 21)

Pros:

    ✔️ Excellent integration of all Spring modules.

    ✔️ Auto-configuration saves time.

    ✔️ Spring Boot Actuator for monitoring.

    ✔️ Virtual Threads (Java 21) for better scalability.

Cons:

    ⚠️ Newer version → fewer solutions on StackOverflow.

    ⚠️ Some libraries are not yet fully compatible.

    [!NOTE]
    Conclusion: A modern choice that proved successful. Java 21 LTS is perfect for long-term projects.

✅ JWT Authentication (io.jsonwebtoken)

Pros:

    ✔️ Stateless authentication (easy scalability).

    ✔️ Token contains all necessary information.

    ✔️ No sessions → simpler deployment.

Cons:

    ⚠️ Need to handle token renewal (refresh tokens).

    ⚠️ More complex token revocation.

    ⚠️ Compromising the secret key invalidates all tokens.

Experience: Implementing the JWT filter was more challenging than expected—I had to handle the correct order of the Security filter chain.
✅ Spring Data JPA + Hibernate

Pros:

    ✔️ Minimal boilerplate code.

    ✔️ Named Queries for better readability.

    ✔️ Automatic schema generation.

Cons:

    ⚠️ N+1 problem with lazy loading → @EntityGraph.

    ⚠️ Cyclic references during JSON serialization → @JsonIgnore.

    [!CAUTION]
    Unexpected Problem: ObjectOptimisticLockingFailureException occurred in the 1:1 User-Driver relationship due to incorrect @MapsId usage. I solved it by removing manual userId settings in setters.

✅ Flyway (Database Migrations)

Pros:

    ✔️ Versioned schema changes.

    ✔️ Automatic application of migrations.

Cons:

    ⚠️ Conflict with spring.jpa.hibernate.ddl-auto=create.

    ⚠️ Circular dependency with entityManagerFactory.

Solution: I disabled Flyway in the development environment and only use data.sql.
✅ Testcontainers

Pros:

    ✔️ Real PostgreSQL database in tests.

    ✔️ Reproducible environment.

    ✔️ Isolation between tests.

Cons:

    ⚠️ Slower test startup.

    ⚠️ Requires a running Docker daemon.

✅ Lombok

Pros:

    ✔️ Elimination of getters/setters.

    ✔️ Saves hundreds of lines of code.

Cons:

    ⚠️ IntelliJ IDEA plugin occasionally fails.

    ⚠️ Debugging is more complicated.

4.2 Unexpected Problems and Their Solutions
🔴 Problem 1: Circular Reference during JSON Serialization

Situation:
An error occurred during the GET /api/buses call:

StackOverflowError: Infinite recursion (JSON serialization)
Route → RouteStop → Route → RouteStop → ...

Cause: Bidirectional JPA relationships create cycles during serialization.

Solution:
Java

@Entity
public class RouteStop {
    @JsonIgnore
    @ManyToOne
    private Route route;  // Not serialized
}

    [!IMPORTANT]
    Lesson Learned: In the future, I would use the DTO pattern everywhere—separating database entities from API responses.

🔴 Problem 2: 401 Unauthorized with Correct Password

Cause: There was an incorrect BCrypt hash in data.sql.

Solution:
Java

BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
String hash = encoder.encode("password123");
// $2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG

    [!WARNING]
    Lesson Learned: Never manually copy hashes again—use a script or Spring Boot CommandLineRunner.

🔴 Problem 3: Flyway Circular Dependency

Situation:

IllegalStateException: Circular dependency
flyway -> entityManagerFactory -> dataSource -> flyway

Solution:
Properties

spring.flyway.enabled=false

And renaming db/migration → db/migration_disabled.
🔴 Problem 4: Tests Failed Because of Flyway

Solution in application-test.properties:
Properties

spring.flyway.enabled=false
spring.jpa.hibernate.ddl-auto=create-drop

4.3 What I Would Do Differently
#	Change	Reason
1	DTO pattern everywhere	API independence from the database
2	MapStruct earlier	Automated entity ↔ DTO mapping
3	Global Exception Handler	@ControllerAdvice for consistent errors
4	OpenAPI/Swagger	Automatic API documentation
5	Liquibase instead of Flyway	Better rollback support
6	Auditing	@CreatedBy, @LastModifiedBy
4.4 Positive Surprises
Technology	Surprise
✨ Testcontainers	Integration tests with a real DB are very straightforward
✨ Spring Security	After overcoming the learning curve, the configuration is elegant
✨ JPA Named Queries	More readable than JPQL in annotations
Authors

    Mykhailo Plokhin

    Ivan Shestachenko
