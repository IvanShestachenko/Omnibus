-- Ensure PostgreSQL enum types exist using single-quoted DO blocks to prevent Spring parser splits
DO '
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = ''user_role'') THEN
        CREATE TYPE user_role AS ENUM (''user'', ''driver'', ''admin'');
    END IF;
END
';

DO '
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = ''bus_status'') THEN
        CREATE TYPE bus_status AS ENUM (''ACTIVE'', ''MAINTENANCE'', ''RETIRED'');
    END IF;
END
';

DO '
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = ''trip_status'') THEN
        CREATE TYPE trip_status AS ENUM (''SCHEDULED'', ''IN_PROGRESS'', ''COMPLETED'', ''CANCELLED'');
    END IF;
END
';

DO '
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = ''reservation_status'') THEN
        CREATE TYPE reservation_status AS ENUM (''PENDING'', ''CONFIRMED'', ''CANCELLED'', ''COMPLETED'', ''EXPIRED'');
    END IF;
END
';

DO '
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = ''payment_status'') THEN
        CREATE TYPE payment_status AS ENUM (''PENDING'', ''PROCESSING'', ''COMPLETED'', ''FAILED'', ''REFUNDED'', ''CANCELLED'');
    END IF;
END
';

-- Ensure enum columns exist in their respective tables if they were missed by Hibernate update
DO '
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = ''user'') THEN
        IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = ''user'' AND column_name = ''role'') THEN
            ALTER TABLE "user" ADD COLUMN role user_role NOT NULL DEFAULT ''user'';
        END IF;
    END IF;
END
';

DO '
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = ''bus'') THEN
        IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = ''bus'' AND column_name = ''status'') THEN
            ALTER TABLE bus ADD COLUMN status bus_status NOT NULL DEFAULT ''ACTIVE'';
        END IF;
    END IF;
END
';

DO '
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = ''trip'') THEN
        IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = ''trip'' AND column_name = ''status'') THEN
            ALTER TABLE trip ADD COLUMN status trip_status NOT NULL DEFAULT ''SCHEDULED'';
        END IF;
    END IF;
END
';

DO '
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = ''reservation'') THEN
        IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = ''reservation'' AND column_name = ''status'') THEN
            ALTER TABLE reservation ADD COLUMN status reservation_status NOT NULL DEFAULT ''PENDING'';
        END IF;
    END IF;
END
';

DO '
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = ''payment'') THEN
        IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = ''payment'' AND column_name = ''status'') THEN
            ALTER TABLE payment ADD COLUMN status payment_status NOT NULL DEFAULT ''PENDING'';
        END IF;
    END IF;
END
';
