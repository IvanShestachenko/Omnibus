-- USERS (password: password123)
INSERT INTO "user" (first_name, last_name, email, password_hash, phone, role, created_at, updated_at) VALUES
                                                                                                          ('Admin', 'System', 'admin@bus2holiday.com','$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420111222333', 'admin', NOW(), NOW()),
                                                                                                          ('John', 'Doe', 'john@example.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420444555666', 'user', NOW(), NOW()),
                                                                                                          ('Jane', 'Smith', 'jane@example.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420777888999', 'user', NOW(), NOW()),
                                                                                                          ('Driver', 'One', 'driver1@bus2holiday.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420123123123', 'driver', NOW(), NOW()),
                                                                                                          ('Driver', 'Two', 'driver2@bus2holiday.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420456456456', 'driver', NOW(), NOW());


INSERT INTO "user" (first_name, last_name, email, password_hash, phone, role, created_at, updated_at)
VALUES ('Admin', 'System', 'admin@bus2holiday.com',
        '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG',
        '+420000000000', 'admin', NOW(), NOW())

ON CONFLICT (email) DO NOTHING;

-- DRIVERS
INSERT INTO driver (user_id, license_number, license_expiry, is_available, created_at)
SELECT id, 'DL-001-2024', '2026-12-31', true, NOW()
FROM "user" WHERE email = 'driver1@bus2holiday.com'
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO driver (user_id, license_number, license_expiry, is_available, created_at)
SELECT id, 'DL-002-2024', '2027-06-30', true, NOW()
FROM "user" WHERE email = 'driver2@bus2holiday.com'
ON CONFLICT (user_id) DO NOTHING;

-- TERMINALS
INSERT INTO terminal (name, city, country, street, building_number, postcode, latitude, longitude, created_at) VALUES
                                                                                                                   ('Prague Main Station', 'Prague', 'Czech Republic', 'Wilsonova', '300/8', '11000', 50.0833, 14.4333, NOW()),
                                                                                                                   ('Brno Central', 'Brno', 'Czech Republic', 'Benešova', '10', '60200', 49.1951, 16.6068, NOW()),
                                                                                                                   ('Vienna International', 'Vienna', 'Austria', 'Erdbergstraße', '200', '1030', 48.1920, 16.3920, NOW()),
                                                                                                                   ('Budapest Népliget', 'Budapest', 'Hungary', 'Üllői út', '131', '1091', 47.4767, 19.0850, NOW()),
                                                                                                                   ('Bratislava Mlynské Nivy', 'Bratislava', 'Slovakia', 'Mlynské nivy', '31', '82109', 48.1486, 17.1377, NOW())
ON CONFLICT DO NOTHING;

-- BUSES
INSERT INTO bus (registration_number, model, manufacturer, year, total_seats, seat_layout, status, created_at, updated_at) VALUES
                                                                                                                               ('1A2-3456', 'Tourismo 15 RHD', 'Mercedes-Benz', 2022, 50, '{"rows": 12, "seatsPerRow": 4, "layout": "2+2"}', 'ACTIVE', NOW(), NOW()),
                                                                                                                               ('2B3-4567', 'VDL Futura FHD2', 'VDL', 2021, 55, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2"}', 'ACTIVE', NOW(), NOW()),
                                                                                                                               ('3C4-5678', 'Neoplan Cityliner', 'Neoplan', 2020, 48, '{"rows": 12, "seatsPerRow": 4, "layout": "2+2"}', 'ACTIVE', NOW(), NOW()),
                                                                                                                               ('4D5-6789', 'Setra S 516 HD', 'Setra', 2023, 52, '{"rows": 13, "seatsPerRow": 4, "layout": "2+2"}', 'MAINTENANCE', NOW(), NOW())
ON CONFLICT (registration_number) DO NOTHING;

-- ROUTES
INSERT INTO route (name, is_active, created_at, updated_at) VALUES
                                                                ('Prague - Brno', true, NOW(), NOW()),
                                                                ('Prague - Vienna', true, NOW(), NOW()),
                                                                ('Prague - Budapest', true, NOW(), NOW()),
                                                                ('Brno - Bratislava', true, NOW(), NOW()),
                                                                ('Vienna - Budapest', false, NOW(), NOW())
ON CONFLICT DO NOTHING;

-- ROUTE STOPS
-- 1. Route: Prague - Brno
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin)
SELECT r.id, t.id, 1, 0, 0, 0
FROM route r, terminal t WHERE r.name = 'Prague - Brno' AND t.name = 'Prague Main Station'
ON CONFLICT DO NOTHING;

INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin)
SELECT r.id, t.id, 2, 150, 150, 205
FROM route r, terminal t WHERE r.name = 'Prague - Brno' AND t.name = 'Brno Central'
ON CONFLICT DO NOTHING;

-- 2. Route: Prague - Vienna
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin)
SELECT r.id, t.id, 1, 0, 0, 0
FROM route r, terminal t WHERE r.name = 'Prague - Vienna' AND t.name = 'Prague Main Station'
ON CONFLICT DO NOTHING;

INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin)
SELECT r.id, t.id, 2, 120, 130, 205
FROM route r, terminal t WHERE r.name = 'Prague - Vienna' AND t.name = 'Brno Central'
ON CONFLICT DO NOTHING;

INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin)
SELECT r.id, t.id, 3, 240, 240, 335
FROM route r, terminal t WHERE r.name = 'Prague - Vienna' AND t.name = 'Vienna International'
ON CONFLICT DO NOTHING;

-- TRIPS
INSERT INTO trip (route_id, bus_id, driver_id, price, departure_datetime, arrival_datetime, status, created_at, updated_at)
SELECT
    r.id, b.id, d.user_id, 19.99,
    NOW() + INTERVAL '1 day' + TIME '08:00:00',
    NOW() + INTERVAL '1 day' + TIME '10:30:00',
    'SCHEDULED', NOW(), NOW()
FROM route r, bus b, driver d
WHERE r.name = 'Prague - Brno' AND b.registration_number = '1A2-3456' AND d.license_number = 'DL-001-2024'
ON CONFLICT DO NOTHING;

INSERT INTO trip (route_id, bus_id, driver_id, price, departure_datetime, arrival_datetime, status, created_at, updated_at)
SELECT
    r.id, b.id, d.user_id, 29.99,
    NOW() + INTERVAL '2 days' + TIME '09:00:00',
    NOW() + INTERVAL '2 days' + TIME '13:00:00',
    'SCHEDULED', NOW(), NOW()
FROM route r, bus b, driver d
WHERE r.name = 'Prague - Vienna' AND b.registration_number = '2B3-4567' AND d.license_number = 'DL-002-2024'
ON CONFLICT DO NOTHING;

INSERT INTO trip (route_id, bus_id, driver_id, price, departure_datetime, arrival_datetime, status, created_at, updated_at)
SELECT
    r.id, b.id, d.user_id, 24.99,
    NOW() + INTERVAL '3 days' + TIME '08:00:00',
    NOW() + INTERVAL '3 days' + TIME '10:30:00',
    'SCHEDULED', NOW(), NOW()
FROM route r, bus b, driver d
WHERE r.name = 'Prague - Brno' AND b.registration_number = '3C4-5678' AND d.license_number = 'DL-001-2024'
ON CONFLICT DO NOTHING;
