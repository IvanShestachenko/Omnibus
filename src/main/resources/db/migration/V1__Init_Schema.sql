CREATE EXTENSION IF NOT EXISTS btree_gist;
CREATE TYPE user_role AS ENUM ('user', 'driver', 'admin');
CREATE TYPE trip_status AS ENUM ('SCHEDULED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED');
CREATE TYPE reservation_status AS ENUM ('PENDING', 'CONFIRMED', 'CANCELLED', 'COMPLETED', 'EXPIRED');
CREATE TYPE payment_status AS ENUM ('PENDING', 'PROCESSING', 'COMPLETED', 'FAILED', 'REFUNDED', 'CANCELLED');
CREATE TYPE bus_status AS ENUM ('ACTIVE', 'MAINTENANCE', 'RETIRED');


CREATE TABLE IF NOT EXISTS "user" (
                                      "id" BIGSERIAL PRIMARY KEY,
                                      "email" VARCHAR(255) NOT NULL UNIQUE,
                                      "password_hash" VARCHAR(255) NOT NULL,
                                      "phone" VARCHAR(20) UNIQUE,
                                      "first_name" VARCHAR(100) NOT NULL,
                                      "last_name" VARCHAR(100) NOT NULL,
                                      "role" user_role NOT NULL DEFAULT 'user',
                                      "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
                                      "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS driver (
                                      "user_id" BIGINT PRIMARY KEY REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE,
                                      "license_number" VARCHAR(50) NOT NULL UNIQUE,
                                      "license_expiry" DATE NOT NULL CHECK (license_expiry > CURRENT_DATE),
                                      "is_available" BOOLEAN NOT NULL DEFAULT TRUE,
                                      "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS bus (
                                   "id" BIGSERIAL PRIMARY KEY,
                                   "model" VARCHAR(100) NOT NULL,
                                   "registration_number" VARCHAR(20) NOT NULL UNIQUE,
                                   "manufacturer" VARCHAR(100) NOT NULL,
                                   "year" SMALLINT NOT NULL CHECK ("year" BETWEEN 1980 AND EXTRACT(YEAR FROM NOW())::SMALLINT),
                                   "total_seats" INT NOT NULL CHECK ("total_seats" > 0),
                                   "seat_layout" JSONB NOT NULL CHECK (jsonb_typeof("seat_layout") = 'object'),
                                   "status" bus_status NOT NULL DEFAULT 'ACTIVE',
                                   "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
                                   "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS route (
                                     "id" BIGSERIAL PRIMARY KEY,
                                     "name" VARCHAR(255) NOT NULL,
                                     "is_active" BOOLEAN NOT NULL DEFAULT TRUE,
                                     "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
                                     "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS buses_on_routes (
                                               "bus_id" BIGINT NOT NULL REFERENCES bus("id") ON DELETE CASCADE ON UPDATE CASCADE,
                                               "route_id" BIGINT NOT NULL REFERENCES route("id") ON DELETE CASCADE ON UPDATE CASCADE,
                                               PRIMARY KEY ("bus_id", "route_id")
);

CREATE TABLE IF NOT EXISTS terminal (
                                        "id" BIGSERIAL PRIMARY KEY,
                                        "country" VARCHAR(100) NOT NULL,
                                        "city" VARCHAR(100) NOT NULL,
                                        "street" VARCHAR(255) NOT NULL,
                                        "building_number" VARCHAR(20) NOT NULL,
                                        "postcode" VARCHAR(20) NOT NULL,
                                        "name" VARCHAR(255),
                                        "latitude" NUMERIC(10,8) NOT NULL,
                                        "longitude" NUMERIC(11,8) NOT NULL,
                                        "is_main" BOOLEAN NOT NULL DEFAULT FALSE,
                                        "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS route_stop (
                                          "id" BIGSERIAL PRIMARY KEY,
                                          "route_id" BIGINT NOT NULL REFERENCES route("id") ON DELETE CASCADE ON UPDATE CASCADE,
                                          "sequence_order" INT NOT NULL CHECK ("sequence_order" > 0),
                                          "arrival_offset_minutes" INT NOT NULL CHECK ("arrival_offset_minutes" >= 0),
                                          "departure_offset_minutes" INT NOT NULL CHECK ("departure_offset_minutes" >= 0),
                                          "terminal_id" BIGINT NOT NULL REFERENCES terminal("id") ON DELETE RESTRICT ON UPDATE CASCADE,
                                          "distance_from_origin" NUMERIC(8,2) NOT NULL CHECK ("distance_from_origin" >= 0),
                                          UNIQUE ("route_id", "sequence_order")
);

CREATE TABLE IF NOT EXISTS trip (
                                    "id" BIGSERIAL PRIMARY KEY,
                                    "route_id" BIGINT NOT NULL REFERENCES route("id") ON DELETE CASCADE ON UPDATE CASCADE,
                                    "bus_id" BIGINT NOT NULL REFERENCES bus("id") ON DELETE RESTRICT ON UPDATE CASCADE,
                                    "driver_id" BIGINT NULL REFERENCES driver("user_id") ON DELETE SET NULL ON UPDATE CASCADE,
                                    "price" NUMERIC(10,2) NOT NULL CHECK ("price" >= 0),
                                    "departure_datetime" TIMESTAMPTZ NOT NULL,
                                    "arrival_datetime" TIMESTAMPTZ NOT NULL CHECK ("arrival_datetime" > "departure_datetime"),
                                    "status" trip_status NOT NULL DEFAULT 'SCHEDULED',
                                    "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
                                    "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS reservation (
                                           "id" BIGSERIAL PRIMARY KEY,
                                           "user_id" BIGINT NOT NULL REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE,
                                           "trip_id" BIGINT NOT NULL REFERENCES trip("id") ON DELETE CASCADE ON UPDATE CASCADE,
                                           "booking_reference" VARCHAR(20) NOT NULL UNIQUE,
                                           "total_amount" NUMERIC(10,2) NOT NULL CHECK ("total_amount" >= 0),
                                           "status" reservation_status NOT NULL DEFAULT 'PENDING',
                                           "booking_date" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
                                           "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
                                           "updated_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


CREATE TABLE IF NOT EXISTS reservation_passenger (
                                                     "id" BIGSERIAL PRIMARY KEY,
                                                     "reservation_id" BIGINT NOT NULL REFERENCES reservation("id") ON DELETE CASCADE ON UPDATE CASCADE,
                                                     "first_name" VARCHAR(100) NOT NULL,
                                                     "last_name" VARCHAR(100) NOT NULL,
                                                     "is_checked_in" BOOLEAN NOT NULL DEFAULT FALSE
);


CREATE TABLE IF NOT EXISTS booked_segment (
                                              "id" BIGSERIAL PRIMARY KEY,
                                              "trip_id" BIGINT NOT NULL REFERENCES trip("id") ON DELETE CASCADE ON UPDATE CASCADE,
                                              "passenger_id" BIGINT NOT NULL REFERENCES reservation_passenger("id") ON DELETE CASCADE ON UPDATE CASCADE,
                                              "seat_number" VARCHAR(10) NOT NULL,

                                              "from_stop_id" BIGINT NOT NULL REFERENCES route_stop("id") ON DELETE RESTRICT ON UPDATE CASCADE,

                                              "from_stop_order" INT NOT NULL,
                                              "to_stop_order" INT NOT NULL
);

CREATE TABLE IF NOT EXISTS payment (
                                       "id" BIGSERIAL PRIMARY KEY,
                                       "amount" NUMERIC(10,2) NOT NULL CHECK ("amount" >= 0),
                                       "currency" VARCHAR(3) NOT NULL DEFAULT 'CZK',
                                       "transaction_id" VARCHAR(255) NOT NULL UNIQUE,
                                       "status" payment_status NOT NULL DEFAULT 'PENDING',
                                       "paid_at" TIMESTAMPTZ,
                                       "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
                                       "reservation_id" BIGINT NOT NULL REFERENCES reservation("id") ON DELETE CASCADE ON UPDATE CASCADE,
                                       "user_id" BIGINT NOT NULL REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE,
                                       "gateway_response" JSONB NOT NULL DEFAULT '{}'::jsonb CHECK (jsonb_typeof("gateway_response") = 'object')
);


CREATE INDEX IF NOT EXISTS idx_trip_route ON trip ("route_id", "departure_datetime");
CREATE INDEX IF NOT EXISTS idx_trip_status ON trip ("status");
CREATE INDEX IF NOT EXISTS idx_reservation_user ON reservation ("user_id");
CREATE INDEX IF NOT EXISTS idx_reservation_status ON reservation ("status");
CREATE INDEX IF NOT EXISTS idx_payment_user ON payment ("user_id", "status");
CREATE INDEX IF NOT EXISTS idx_route_stop_route ON route_stop ("route_id");
CREATE INDEX IF NOT EXISTS idx_driver_availability ON driver ("is_available");
CREATE INDEX IF NOT EXISTS idx_bus_status ON bus ("status");
CREATE INDEX IF NOT EXISTS idx_terminal_location ON terminal ("city", "latitude", "longitude");
