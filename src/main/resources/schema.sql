-- Create PostgreSQL enum types BEFORE Hibernate DDL runs.
-- These are executed via script-then-metadata: script first, then Hibernate generates tables.
-- DROP CASCADE is safe here because Hibernate hasn't created tables yet.

DROP TYPE IF EXISTS user_role CASCADE;
CREATE TYPE user_role AS ENUM ('user', 'driver', 'admin');

DROP TYPE IF EXISTS bus_status CASCADE;
CREATE TYPE bus_status AS ENUM ('ACTIVE', 'MAINTENANCE', 'RETIRED');

DROP TYPE IF EXISTS trip_status CASCADE;
CREATE TYPE trip_status AS ENUM ('SCHEDULED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED');

DROP TYPE IF EXISTS reservation_status CASCADE;
CREATE TYPE reservation_status AS ENUM ('PENDING', 'CONFIRMED', 'CANCELLED', 'COMPLETED', 'EXPIRED');

DROP TYPE IF EXISTS payment_status CASCADE;
CREATE TYPE payment_status AS ENUM ('PENDING', 'PROCESSING', 'COMPLETED', 'FAILED', 'REFUNDED', 'CANCELLED');
