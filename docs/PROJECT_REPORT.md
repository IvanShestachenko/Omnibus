# Bus2Holiday - Zpráva o projektu

## Popis aplikace

**Bus2Holiday** je podnikový informační systém pro autobusovou dopravní společnost, inspirovaný službou FlixBus. Jedná se o čistě backendovou REST API aplikaci implementovanou v Javě pomocí Spring Boot frameworku.

### Architektura
Aplikace využívá vícevrstvou architekturu:
- **Controller** – REST API endpointy
- **Service** – Business logika s transakčním zpracováním
- **Repository (DAO)** – Přístup k datům pomocí Spring Data JPA
- **Model** – JPA entity mapované na PostgreSQL databázi

### Hlavní funkce
- **Správa uživatelů** – registrace, přihlášení, JWT autentizace
- **Správa autobusů a tras** – CRUD operace (pouze admin)
- **Rezervace jízdenek** – výběr sedadel, platba, zrušení
- **Řidičský modul** – přehled přidělených spojů

### Použité techniky persistence (3+)
1. **@OrderBy** – řazení zastávek na trase podle `sequenceOrder`
2. **@NamedQuery** – pojmenované dotazy pro User, Trip, Route, Terminal
3. **Cascade persist/remove** – automatické ukládání ReservationPassenger a BookedSegment při vytvoření rezervace

### Bezpečnost
- JWT token autentizace
- Role-based access control: `ROLE_ADMIN`, `ROLE_USER`, `ROLE_DRIVER`
- Method-level security pomocí `@PreAuthorize`

---

## Instalace a spuštění

### Požadavky
- Java 17+
- Maven 3.8+
- PostgreSQL 15+ (nebo Docker)

### Spuštění pomocí Docker Compose
```bash
# Spuštění PostgreSQL databáze
docker-compose up -d

# Build a spuštění aplikace
mvn clean package
java -jar target/bus2holiday-0.0.1-SNAPSHOT.jar
```

### Konfigurace
Upravte `application.properties` nebo nastavte environment proměnné:
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/bus2holiday
spring.datasource.username=postgres
spring.datasource.password=postgres
```

### Testovací data
Pro testování lze použít Postman kolekci v adresáři `/postman`:
1. Importujte `Bus2Holiday_API.postman_collection.json` do Postmanu
2. Vytvořte admin uživatele v databázi (role=admin)
3. Spusťte jednotlivé scénáře

### Spuštění testů
```bash
mvn clean test
```

---

## Získané zkušenosti

### JWT autentizace se Spring Security
**Výhody:** Stateless autentizace, snadná integrace s REST API, škálovatelnost.
**Nevýhody:** Komplexní konfigurace, nutnost správně řešit expiraci tokenů.
**Problém:** Konfigurace `SecurityFilterChain` vyžadovala pochopení pořadí filtrů.

### Cascade operace v JPA
**Výhody:** Zjednodušení kódu – není nutné ručně persistovat navázané entity.
**Nevýhody:** Může vést k neočekávanému chování při nesprávné konfiguraci.
**Problém:** `CascadeType.ALL` na obou stranách vztahu způsoboval `ObjectOptimisticLockingFailureException`.

### @MapsId pro sdílený primární klíč (Driver-User)
**Zkušenost:** Implementace vztahu 1:1, kde Driver používá stejné ID jako User, vyžadovala správné pochopení `@MapsId` a odstranění redundantního nastavování ID.

### Testcontainers pro integrační testy
**Výhody:** Reálná PostgreSQL databáze v testech, nezávislost na lokálním prostředí.
**Nevýhody:** Pomalejší testy kvůli startu kontejnerů.

### Named Queries vs. Repository metody
**Zjištění:** Pro jednoduché dotazy jsou Spring Data repository metody elegantnější. `@NamedQuery` je vhodnější pro složitější JPQL dotazy, které se často opakují.

---

## Autoři
- Mykhailo Plokhin
- Ivan Shestachenko

## Technologie
- Java 17, Spring Boot 3.x, Spring Security, Spring Data JPA
- PostgreSQL, Docker, Maven
- JUnit 5, Mockito, Testcontainers
