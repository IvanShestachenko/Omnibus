-- USERS (password: password123)
INSERT INTO "user" (first_name, last_name, email, password_hash, phone, role, created_at, updated_at) VALUES
    ('Admin', 'System', 'admin@bus2holiday.com','$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420111222333', 'admin', NOW(), NOW()),
    ('John', 'Doe', 'john@example.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420444555666', 'user', NOW(), NOW()),
    ('Jane', 'Smith', 'jane@example.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420777888999', 'user', NOW(), NOW()),
    ('Driver', 'One', 'driver1@bus2holiday.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420123123123', 'driver', NOW(), NOW()),
    ('Driver', 'Two', 'driver2@bus2holiday.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420456456456', 'driver', NOW(), NOW())
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

-- TERMINALS (159 terminals in 121 cities)
INSERT INTO terminal (name, city, country, street, building_number, postcode, latitude, longitude, created_at) VALUES
    ('Prague Main Station', 'Prague', 'Czech Republic', 'Wilsonova', '300/8', '11000', 50.0833, 14.4333, NOW()),
    ('Prague Florenc', 'Prague', 'Czech Republic', 'Pod výtopnou', '13/10', '18600', 50.0895, 14.4402, NOW()),
    ('Prague Na Knížecí', 'Prague', 'Czech Republic', 'Nádražní', '25', '15000', 50.0682, 14.4053, NOW()),
    ('Brno Central', 'Brno', 'Czech Republic', 'Benešova', '10', '60200', 49.1951, 16.6068, NOW()),
    ('Brno Zvonařka', 'Brno', 'Czech Republic', 'Zvonařka', '411', '60200', 49.1865, 16.6152, NOW()),
    ('Ostrava Svinov', 'Ostrava', 'Czech Republic', 'Peterkova', '79', '72100', 49.8211, 18.2091, NOW()),
    ('Ostrava Central', 'Ostrava', 'Czech Republic', 'Vítkovická', '3', '70200', 49.8291, 18.2812, NOW()),
    ('Plzeň Central', 'Plzeň', 'Czech Republic', 'Husova', '2', '30100', 49.7468, 13.3675, NOW()),
    ('Liberec Central', 'Liberec', 'Czech Republic', 'Žitavská', '12', '46007', 50.7615, 15.0511, NOW()),
    ('Olomouc Central', 'Olomouc', 'Czech Republic', 'Sladkovského', '31', '77900', 49.5912, 17.2785, NOW()),
    ('Vienna International', 'Vienna', 'Austria', 'Erdbergstraße', '200', '1030', 48.1920, 16.3920, NOW()),
    ('Vienna Hauptbahnhof', 'Vienna', 'Austria', 'Wiedner Gürtel', '14', '1100', 48.1852, 16.3761, NOW()),
    ('Vienna Westbahnhof', 'Vienna', 'Austria', 'Europaplatz', '2', '1150', 48.1968, 16.3375, NOW()),
    ('Salzburg Central', 'Salzburg', 'Austria', 'Südtiroler Platz', '1', '5020', 47.8128, 13.0456, NOW()),
    ('Graz Central', 'Graz', 'Austria', 'Europaplatz', '4', '8020', 47.0728, 15.4167, NOW()),
    ('Innsbruck Central', 'Innsbruck', 'Austria', 'Südtiroler Platz', '7', '6020', 47.2631, 11.4011, NOW()),
    ('Budapest Népliget', 'Budapest', 'Hungary', 'Üllői út', '131', '1091', 47.4767, 19.0850, NOW()),
    ('Budapest Kelenfold', 'Budapest', 'Hungary', 'Etele tér', '7', '1119', 47.4645, 19.0221, NOW()),
    ('Budapest Stadionok', 'Budapest', 'Hungary', 'Hungária körút', '48', '1143', 47.5011, 19.1022, NOW()),
    ('Debrecen Bus Station', 'Debrecen', 'Hungary', 'Külsővásártér', '12', '4025', 47.5256, 21.6192, NOW()),
    ('Szeged Bus Station', 'Szeged', 'Hungary', 'Mars tér', '5', '6724', 46.2582, 20.1412, NOW()),
    ('Pecs Bus Station', 'Pecs', 'Hungary', 'Nagy Lajos király útja', '16', '7622', 46.0712, 18.2301, NOW()),
    ('Bratislava Mlynské Nivy', 'Bratislava', 'Slovakia', 'Mlynské nivy', '31', '82109', 48.1486, 17.1377, NOW()),
    ('Bratislava Petrzalka', 'Bratislava', 'Slovakia', 'Einsteinova', '18', '85101', 48.1315, 17.1001, NOW()),
    ('Košice Bus Station', 'Košice', 'Slovakia', 'Staničné námestie', '9', '04001', 48.7212, 21.2675, NOW()),
    ('Zilina Bus Station', 'Zilina', 'Slovakia', 'M. R. Štefánika', '56', '01001', 49.2234, 18.7456, NOW()),
    ('Warsaw Zachodnia', 'Warsaw', 'Poland', 'Al. Jerozolimskie', '144', '02-305', 52.2189, 20.9652, NOW()),
    ('Warsaw Wschodnia', 'Warsaw', 'Poland', 'Lubelska', '22', '03-802', 52.2515, 21.0612, NOW()),
    ('Warsaw Central', 'Warsaw', 'Poland', 'Al. Jerozolimskie', '54', '00-024', 52.2289, 21.0035, NOW()),
    ('Kraków Central', 'Kraków', 'Poland', 'Bosacka', '18', '31-505', 50.0685, 19.9492, NOW()),
    ('Gdańsk Central', 'Gdańsk', 'Poland', '3 Maja', '12', '80-802', 54.3541, 18.6433, NOW()),
    ('Wrocław Central', 'Wrocław', 'Poland', 'Sucha', '1', '50-086', 51.0975, 17.0333, NOW()),
    ('Poznań Central', 'Poznań', 'Poland', 'Stanisława Matyi', '2', '61-586', 52.4012, 16.9189, NOW()),
    ('Katowice Sadowa', 'Katowice', 'Poland', 'Sądowa', '5', '40-078', 50.2592, 19.0112, NOW()),
    ('Łódź Fabryczna', 'Łódź', 'Poland', 'Plac Bronisława Sałacińskiego', '1', '90-001', 51.7695, 19.4682, NOW()),
    ('Szczecin Central', 'Szczecin', 'Poland', 'Plac Grodnicki', '1', '70-220', 53.4189, 14.5501, NOW()),
    ('Berlin ZOB', 'Berlin', 'Germany', 'Masurenallee', '4', '14057', 52.5075, 13.2792, NOW()),
    ('Berlin Ostbahnhof', 'Berlin', 'Germany', 'Koppenstraße', '3', '10243', 52.5103, 13.4344, NOW()),
    ('Berlin Sudkreuz', 'Berlin', 'Germany', 'General-Pape-Straße', '1', '12101', 52.4761, 13.3642, NOW()),
    ('Munich ZOB', 'Munich', 'Germany', 'Arnulfstraße', '21', '80335', 48.1425, 11.5492, NOW()),
    ('Munich Frottmaning', 'Munich', 'Germany', 'Werner-Heisenberg-Allee', '21', '80939', 48.2201, 11.6312, NOW()),
    ('Hamburg ZOB', 'Hamburg', 'Germany', 'Adenauerallee', '78', '20097', 53.5522, 10.0133, NOW()),
    ('Frankfurt Central', 'Frankfurt', 'Germany', 'Stuttgarter Straße', '26', '60329', 50.1039, 8.6621, NOW()),
    ('Frankfurt Airport', 'Frankfurt', 'Germany', 'Hugo-Eckener-Ring', '1', '60549', 50.0515, 8.5701, NOW()),
    ('Cologne Central', 'Cologne', 'Germany', 'Breslauer Platz', '1', '50668', 50.9429, 6.9602, NOW()),
    ('Cologne Airport', 'Cologne', 'Germany', 'Waldstraße', '247', '51147', 50.8791, 7.1205, NOW()),
    ('Stuttgart Airport', 'Stuttgart', 'Germany', 'Busterminal Messe Ost', '1', '70629', 48.6922, 9.1956, NOW()),
    ('Stuttgart Oberturkheim', 'Stuttgart', 'Germany', 'Im Degen', '3', '70327', 48.7761, 9.2701, NOW()),
    ('Dresden Central', 'Dresden', 'Germany', 'Bayrische Straße', '14', '01069', 51.0392, 13.7322, NOW()),
    ('Nuremberg Central', 'Nuremberg', 'Germany', 'Adbertstraße', '2', '90402', 49.4461, 11.0822, NOW()),
    ('Leipzig Central', 'Leipzig', 'Germany', 'Brandenburger Straße', '2', '04103', 51.3452, 12.3842, NOW()),
    ('Dusseldorf Central', 'Dusseldorf', 'Germany', 'Worringer Straße', '1', '40210', 51.2268, 6.7952, NOW()),
    ('Bremen Central', 'Bremen', 'Germany', 'Breitenweg', '3', '28195', 53.0829, 8.8142, NOW()),
    ('Hanover Central', 'Hanover', 'Germany', 'Rundestraße', '12', '30161', 52.3789, 9.7429, NOW()),
    ('Paris Bercy Seine', 'Paris', 'France', 'Rue de Bercy', '210', '75012', 48.8356, 2.3802, NOW()),
    ('Paris Gallieni', 'Paris', 'France', 'Avenue du Général de Gaulle', '28', '93170', 48.8641, 2.4189, NOW()),
    ('Paris Pont de Levallois', 'Paris', 'France', 'Place du Maréchal de Lattre de Tassigny', '1', '92300', 48.8982, 2.2885, NOW()),
    ('Marseille Saint-Charles', 'Marseille', 'France', 'Square Narvik', '1', '13001', 43.3028, 5.3805, NOW()),
    ('Marseille Airport', 'Marseille', 'France', 'Busterminal MP2', '1', '13727', 43.4362, 5.2152, NOW()),
    ('Lyon Perrache', 'Lyon', 'France', 'Cours de Verdun', '14', '69002', 45.7489, 4.8252, NOW()),
    ('Lyon Part-Dieu', 'Lyon', 'France', 'Rue de la Villette', '18', '69003', 45.7602, 4.8601, NOW()),
    ('Toulouse Central', 'Toulouse', 'France', 'Boulevard Pierre Semard', '64', '31500', 43.6128, 1.4542, NOW()),
    ('Nice Airport', 'Nice', 'France', 'Terminal 1 Bus Station', '1', '06200', 43.6652, 7.2152, NOW()),
    ('Nice Central', 'Nice', 'France', 'Avenue Thiers', '10', '06000', 43.7042, 7.2612, NOW()),
    ('Strasbourg Place de l''Etoile', 'Strasbourg', 'France', 'Place de l''Étoile', '1', '67000', 48.5742, 7.7522, NOW()),
    ('Bordeaux Saint-Jean', 'Bordeaux', 'France', 'Rue Charles Domercq', '137', '33800', 44.8256, -0.5562, NOW()),
    ('Lille Europe', 'Lille', 'France', 'Boulevard de Turin', '1', '59777', 50.6392, 3.0752, NOW()),
    ('Nantes Central', 'Nantes', 'France', 'Route de Paris', '21', '44300', 47.2412, -1.5202, NOW()),
    ('Madrid Estacion Sur', 'Madrid', 'Spain', 'Calle de Méndez Álvaro', '83', '28045', 40.3956, -3.6792, NOW()),
    ('Madrid Avenida de America', 'Madrid', 'Spain', 'Avenida de América', '9', '28002', 40.4382, -3.6761, NOW()),
    ('Madrid Aeropuerto Barajas', 'Madrid', 'Spain', 'Terminal 4 Bus Area', '1', '28042', 40.4912, -3.5932, NOW()),
    ('Barcelona Nord', 'Barcelona', 'Spain', 'Carrer d''Alí Bei', '80', '08013', 41.3934, 2.1822, NOW()),
    ('Barcelona Sants', 'Barcelona', 'Spain', 'Carrer de Viriat', '12', '08014', 41.3792, 2.1402, NOW()),
    ('Valencia Central', 'Valencia', 'Spain', 'Carrer de Menéndez Pidal', '11', '46009', 39.4801, -0.3892, NOW()),
    ('Seville Plaza de Armas', 'Seville', 'Spain', 'Avenida de Cristo de la Expiración', '2', '41001', 37.3912, -6.0022, NOW()),
    ('Zaragoza Delicias', 'Zaragoza', 'Spain', 'Avenida de Navarra', '180', '50011', 41.6592, -0.9122, NOW()),
    ('Malaga Central', 'Malaga', 'Spain', 'Paseo de los Tilos', '21', '29006', 36.7128, -4.4322, NOW()),
    ('Bilbao Intermodal', 'Bilbao', 'Spain', 'Gurtubay Kalea', '1', '48013', 43.2612, -2.9502, NOW()),
    ('Riga Bus Station', 'Riga', 'Latvia', 'Prāgas iela', '1', 'LV-1050', 56.9456, 24.1152, NOW()),
    ('Riga Airport', 'Riga', 'Latvia', 'Mārupes pagasts', '1', 'LV-1053', 56.9228, 23.9782, NOW()),
    ('Daugavpils Bus Station', 'Daugavpils', 'Latvia', 'Viestura iela', '10', 'LV-5401', 55.8712, 26.5201, NOW()),
    ('Liepaja Bus Station', 'Liepaja', 'Latvia', 'Rīgas iela', '71', 'LV-3401', 56.5189, 21.0152, NOW()),
    ('Vilnius Bus Station', 'Vilnius', 'Lithuania', 'Sodų g.', '22', 'LT-03211', 54.6712, 25.2822, NOW()),
    ('Vilnius Airport', 'Vilnius', 'Lithuania', 'Rodūnios kelias', '10', 'LT-02189', 54.6428, 25.2782, NOW()),
    ('Kaunas Bus Station', 'Kaunas', 'Lithuania', 'Vytauto pr.', '24', 'LT-44355', 54.8892, 23.9292, NOW()),
    ('Klaipeda Bus Station', 'Klaipeda', 'Lithuania', 'Butkų Juzės g.', '9', 'LT-92228', 55.7189, 21.1456, NOW()),
    ('Sofia Central Bus Station', 'Sofia', 'Bulgaria', 'Knyaginya Maria Luiza Blvd', '100', '1202', 42.7128, 23.3212, NOW()),
    ('Sofia Serdika', 'Sofia', 'Bulgaria', 'Pl. Predgarov', '1', '1202', 42.7115, 23.3201, NOW()),
    ('Plovdiv South Bus Station', 'Plovdiv', 'Bulgaria', 'Hristo Botev Blvd', '47', '4000', 42.1382, 24.7492, NOW()),
    ('Varna Bus Station', 'Varna', 'Bulgaria', 'Vladislav Varnenchik Blvd', '158', '9000', 43.2189, 27.8992, NOW()),
    ('Zagreb Bus Station', 'Zagreb', 'Croatia', 'Avenija Marina Držića', '4', '10000', 45.8042, 15.9968, NOW()),
    ('Split Bus Station', 'Split', 'Croatia', 'Obala Kneza Domagoja', '12', '21000', 43.5042, 16.4429, NOW()),
    ('Dubrovnik Bus Station', 'Dubrovnik', 'Croatia', 'Obala Ivana Pavla II', '44', '20000', 42.6612, 18.0805, NOW()),
    ('Rijeka Bus Station', 'Rijeka', 'Croatia', 'Trg Žabica', '1', '51000', 45.3289, 14.4377, NOW()),
    ('Ljubljana Bus Station', 'Ljubljana', 'Slovenia', 'Trg Osvobodilne Fronte', '4', '1000', 46.0582, 14.5112, NOW()),
    ('Maribor Bus Station', 'Maribor', 'Slovenia', 'Mlinska ulica', '1', '2000', 46.5592, 15.6542, NOW()),
    ('Koper Bus Station', 'Koper', 'Slovenia', 'Kolodvorska cesta', '11', '6000', 45.5412, 13.7382, NOW()),
    ('Rome Tiburtina', 'Rome', 'Italy', 'Piazzale della Stazione Tiburtina', '1', '00162', 41.9102, 12.5292, NOW()),
    ('Rome Anagnina', 'Rome', 'Italy', 'Piazzale dell''Anagnina', '10', '00173', 41.8415, 12.5852, NOW()),
    ('Milan Lampugnano', 'Milan', 'Italy', 'Via Giulio Natta', '226', '20151', 45.4895, 9.1275, NOW()),
    ('Milan Rogoredo', 'Milan', 'Italy', 'Via Rogoredo', '83', '20138', 45.4292, 9.2392, NOW()),
    ('Venice Mestre', 'Venice', 'Italy', 'Viale Stazione', '21', '30171', 45.4828, 12.2312, NOW()),
    ('Venice Tronchetto', 'Venice', 'Italy', 'Isola del Tronchetto', '1', '30135', 45.4412, 12.3082, NOW()),
    ('Florence Villa Constanza', 'Florence', 'Italy', 'Via della Costituzione', '1', '50018', 43.7542, 11.1712, NOW()),
    ('Naples Metropark', 'Naples', 'Italy', 'Corso Arnaldo Lucci', '1', '80142', 40.8512, 14.2742, NOW()),
    ('Amsterdam Sloterdijk', 'Amsterdam', 'Netherlands', 'Radarweg', '36', '1043 NX', 52.3892, 4.8377, NOW()),
    ('Amsterdam Bijlmer Arena', 'Amsterdam', 'Netherlands', 'Hoogoorddreef', '3', '1101 BA', 52.3128, 4.9492, NOW()),
    ('Rotterdam Central', 'Rotterdam', 'Netherlands', 'Conradstraat', '18', '3013 AP', 51.9242, 4.4701, NOW()),
    ('The Hague Central', 'The Hague', 'Netherlands', 'Prins Bernhardviaduct', '1', '2595 AM', 52.0812, 4.3252, NOW()),
    ('Brussels North', 'Brussels', 'Belgium', 'Rue du Progrès', '85', '1210', 50.8605, 4.3592, NOW()),
    ('Brussels South', 'Brussels', 'Belgium', 'Rue de France', '2', '1060', 50.8356, 4.3352, NOW()),
    ('Antwerp Central', 'Antwerp', 'Belgium', 'Koningin Astridplein', '27', '2018', 51.2189, 4.4212, NOW()),
    ('Bruges Station', 'Bruges', 'Belgium', 'Stationsplein', '1', '8000', 51.1982, 3.2189, NOW()),
    ('Zurich Carparkplatz', 'Zurich', 'Switzerland', 'Ausstellungsstrasse', '5', '8005', 47.3801, 8.5392, NOW()),
    ('Zurich Airport', 'Zurich', 'Switzerland', 'Busterminal', '1', '8058', 47.4512, 8.5612, NOW()),
    ('Geneva Bus Station', 'Geneva', 'Switzerland', 'Place Dorcière', '1', '1201', 46.2092, 6.1501, NOW()),
    ('Basel SBB', 'Basel', 'Switzerland', 'Meret Oppenheim-Strasse', '40', '4053', 47.5468, 7.5892, NOW()),
    ('London Victoria', 'London', 'United Kingdom', 'Buckingham Palace Road', '164', 'SW1W 9TP', 51.4922, -0.1485, NOW()),
    ('Manchester Central', 'Manchester', 'United Kingdom', 'Chorlton Street', '55', 'M1 3JF', 53.4789, -2.2382, NOW()),
    ('Birmingham Coach Station', 'Birmingham', 'United Kingdom', 'Mill Lane', '1', 'B5 6DD', 52.4761, -1.8901, NOW()),
    ('Lisbon Sete Rios', 'Lisbon', 'Portugal', 'Praça Marechal Humberto Delgado', '1', '1500-423', 38.7412, -9.1662, NOW()),
    ('Lisbon Oriente', 'Lisbon', 'Portugal', 'Av. Dom João II', '1', '1990-233', 38.7678, -9.0982, NOW()),
    ('Porto Campo 24 de Agosto', 'Porto', 'Portugal', 'Campo de 24 de Agosto', '125', '4300-096', 41.1492, -8.5992, NOW()),
    ('Copenhagen Ingerslevsgade', 'Copenhagen', 'Denmark', 'Ingerslevsgade', '1', '1700', 55.6692, 12.5642, NOW()),
    ('Aarhus Bus Station', 'Aarhus', 'Denmark', 'Valdemarsgade', '9', '8000', 56.1512, 10.2012, NOW()),
    ('Stockholm Cityterminalen', 'Stockholm', 'Sweden', 'Klarabergsviadukten', '72', '111 64', 59.3308, 18.0568, NOW()),
    ('Gothenburg Nils Ericson', 'Gothenburg', 'Sweden', 'Nils Ericsonsplatsen', '7', '411 03', 57.7092, 11.9722, NOW()),
    ('Oslo Bussterminal', 'Oslo', 'Norway', 'Schweigaards gate', '10', '0185', 59.9112, 10.7582, NOW()),
    ('Bergen Bussterminal', 'Bergen', 'Norway', 'Fjøsangerveien', '4', '5008', 60.3892, 5.3333, NOW()),
    ('Helsinki Kamppi', 'Helsinki', 'Finland', 'Urho Kekkosen katu', '1', '00100', 60.1692, 24.9322, NOW()),
    ('Tampere Bus Station', 'Tampere', 'Finland', 'Hatanpään valtatie', '7', '33100', 61.4912, 23.7712, NOW()),
    ('Tallinn Central', 'Tallinn', 'Estonia', 'Lastekodu', '46', '10144', 59.4282, 24.7733, NOW()),
    ('Tartu Bus Station', 'Tartu', 'Estonia', 'Turu', '2', '51013', 58.3782, 26.7322, NOW()),
    ('Bucharest Filaret', 'Bucharest', 'Romania', 'Piața Gara Filaret', '1', '040331', 44.4142, 26.0935, NOW()),
    ('Bucharest Militari', 'Bucharest', 'Romania', 'Valea Cascadelor', '1', '061501', 44.4312, 26.0022, NOW()),
    ('Cluj-Napoca Bus Station', 'Cluj-Napoca', 'Romania', 'Strada Giordano Bruno', '1', '400424', 46.7828, 23.5912, NOW()),
    ('Timisoara Bus Station', 'Timisoara', 'Romania', 'Calea Stan Vidrighin', '4', '300645', 45.7412, 21.2492, NOW()),
    ('Karlovy Vary Terminal', 'Karlovy Vary', 'Czech Republic', 'Západní', '21', '36001', 50.2285, 12.8641, NOW()),
    ('Pardubice Central', 'Pardubice', 'Czech Republic', 'Palackého třída', '2020', '53002', 50.0315, 15.7592, NOW()),
    ('Gdynia Bus Station', 'Gdynia', 'Poland', 'Plac Konstytucji', '1', '81-354', 54.5212, 18.5292, NOW()),
    ('Bialystok Bus Station', 'Bialystok', 'Poland', 'Bohaterów Monte Cassino', '8', '15-879', 53.1333, 23.1412, NOW()),
    ('Lublin Bus Station', 'Lublin', 'Poland', 'Al. Tysiąclecia', '6', '20-121', 51.2528, 22.5692, NOW()),
    ('Nuremberg Airport', 'Nuremberg', 'Germany', 'Flughafenstraße', '100', '90411', 49.4952, 11.0772, NOW()),
    ('Dortmund Central', 'Dortmund', 'Germany', 'Steinstraße', '39', '44137', 51.5202, 7.4612, NOW()),
    ('Essen Central', 'Essen', 'Germany', 'Freiheit', '2', '45127', 51.4512, 7.0122, NOW()),
    ('Duisburg Central', 'Duisburg', 'Germany', 'Otto-Keller-Straße', '1', '47057', 51.4292, 6.7761, NOW()),
    ('Montpellier Sabines', 'Montpellier', 'France', 'Avenue du Colonel Pavelet', '1', '34070', 43.5828, 3.8601, NOW()),
    ('Nice Airport T2', 'Nice', 'France', 'Terminal 2 Bus Station', '2', '06200', 43.6612, 7.2082, NOW()),
    ('Granada Bus Station', 'Granada', 'Spain', 'Avenida de Juan Pablo II', '88', '18014', 37.2012, -3.6152, NOW()),
    ('Alicante Bus Station', 'Alicante', 'Spain', 'Muelle de Poniente', '1', '03001', 38.3382, -0.4902, NOW()),
    ('San Sebastian Bus Station', 'San Sebastian', 'Spain', 'Paseo de Federico García Lorca', '1', '20012', 43.3182, -1.9782, NOW()),
    ('Zadar Bus Station', 'Zadar', 'Croatia', 'Ante Starčevića', '1', '23000', 44.1082, 15.2412, NOW()),
    ('Pula Bus Station', 'Pula', 'Croatia', 'Trg I. istarske brigade', '1', '52100', 44.8761, 13.8542, NOW()),
    ('Trnava Bus Station', 'Trnava', 'Slovakia', 'Kollárova', '15', '91701', 48.3712, 17.5892, NOW()),
    ('Nitra Bus Station', 'Nitra', 'Slovakia', 'Staničná', '1', '94901', 48.3042, 18.0792, NOW()),
    ('Bologna Bus Station', 'Bologna', 'Italy', 'Piazza XX Settembre', '6', '40121', 44.5056, 11.3456, NOW()),
    ('Turin Corso Vittorio Emanuele', 'Turin', 'Italy', 'Corso Vittorio Emanuele II', '131', '10138', 45.0682, 7.6582, NOW()),
    ('Brasov Bus Station 1', 'Brasov', 'Romania', 'Gării', '1', '500040', 45.6612, 25.6152, NOW()),
    ('Constanta Bus Station', 'Constanta', 'Romania', 'Theodor Burada', '1', '900178', 44.1792, 28.6292, NOW()),
    ('Kyiv Central Bus Station', 'Kyiv', 'Ukraine', 'Nauky Ave', '1/2', '03039', 50.4022, 30.5218, NOW()),
    ('Kyiv Vydubychi Bus Station', 'Kyiv', 'Ukraine', 'Naberezhno-Pecherska Rd', '10', '01014', 50.4024, 30.5606, NOW()),
    ('Lviv Central Bus Station', 'Lviv', 'Ukraine', 'Stryiska St', '109', '79031', 49.7850, 24.0150, NOW()),
    ('Lviv Railway Station Bus Stop', 'Lviv', 'Ukraine', 'Dvirtseva Square', '1', '79018', 49.8397, 23.9944, NOW()),
    ('Kharkiv Central Bus Station', 'Kharkiv', 'Ukraine', 'Gagarin Ave', '22', '61001', 49.9808, 36.2442, NOW())
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
