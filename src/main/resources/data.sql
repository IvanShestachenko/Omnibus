-- TERMINALS
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

-- USERS (drivers)
INSERT INTO "user" (first_name, last_name, email, password_hash, phone, preferred_currency, role, created_at, updated_at) VALUES
    ('Lukas', 'Martin', 'lukas.martin@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420689337674', 'EUR', 'driver', NOW(), NOW()),
    ('Piotr', 'Santos', 'piotr.santos@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420562700131', 'EUR', 'driver', NOW(), NOW()),
    ('Volodymyr', 'Dimitrov', 'volodymyr.dimitrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420592030082', 'EUR', 'driver', NOW(), NOW()),
    ('Giuseppe', 'Bianchi', 'giuseppe.bianchi@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420876613093', 'EUR', 'driver', NOW(), NOW()),
    ('Lukas', 'Meyer', 'lukas.meyer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420883951498', 'EUR', 'driver', NOW(), NOW()),
    ('Hans', 'Radu', 'hans.radu@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420419021326', 'EUR', 'driver', NOW(), NOW()),
    ('Dmitri', 'Garcia', 'dmitri.garcia@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420448416234', 'EUR', 'driver', NOW(), NOW()),
    ('Giuseppe', 'Martinez', 'giuseppe.martinez@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420153875818', 'EUR', 'driver', NOW(), NOW()),
    ('Andreas', 'Schmidt', 'andreas.schmidt@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420676126164', 'EUR', 'driver', NOW(), NOW()),
    ('Sergey', 'Nilsson', 'sergey.nilsson@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420508277443', 'EUR', 'driver', NOW(), NOW()),
    ('Pavel', 'Petrov', 'pavel.petrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420950774651', 'EUR', 'driver', NOW(), NOW()),
    ('Petr', 'Andersson', 'petr.andersson@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420102648180', 'EUR', 'driver', NOW(), NOW()),
    ('Vladimir', 'Sokolov', 'vladimir.sokolov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420841863216', 'EUR', 'driver', NOW(), NOW()),
    ('Dmitry', 'Sokolov', 'dmitry.sokolov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420723133709', 'EUR', 'driver', NOW(), NOW()),
    ('Michel', 'Shevchenko', 'michel.shevchenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420113864020', 'EUR', 'driver', NOW(), NOW()),
    ('Robert', 'Bauer', 'robert.bauer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420104084561', 'EUR', 'driver', NOW(), NOW()),
    ('Andre', 'Schmidt', 'andre.schmidt@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420132265203', 'EUR', 'driver', NOW(), NOW()),
    ('Dmitry', 'Olsen', 'dmitry.olsen@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420123155874', 'EUR', 'driver', NOW(), NOW()),
    ('Andreas', 'Nowak', 'andreas.nowak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420191824227', 'EUR', 'driver', NOW(), NOW()),
    ('Ivan', 'Dvorak', 'ivan.dvorak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420728578528', 'EUR', 'driver', NOW(), NOW()),
    ('Krzysztof', 'Nilsson', 'krzysztof.nilsson@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420243765124', 'EUR', 'driver', NOW(), NOW()),
    ('Jiri', 'Mueller', 'jiri.mueller@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420668221538', 'EUR', 'driver', NOW(), NOW()),
    ('Peter', 'Sokolov', 'peter.sokolov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420521885413', 'EUR', 'driver', NOW(), NOW()),
    ('Robert', 'Santos', 'robert.santos@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420470902733', 'EUR', 'driver', NOW(), NOW()),
    ('Mikhail', 'Martinez', 'mikhail.martinez@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420135605214', 'EUR', 'driver', NOW(), NOW()),
    ('Dmitry', 'Martin', 'dmitry.martin@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420707639401', 'EUR', 'driver', NOW(), NOW()),
    ('Pavel', 'Popov', 'pavel.popov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420530661455', 'EUR', 'driver', NOW(), NOW()),
    ('Petr', 'Schulz', 'petr.schulz@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420786016747', 'EUR', 'driver', NOW(), NOW()),
    ('Yury', 'Svoboda', 'yury.svoboda@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420650855295', 'EUR', 'driver', NOW(), NOW()),
    ('Piotr', 'Hofmann', 'piotr.hofmann@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420211439086', 'EUR', 'driver', NOW(), NOW()),
    ('Stefan', 'Fischer', 'stefan.fischer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420624826997', 'EUR', 'driver', NOW(), NOW()),
    ('Vasyl', 'Prochazka', 'vasyl.prochazka@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420480772041', 'EUR', 'driver', NOW(), NOW()),
    ('Jean', 'Dubois', 'jean.dubois@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420329780235', 'EUR', 'driver', NOW(), NOW()),
    ('Peter', 'Andersson', 'peter.andersson@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420278468493', 'EUR', 'driver', NOW(), NOW()),
    ('Lars', 'Martin', 'lars.martin@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420824048269', 'EUR', 'driver', NOW(), NOW()),
    ('Lars', 'Wagner', 'lars.wagner@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420839976654', 'EUR', 'driver', NOW(), NOW()),
    ('Vladimir', 'Kolar', 'vladimir.kolar@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420757716917', 'EUR', 'driver', NOW(), NOW()),
    ('Andreas', 'Bauer', 'andreas.bauer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420690430723', 'EUR', 'driver', NOW(), NOW()),
    ('Piotr', 'Sokolov', 'piotr.sokolov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420486331433', 'EUR', 'driver', NOW(), NOW()),
    ('Krzysztof', 'Kovalenko', 'krzysztof.kovalenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420625912359', 'EUR', 'driver', NOW(), NOW()),
    ('Lars', 'Popescu', 'lars.popescu@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420597835714', 'EUR', 'driver', NOW(), NOW()),
    ('Andrzej', 'Nilsson', 'andrzej.nilsson@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420195269489', 'EUR', 'driver', NOW(), NOW()),
    ('Pierre', 'Schmidt', 'pierre.schmidt@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420242282671', 'EUR', 'driver', NOW(), NOW()),
    ('Andreas', 'Novak', 'andreas.novak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420973159046', 'EUR', 'driver', NOW(), NOW()),
    ('Vasyl', 'Cerny', 'vasyl.cerny@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420231880533', 'EUR', 'driver', NOW(), NOW()),
    ('Oleksandr', 'Dimitrov', 'oleksandr.dimitrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420206513841', 'EUR', 'driver', NOW(), NOW()),
    ('Giuseppe', 'Volkov', 'giuseppe.volkov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420428809674', 'EUR', 'driver', NOW(), NOW()),
    ('James', 'Kovalenko', 'james.kovalenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420343685800', 'EUR', 'driver', NOW(), NOW()),
    ('Lukas', 'Martinez', 'lukas.martinez@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420446203019', 'EUR', 'driver', NOW(), NOW()),
    ('Peter', 'Cerny', 'peter.cerny@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420909531852', 'EUR', 'driver', NOW(), NOW()),
    ('Antonio', 'Silva', 'antonio.silva@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420939261038', 'EUR', 'driver', NOW(), NOW()),
    ('Erik', 'Fischer', 'erik.fischer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420475744003', 'EUR', 'driver', NOW(), NOW()),
    ('Hans', 'Andersson', 'hans.andersson@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420744180382', 'EUR', 'driver', NOW(), NOW()),
    ('Petr', 'Hofmann', 'petr.hofmann@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420499574353', 'EUR', 'driver', NOW(), NOW()),
    ('Marco', 'Petrov', 'marco.petrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420964032093', 'EUR', 'driver', NOW(), NOW()),
    ('Dmitri', 'Gruber', 'dmitri.gruber@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420286156659', 'EUR', 'driver', NOW(), NOW()),
    ('Oleksandr', 'Huber', 'oleksandr.huber@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420479262091', 'EUR', 'driver', NOW(), NOW()),
    ('Tomasz', 'Fischer', 'tomasz.fischer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420521262963', 'EUR', 'driver', NOW(), NOW()),
    ('Martin', 'Santos', 'martin.santos@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420448357305', 'EUR', 'driver', NOW(), NOW()),
    ('Antonio', 'Langer', 'antonio.langer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420908256166', 'EUR', 'driver', NOW(), NOW()),
    ('Sergey', 'Morozov', 'sergey.morozov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420434971333', 'EUR', 'driver', NOW(), NOW()),
    ('Petr', 'Petrov', 'petr.petrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420244465410', 'EUR', 'driver', NOW(), NOW()),
    ('Martin', 'Fischer', 'martin.fischer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420651413570', 'EUR', 'driver', NOW(), NOW()),
    ('Carlos', 'Morozov', 'carlos.morozov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420937278940', 'EUR', 'driver', NOW(), NOW()),
    ('David', 'Sokolov', 'david.sokolov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420362646437', 'EUR', 'driver', NOW(), NOW()),
    ('Igor', 'Fischer', 'igor.fischer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420295549765', 'EUR', 'driver', NOW(), NOW()),
    ('Antonio', 'Petrov', 'antonio.petrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420643530930', 'EUR', 'driver', NOW(), NOW()),
    ('Sven', 'Rossi', 'sven.rossi@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420349395516', 'EUR', 'driver', NOW(), NOW()),
    ('David', 'Radu', 'david.radu@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420459489413', 'EUR', 'driver', NOW(), NOW()),
    ('Marco', 'Dvorak', 'marco.dvorak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420644070356', 'EUR', 'driver', NOW(), NOW()),
    ('Krzysztof', 'Andersson', 'krzysztof.andersson@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420379808161', 'EUR', 'driver', NOW(), NOW()),
    ('Marco', 'Kovalenko', 'marco.kovalenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420893108566', 'EUR', 'driver', NOW(), NOW()),
    ('Carlos', 'Kowalski', 'carlos.kowalski@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420781446444', 'EUR', 'driver', NOW(), NOW()),
    ('Vladimir', 'Bauer', 'vladimir.bauer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420940939308', 'EUR', 'driver', NOW(), NOW()),
    ('Stefan', 'Hansen', 'stefan.hansen@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420971525170', 'EUR', 'driver', NOW(), NOW()),
    ('Jozef', 'Silva', 'jozef.silva@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420690156655', 'EUR', 'driver', NOW(), NOW()),
    ('Andrey', 'Bauer', 'andrey.bauer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420451111077', 'EUR', 'driver', NOW(), NOW()),
    ('Krzysztof', 'Wagner', 'krzysztof.wagner@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420398604375', 'EUR', 'driver', NOW(), NOW()),
    ('Jozef', 'Prochazka', 'jozef.prochazka@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420738961512', 'EUR', 'driver', NOW(), NOW()),
    ('Sergey', 'Kolar', 'sergey.kolar@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420534106412', 'EUR', 'driver', NOW(), NOW()),
    ('Volodymyr', 'Santos', 'volodymyr.santos@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420598269470', 'EUR', 'driver', NOW(), NOW()),
    ('Pierre', 'Bauer', 'pierre.bauer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420244071688', 'EUR', 'driver', NOW(), NOW()),
    ('Erik', 'Svoboda', 'erik.svoboda@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420836390653', 'EUR', 'driver', NOW(), NOW()),
    ('Michel', 'Radu', 'michel.radu@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420402850972', 'EUR', 'driver', NOW(), NOW()),
    ('Piotr', 'Rossi', 'piotr.rossi@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420444709820', 'EUR', 'driver', NOW(), NOW()),
    ('Alexey', 'Wagner', 'alexey.wagner@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420187671086', 'EUR', 'driver', NOW(), NOW()),
    ('Lars', 'Schulz', 'lars.schulz@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420736763843', 'EUR', 'driver', NOW(), NOW()),
    ('Jiri', 'Silva', 'jiri.silva@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420657985644', 'EUR', 'driver', NOW(), NOW()),
    ('Andrzej', 'Garcia', 'andrzej.garcia@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420687305856', 'EUR', 'driver', NOW(), NOW()),
    ('Vladimir', 'Olsen', 'vladimir.olsen@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420887401804', 'EUR', 'driver', NOW(), NOW()),
    ('Miguel', 'Kovac', 'miguel.kovac@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420822452579', 'EUR', 'driver', NOW(), NOW()),
    ('Jiri', 'Popov', 'jiri.popov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420442846614', 'EUR', 'driver', NOW(), NOW()),
    ('Miguel', 'Novak', 'miguel.novak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420827221531', 'EUR', 'driver', NOW(), NOW()),
    ('Jozef', 'Nowak', 'jozef.nowak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420805826046', 'EUR', 'driver', NOW(), NOW()),
    ('Mikhail', 'Radu', 'mikhail.radu@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420444826822', 'EUR', 'driver', NOW(), NOW()),
    ('Petr', 'Garcia', 'petr.garcia@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420946611705', 'EUR', 'driver', NOW(), NOW()),
    ('Carlos', 'Nilsson', 'carlos.nilsson@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420195308940', 'EUR', 'driver', NOW(), NOW()),
    ('Milan', 'Sokolov', 'milan.sokolov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420119424233', 'EUR', 'driver', NOW(), NOW()),
    ('Andrey', 'Gruber', 'andrey.gruber@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420618469385', 'EUR', 'driver', NOW(), NOW()),
    ('Marco', 'Kowalski', 'marco.kowalski@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420215001120', 'EUR', 'driver', NOW(), NOW()),
    ('Jan', 'Santos', 'jan.santos@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420752772402', 'EUR', 'driver', NOW(), NOW()),
    ('Alexander', 'Morozov', 'alexander.morozov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420785610034', 'EUR', 'driver', NOW(), NOW()),
    ('Krzysztof', 'Prochazka', 'krzysztof.prochazka@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420208585185', 'EUR', 'driver', NOW(), NOW()),
    ('Tomasz', 'Dimitrov', 'tomasz.dimitrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420440594364', 'EUR', 'driver', NOW(), NOW()),
    ('Jozef', 'Kovalenko', 'jozef.kovalenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420852699943', 'EUR', 'driver', NOW(), NOW()),
    ('Dmitri', 'Morozov', 'dmitri.morozov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420451916782', 'EUR', 'driver', NOW(), NOW()),
    ('John', 'Kovac', 'john.kovac@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420146229647', 'EUR', 'driver', NOW(), NOW()),
    ('Martin', 'Dimitrov', 'martin.dimitrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420641815710', 'EUR', 'driver', NOW(), NOW()),
    ('Milan', 'Prochazka', 'milan.prochazka@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420743988076', 'EUR', 'driver', NOW(), NOW()),
    ('Robert', 'Fischer', 'robert.fischer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420518314501', 'EUR', 'driver', NOW(), NOW()),
    ('Andre', 'Fischer', 'andre.fischer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420908322706', 'EUR', 'driver', NOW(), NOW()),
    ('Sven', 'Mueller', 'sven.mueller@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420263920006', 'EUR', 'driver', NOW(), NOW()),
    ('Jan', 'Martinez', 'jan.martinez@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420316890889', 'EUR', 'driver', NOW(), NOW()),
    ('Sergey', 'Dvorak', 'sergey.dvorak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420170933140', 'EUR', 'driver', NOW(), NOW()),
    ('Pierre', 'Meyer', 'pierre.meyer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420559460909', 'EUR', 'driver', NOW(), NOW()),
    ('Jiri', 'Olsen', 'jiri.olsen@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420289326056', 'EUR', 'driver', NOW(), NOW()),
    ('James', 'Kowalski', 'james.kowalski@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420315043598', 'EUR', 'driver', NOW(), NOW()),
    ('Stefan', 'Volkov', 'stefan.volkov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420803378563', 'EUR', 'driver', NOW(), NOW()),
    ('Volodymyr', 'Radu', 'volodymyr.radu@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420120279255', 'EUR', 'driver', NOW(), NOW()),
    ('Pavel', 'Dvorak', 'pavel.dvorak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420807628870', 'EUR', 'driver', NOW(), NOW()),
    ('Alexander', 'Kovalenko', 'alexander.kovalenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420826328863', 'EUR', 'driver', NOW(), NOW()),
    ('Martin', 'Shevchenko', 'martin.shevchenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420379124590', 'EUR', 'driver', NOW(), NOW()),
    ('James', 'Cerny', 'james.cerny@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420105731812', 'EUR', 'driver', NOW(), NOW()),
    ('Marco', 'Novak', 'marco.novak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420662566340', 'EUR', 'driver', NOW(), NOW()),
    ('Peter', 'Rossi', 'peter.rossi@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420839835238', 'EUR', 'driver', NOW(), NOW()),
    ('Andreas', 'Garcia', 'andreas.garcia@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420789124323', 'EUR', 'driver', NOW(), NOW()),
    ('Lars', 'Dimitrov', 'lars.dimitrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420374740680', 'EUR', 'driver', NOW(), NOW()),
    ('Tomasz', 'Radu', 'tomasz.radu@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420311442126', 'EUR', 'driver', NOW(), NOW()),
    ('James', 'Hansen', 'james.hansen@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420662888200', 'EUR', 'driver', NOW(), NOW()),
    ('Erik', 'Dimitrov', 'erik.dimitrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420651347041', 'EUR', 'driver', NOW(), NOW()),
    ('Andrey', 'Shevchenko', 'andrey.shevchenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420859238607', 'EUR', 'driver', NOW(), NOW()),
    ('Dmitry', 'Bondarenko', 'dmitry.bondarenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420107956824', 'EUR', 'driver', NOW(), NOW()),
    ('Martin', 'Radu', 'martin.radu@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420369164435', 'EUR', 'driver', NOW(), NOW()),
    ('Oleksandr', 'Olsen', 'oleksandr.olsen@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420752533860', 'EUR', 'driver', NOW(), NOW()),
    ('Lars', 'Horvat', 'lars.horvat@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420786134196', 'EUR', 'driver', NOW(), NOW()),
    ('Piotr', 'Becker', 'piotr.becker@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420230220747', 'EUR', 'driver', NOW(), NOW()),
    ('Hans', 'Kovac', 'hans.kovac@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420322423471', 'EUR', 'driver', NOW(), NOW()),
    ('David', 'Meyer', 'david.meyer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420839960842', 'EUR', 'driver', NOW(), NOW()),
    ('Volodymyr', 'Kovalenko', 'volodymyr.kovalenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420201097818', 'EUR', 'driver', NOW(), NOW()),
    ('Nikolay', 'Schmidt', 'nikolay.schmidt@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420513276119', 'EUR', 'driver', NOW(), NOW()),
    ('Pierre', 'Martin', 'pierre.martin@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420157000727', 'EUR', 'driver', NOW(), NOW()),
    ('Nikolay', 'Ivanov', 'nikolay.ivanov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420786090938', 'EUR', 'driver', NOW(), NOW()),
    ('Richard', 'Dubois', 'richard.dubois@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420297601688', 'EUR', 'driver', NOW(), NOW()),
    ('Vladimir', 'Hofmann', 'vladimir.hofmann@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420585753299', 'EUR', 'driver', NOW(), NOW()),
    ('Jan', 'Novak', 'jan.novak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420401343104', 'EUR', 'driver', NOW(), NOW()),
    ('Yury', 'Shevchenko', 'yury.shevchenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420704030831', 'EUR', 'driver', NOW(), NOW()),
    ('Vladimir', 'Cerny', 'vladimir.cerny@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420770389229', 'EUR', 'driver', NOW(), NOW()),
    ('Hans', 'Wagner', 'hans.wagner@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420182434249', 'EUR', 'driver', NOW(), NOW()),
    ('Krzysztof', 'Dimitrov', 'krzysztof.dimitrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420451077575', 'EUR', 'driver', NOW(), NOW()),
    ('Andrey', 'Kolar', 'andrey.kolar@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420887129904', 'EUR', 'driver', NOW(), NOW()),
    ('Jean', 'Huber', 'jean.huber@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420604142958', 'EUR', 'driver', NOW(), NOW()),
    ('Miguel', 'Nilsson', 'miguel.nilsson@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420993101513', 'EUR', 'driver', NOW(), NOW()),
    ('Marc', 'Bondarenko', 'marc.bondarenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420106851275', 'EUR', 'driver', NOW(), NOW()),
    ('Jozef', 'Andersson', 'jozef.andersson@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420451356986', 'EUR', 'driver', NOW(), NOW()),
    ('Miguel', 'Rossi', 'miguel.rossi@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420286205435', 'EUR', 'driver', NOW(), NOW()),
    ('David', 'Dubois', 'david.dubois@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420671116107', 'EUR', 'driver', NOW(), NOW()),
    ('Erik', 'Dubois', 'erik.dubois@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420311098958', 'EUR', 'driver', NOW(), NOW()),
    ('John', 'Hansen', 'john.hansen@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420312734013', 'EUR', 'driver', NOW(), NOW()),
    ('Andrey', 'Dimitrov', 'andrey.dimitrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420811512397', 'EUR', 'driver', NOW(), NOW()),
    ('Michel', 'Morozov', 'michel.morozov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420665476908', 'EUR', 'driver', NOW(), NOW()),
    ('Giuseppe', 'Radu', 'giuseppe.radu@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420108969688', 'EUR', 'driver', NOW(), NOW()),
    ('David', 'Martin', 'david.martin@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420155487309', 'EUR', 'driver', NOW(), NOW()),
    ('Volodymyr', 'Bondarenko', 'volodymyr.bondarenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420423982332', 'EUR', 'driver', NOW(), NOW()),
    ('Oleksandr', 'Ivanov', 'oleksandr.ivanov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420342477172', 'EUR', 'driver', NOW(), NOW()),
    ('Robert', 'Dimitrov', 'robert.dimitrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420572385772', 'EUR', 'driver', NOW(), NOW()),
    ('Vasyl', 'Dubois', 'vasyl.dubois@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420422626584', 'EUR', 'driver', NOW(), NOW()),
    ('Carlos', 'Shevchenko', 'carlos.shevchenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420842427168', 'EUR', 'driver', NOW(), NOW()),
    ('Volodymyr', 'Czech', 'volodymyr.czech@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420442309471', 'EUR', 'driver', NOW(), NOW()),
    ('Lukas', 'Schmidt', 'lukas.schmidt@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420209492802', 'EUR', 'driver', NOW(), NOW()),
    ('Ivan', 'Silva', 'ivan.silva@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420112854608', 'EUR', 'driver', NOW(), NOW()),
    ('Alexey', 'Dvorak', 'alexey.dvorak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420585566907', 'EUR', 'driver', NOW(), NOW()),
    ('Milan', 'Meyer', 'milan.meyer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420406545149', 'EUR', 'driver', NOW(), NOW()),
    ('Carlos', 'Olsen', 'carlos.olsen@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420203262276', 'EUR', 'driver', NOW(), NOW()),
    ('Vladimir', 'Silva', 'vladimir.silva@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420424751144', 'EUR', 'driver', NOW(), NOW()),
    ('Jean', 'Olsen', 'jean.olsen@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420764474511', 'EUR', 'driver', NOW(), NOW()),
    ('Carlos', 'Hansen', 'carlos.hansen@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420435139662', 'EUR', 'driver', NOW(), NOW()),
    ('Alexander', 'Bianchi', 'alexander.bianchi@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420243721655', 'EUR', 'driver', NOW(), NOW()),
    ('Michel', 'Lopez', 'michel.lopez@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420723706914', 'EUR', 'driver', NOW(), NOW()),
    ('Peter', 'Weber', 'peter.weber@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420361634338', 'EUR', 'driver', NOW(), NOW()),
    ('Miguel', 'Bondarenko', 'miguel.bondarenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420754537433', 'EUR', 'driver', NOW(), NOW()),
    ('Andrey', 'Hofmann', 'andrey.hofmann@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420305910697', 'EUR', 'driver', NOW(), NOW()),
    ('John', 'Dimitrov', 'john.dimitrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420155208653', 'EUR', 'driver', NOW(), NOW()),
    ('Erik', 'Silva', 'erik.silva@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420699204634', 'EUR', 'driver', NOW(), NOW()),
    ('Marco', 'Nilsson', 'marco.nilsson@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420621398437', 'EUR', 'driver', NOW(), NOW()),
    ('Marc', 'Dvorak', 'marc.dvorak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420877012628', 'EUR', 'driver', NOW(), NOW()),
    ('Dmitry', 'Wagner', 'dmitry.wagner@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420993096881', 'EUR', 'driver', NOW(), NOW()),
    ('Jean', 'Petrov', 'jean.petrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420789971494', 'EUR', 'driver', NOW(), NOW()),
    ('Sven', 'Martinez', 'sven.martinez@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420716217319', 'EUR', 'driver', NOW(), NOW()),
    ('Jozef', 'Volkov', 'jozef.volkov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420120435170', 'EUR', 'driver', NOW(), NOW()),
    ('Andrzej', 'Prochazka', 'andrzej.prochazka@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420352254248', 'EUR', 'driver', NOW(), NOW()),
    ('Sergey', 'Kovac', 'sergey.kovac@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420543434504', 'EUR', 'driver', NOW(), NOW()),
    ('Andrey', 'Horvat', 'andrey.horvat@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420902948738', 'EUR', 'driver', NOW(), NOW()),
    ('Sven', 'Hofmann', 'sven.hofmann@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420690194984', 'EUR', 'driver', NOW(), NOW()),
    ('Marc', 'Santos', 'marc.santos@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420486472796', 'EUR', 'driver', NOW(), NOW()),
    ('Marc', 'Kowalski', 'marc.kowalski@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420158375731', 'EUR', 'driver', NOW(), NOW()),
    ('Pierre', 'Shevchenko', 'pierre.shevchenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420893104759', 'EUR', 'driver', NOW(), NOW()),
    ('Lukas', 'Rossi', 'lukas.rossi@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420362504415', 'EUR', 'driver', NOW(), NOW()),
    ('Thomas', 'Dvorak', 'thomas.dvorak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420999167799', 'EUR', 'driver', NOW(), NOW()),
    ('Alexander', 'Schmidt', 'alexander.schmidt@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420850143087', 'EUR', 'driver', NOW(), NOW()),
    ('Miguel', 'Silva', 'miguel.silva@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420836100321', 'EUR', 'driver', NOW(), NOW()),
    ('Nikolay', 'Nowak', 'nikolay.nowak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420377095255', 'EUR', 'driver', NOW(), NOW()),
    ('Igor', 'Gruber', 'igor.gruber@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420272097147', 'EUR', 'driver', NOW(), NOW()),
    ('Tomasz', 'Meyer', 'tomasz.meyer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420291829620', 'EUR', 'driver', NOW(), NOW()),
    ('Milan', 'Hansen', 'milan.hansen@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420863103740', 'EUR', 'driver', NOW(), NOW()),
    ('Dmitri', 'Wagner', 'dmitri.wagner@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420930405170', 'EUR', 'driver', NOW(), NOW()),
    ('Stefan', 'Silva', 'stefan.silva@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420501239508', 'EUR', 'driver', NOW(), NOW()),
    ('Pierre', 'Gruber', 'pierre.gruber@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420754967211', 'EUR', 'driver', NOW(), NOW()),
    ('Krzysztof', 'Hofmann', 'krzysztof.hofmann@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420360277884', 'EUR', 'driver', NOW(), NOW()),
    ('Thomas', 'Ivanov', 'thomas.ivanov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420824148441', 'EUR', 'driver', NOW(), NOW()),
    ('Sven', 'Kovac', 'sven.kovac@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420252858880', 'EUR', 'driver', NOW(), NOW()),
    ('Sven', 'Svoboda', 'sven.svoboda@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420626384094', 'EUR', 'driver', NOW(), NOW()),
    ('Martin', 'Kovalenko', 'martin.kovalenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420237696368', 'EUR', 'driver', NOW(), NOW()),
    ('Jozef', 'Langer', 'jozef.langer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420339365337', 'EUR', 'driver', NOW(), NOW()),
    ('Giuseppe', 'Hansen', 'giuseppe.hansen@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420706046739', 'EUR', 'driver', NOW(), NOW()),
    ('Antonio', 'Santos', 'antonio.santos@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420729143450', 'EUR', 'driver', NOW(), NOW()),
    ('Vasyl', 'Dimitrov', 'vasyl.dimitrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420634852961', 'EUR', 'driver', NOW(), NOW()),
    ('David', 'Gruber', 'david.gruber@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420972012351', 'EUR', 'driver', NOW(), NOW()),
    ('Carlos', 'Bondarenko', 'carlos.bondarenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420877949639', 'EUR', 'driver', NOW(), NOW()),
    ('Igor', 'Garcia', 'igor.garcia@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420905985567', 'EUR', 'driver', NOW(), NOW()),
    ('David', 'Kowalski', 'david.kowalski@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420921940468', 'EUR', 'driver', NOW(), NOW()),
    ('Lukas', 'Kowalski', 'lukas.kowalski@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420885180511', 'EUR', 'driver', NOW(), NOW()),
    ('Hans', 'Volkov', 'hans.volkov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420914110295', 'EUR', 'driver', NOW(), NOW()),
    ('Thomas', 'Kovac', 'thomas.kovac@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420540231972', 'EUR', 'driver', NOW(), NOW()),
    ('Miguel', 'Kovalenko', 'miguel.kovalenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420819326709', 'EUR', 'driver', NOW(), NOW()),
    ('Andreas', 'Meyer', 'andreas.meyer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420593747985', 'EUR', 'driver', NOW(), NOW()),
    ('Carlos', 'Mueller', 'carlos.mueller@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420455778981', 'EUR', 'driver', NOW(), NOW()),
    ('Dmitri', 'Dvorak', 'dmitri.dvorak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420254422428', 'EUR', 'driver', NOW(), NOW()),
    ('Peter', 'Petrov', 'peter.petrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420377305976', 'EUR', 'driver', NOW(), NOW()),
    ('Sven', 'Dvorak', 'sven.dvorak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420948783342', 'EUR', 'driver', NOW(), NOW()),
    ('Milan', 'Bondarenko', 'milan.bondarenko@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420573500005', 'EUR', 'driver', NOW(), NOW()),
    ('Dmitri', 'Dubois', 'dmitri.dubois@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420137147038', 'EUR', 'driver', NOW(), NOW()),
    ('Oleksandr', 'Rossi', 'oleksandr.rossi@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420924397560', 'EUR', 'driver', NOW(), NOW()),
    ('Antonio', 'Popov', 'antonio.popov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420162160168', 'EUR', 'driver', NOW(), NOW()),
    ('Andre', 'Meyer', 'andre.meyer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420637995634', 'EUR', 'driver', NOW(), NOW()),
    ('Stefan', 'Becker', 'stefan.becker@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420519498201', 'EUR', 'driver', NOW(), NOW()),
    ('Hans', 'Weber', 'hans.weber@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420170669217', 'EUR', 'driver', NOW(), NOW()),
    ('Alexander', 'Fischer', 'alexander.fischer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420209838906', 'EUR', 'driver', NOW(), NOW()),
    ('Richard', 'Olsen', 'richard.olsen@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420907311781', 'EUR', 'driver', NOW(), NOW()),
    ('Jiri', 'Nowak', 'jiri.nowak@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420153405104', 'EUR', 'driver', NOW(), NOW()),
    ('Petr', 'Langer', 'petr.langer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420941982230', 'EUR', 'driver', NOW(), NOW()),
    ('Pavel', 'Hofmann', 'pavel.hofmann@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420867548913', 'EUR', 'driver', NOW(), NOW()),
    ('Jean', 'Popov', 'jean.popov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420629942710', 'EUR', 'driver', NOW(), NOW()),
    ('John', 'Bianchi', 'john.bianchi@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420341639176', 'EUR', 'driver', NOW(), NOW()),
    ('Volodymyr', 'Popov', 'volodymyr.popov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420279007877', 'EUR', 'driver', NOW(), NOW()),
    ('Ivan', 'Langer', 'ivan.langer@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420579986592', 'EUR', 'driver', NOW(), NOW()),
    ('Alexey', 'Sokolov', 'alexey.sokolov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420565726937', 'EUR', 'driver', NOW(), NOW()),
    ('Andre', 'Mueller', 'andre.mueller@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420586450116', 'EUR', 'driver', NOW(), NOW()),
    ('Piotr', 'Wagner', 'piotr.wagner@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420505418971', 'EUR', 'driver', NOW(), NOW()),
    ('Yury', 'Petrov', 'yury.petrov@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420399339572', 'EUR', 'driver', NOW(), NOW()),
    ('Jan', 'Weber', 'jan.weber@driver.omnibus.com', '$2a$10$EjdOlTGGHbKhL6j7mCLxFukCwC6fhvHKfvYi8YEeZtjhxSWt17TDG', '+420352369559', 'EUR', 'driver', NOW(), NOW())
ON CONFLICT (email) DO NOTHING;

-- DRIVERS
INSERT INTO driver (user_id, license_number, license_expiry, is_available, created_at)
SELECT id, 'DL-DRV-' || id, '2028-12-31', true, NOW() FROM "user" WHERE role = 'driver'
ON CONFLICT (user_id) DO NOTHING;

-- BUSES
INSERT INTO bus (registration_number, model, manufacturer, year, total_seats, seat_layout, status, created_at, updated_at) VALUES
    ('BUS-001', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-002', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-003', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-004', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-005', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-006', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-007', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-008', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-009', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-010', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-011', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-012', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-013', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-014', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-015', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-016', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-017', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-018', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-019', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-020', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-021', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-022', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-023', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-024', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-025', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-026', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-027', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-028', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-029', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-030', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-031', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-032', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-033', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-034', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-035', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-036', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-037', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-038', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-039', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-040', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-041', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-042', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-043', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-044', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-045', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-046', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-047', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-048', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-049', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-050', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-051', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-052', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-053', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-054', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-055', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-056', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-057', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-058', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-059', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-060', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-061', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-062', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-063', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-064', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-065', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-066', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-067', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-068', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-069', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-070', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-071', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-072', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-073', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-074', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-075', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-076', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-077', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-078', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-079', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-080', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-081', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-082', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-083', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-084', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-085', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-086', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-087', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-088', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-089', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-090', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-091', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-092', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-093', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-094', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-095', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-096', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-097', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-098', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-099', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-100', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-101', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-102', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-103', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-104', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-105', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-106', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-107', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-108', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-109', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-110', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-111', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-112', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-113', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-114', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-115', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-116', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-117', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-118', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-119', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-120', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-121', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-122', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-123', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-124', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-125', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-126', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-127', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-128', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-129', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-130', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-131', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-132', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-133', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-134', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-135', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-136', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-137', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-138', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-139', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-140', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-141', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-142', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-143', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-144', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-145', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-146', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-147', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-148', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-149', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-150', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-151', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-152', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-153', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-154', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-155', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-156', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-157', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-158', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-159', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-160', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-161', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-162', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-163', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-164', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-165', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-166', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-167', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-168', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-169', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-170', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-171', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-172', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-173', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-174', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-175', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-176', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-177', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-178', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-179', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-180', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-181', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-182', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-183', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-184', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-185', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-186', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-187', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-188', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-189', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-190', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-191', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-192', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-193', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-194', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-195', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-196', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-197', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-198', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-199', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-200', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-201', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-202', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-203', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-204', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-205', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-206', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-207', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-208', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-209', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-210', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-211', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-212', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-213', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-214', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-215', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-216', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-217', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-218', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-219', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-220', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-221', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-222', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-223', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-224', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-225', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-226', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-227', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-228', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-229', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-230', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-231', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-232', 'Setra S 515 HD', 'Setra', 2019, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-233', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-234', 'Setra S 515 HD', 'Setra', 2018, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-235', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-236', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-237', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-238', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-239', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-240', 'Setra S 515 HD', 'Setra', 2024, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-241', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-242', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-243', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-244', 'Setra S 515 HD', 'Setra', 2020, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-245', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-246', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-247', 'Setra S 515 HD', 'Setra', 2022, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-248', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-249', 'Setra S 515 HD', 'Setra', 2021, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW()),
    ('BUS-250', 'Setra S 515 HD', 'Setra', 2023, 53, '{"rows": 14, "seatsPerRow": 4, "layout": "2+2", "totalSeats": 53, "categories": {"PANORAMIC": ["1", "2", "3", "4"]}}', 'ACTIVE', NOW(), NOW())
ON CONFLICT (registration_number) DO NOTHING;

-- ROUTES
INSERT INTO route (name, is_active, created_at, updated_at) VALUES
    ('Prague - Brno - Olomouc - Ostrava', true, NOW(), NOW()),
    ('Karlovy Vary - Prague - Pardubice - Ostrava', true, NOW(), NOW()),
    ('Plzeň - Prague - Liberec', true, NOW(), NOW()),
    ('Prague - Brno Zvonařka - Ostrava Svinov', true, NOW(), NOW()),
    ('Hamburg - Hanover - Kassel - Nuremberg - Munich', true, NOW(), NOW()),
    ('Dusseldorf - Essen - Dortmund - Duisburg - Berlin', true, NOW(), NOW()),
    ('Munich - Stuttgart - Frankfurt - Cologne', true, NOW(), NOW()),
    ('Cologne Airport - Frankfurt Airport - Leipzig - Berlin Ostbahnhof', true, NOW(), NOW()),
    ('Berlin Sudkreuz - Dresden - Munich', true, NOW(), NOW()),
    ('Bremen - Hamburg - Berlin ZOB', true, NOW(), NOW()),
    ('Gdynia - Gdańsk - Warsaw - Kraków', true, NOW(), NOW()),
    ('Szczecin - Poznań - Łódź - Warsaw - Lublin', true, NOW(), NOW()),
    ('Wrocław - Katowice - Kraków - Bialystok', true, NOW(), NOW()),
    ('Lille - Paris - Lyon - Marseille', true, NOW(), NOW()),
    ('Nantes - Bordeaux - Toulouse - Montpellier - Marseille', true, NOW(), NOW()),
    ('Nice - Cannes - Marseille - Lyon', true, NOW(), NOW()),
    ('Paris Gallieni - Paris Pont de Levallois - Strasbourg', true, NOW(), NOW()),
    ('Bilbao - San Sebastian - Zaragoza - Madrid - Seville', true, NOW(), NOW()),
    ('Barcelona - Valencia - Alicante - Malaga - Granada', true, NOW(), NOW()),
    ('Madrid Aeropuerto Barajas - Madrid Avenida de America - Barcelona Sants', true, NOW(), NOW()),
    ('Madrid - Lisbon - Porto', true, NOW(), NOW()),
    ('Turin - Milan - Bologna - Florence - Rome', true, NOW(), NOW()),
    ('Venice - Bologna - Rome - Naples', true, NOW(), NOW()),
    ('Milan Rogoredo - Milan Lampugnano - Rome Tiburtina', true, NOW(), NOW()),
    ('Aarhus - Copenhagen - Gothenburg - Stockholm - Oslo', true, NOW(), NOW()),
    ('Bergen - Oslo - Stockholm', true, NOW(), NOW()),
    ('Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius', true, NOW(), NOW()),
    ('Liepaja - Daugavpils - Riga Airport - Vilnius Airport - Vilnius', true, NOW(), NOW()),
    ('Klaipeda - Kaunas - Vilnius', true, NOW(), NOW()),
    ('Manchester - Birmingham - London', true, NOW(), NOW()),
    ('Amsterdam - Rotterdam - Antwerp - Brussels', true, NOW(), NOW()),
    ('The Hague - Amsterdam Bijlmer - Brussels South - Bruges', true, NOW(), NOW()),
    ('Innsbruck - Salzburg - Linz - Vienna', true, NOW(), NOW()),
    ('Graz - Vienna Westbahnhof - Vienna Hauptbahnhof', true, NOW(), NOW()),
    ('Budapest - Debrecen - Szeged - Pecs', true, NOW(), NOW()),
    ('Budapest Kelenfold - Budapest Stadionok - Budapest Népliget', true, NOW(), NOW()),
    ('Bratislava - Nitra - Košice - Zilina', true, NOW(), NOW()),
    ('Bratislava Petrzalka - Trnava - Nitra', true, NOW(), NOW()),
    ('Koper - Ljubljana - Maribor', true, NOW(), NOW()),
    ('Sofia - Plovdiv - Varna - Burgas', true, NOW(), NOW()),
    ('Timisoara - Cluj-Napoca - Brasov - Bucharest - Constanta', true, NOW(), NOW()),
    ('Sofia - Bucharest - Constanta', true, NOW(), NOW()),
    ('Zagreb - Rijeka - Pula - Zadar - Split', true, NOW(), NOW()),
    ('Split - Dubrovnik - Zagreb', true, NOW(), NOW()),
    ('Kharkiv - Kyiv - Lviv - Lviv Railway - Kyiv Vydubychi', true, NOW(), NOW()),
    ('Prague - Dresden - Berlin ZOB - Berlin Ostbahnhof', true, NOW(), NOW()),
    ('Prague - Brno - Vienna - Bratislava - Budapest', true, NOW(), NOW()),
    ('Prague - Wrocław - Łódź - Warsaw - Bialystok', true, NOW(), NOW()),
    ('Prague - Nuremberg - Frankfurt - Strasbourg - Paris', true, NOW(), NOW()),
    ('Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille', true, NOW(), NOW()),
    ('Prague - Munich - Milan - Nice - Barcelona - Valencia', true, NOW(), NOW()),
    ('Prague - Kraków - Lviv - Kyiv Central - Kyiv Vydubychi', true, NOW(), NOW()),
    ('Paris Bercy - Lille - Brussels North - London Victoria', true, NOW(), NOW())
ON CONFLICT DO NOTHING;

-- ROUTE STOPS
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Prague - Brno - Olomouc - Ostrava' AND t.name = 'Prague Main Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 11, 21, 0.8, 0.04 FROM route r, terminal t WHERE r.name = 'Prague - Brno - Olomouc - Ostrava' AND t.name = 'Prague Florenc'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 169, 179, 185.8, 8.36 FROM route r, terminal t WHERE r.name = 'Prague - Brno - Olomouc - Ostrava' AND t.name = 'Brno Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 231, 241, 251.4, 11.31 FROM route r, terminal t WHERE r.name = 'Prague - Brno - Olomouc - Ostrava' AND t.name = 'Olomouc Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 298, 298, 323.0, 14.54 FROM route r, terminal t WHERE r.name = 'Prague - Brno - Olomouc - Ostrava' AND t.name = 'Ostrava Svinov'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Karlovy Vary - Prague - Pardubice - Ostrava' AND t.name = 'Karlovy Vary Terminal'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 99, 109, 111.3, 5.01 FROM route r, terminal t WHERE r.name = 'Karlovy Vary - Prague - Pardubice - Ostrava' AND t.name = 'Prague Na Knížecí'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 186, 196, 208.1, 9.36 FROM route r, terminal t WHERE r.name = 'Karlovy Vary - Prague - Pardubice - Ostrava' AND t.name = 'Pardubice Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 292, 302, 327.6, 14.74 FROM route r, terminal t WHERE r.name = 'Karlovy Vary - Prague - Pardubice - Ostrava' AND t.name = 'Olomouc Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 363, 363, 404.4, 18.2 FROM route r, terminal t WHERE r.name = 'Karlovy Vary - Prague - Pardubice - Ostrava' AND t.name = 'Ostrava Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Plzeň - Prague - Liberec' AND t.name = 'Plzeň Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 78, 88, 85.0, 3.82 FROM route r, terminal t WHERE r.name = 'Plzeň - Prague - Liberec' AND t.name = 'Prague Main Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 89, 99, 85.8, 3.86 FROM route r, terminal t WHERE r.name = 'Plzeň - Prague - Liberec' AND t.name = 'Prague Florenc'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 168, 168, 172.1, 7.75 FROM route r, terminal t WHERE r.name = 'Plzeň - Prague - Liberec' AND t.name = 'Liberec Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Prague - Brno Zvonařka - Ostrava Svinov' AND t.name = 'Prague Main Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 159, 169, 186.1, 8.37 FROM route r, terminal t WHERE r.name = 'Prague - Brno Zvonařka - Ostrava Svinov' AND t.name = 'Brno Zvonařka'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 277, 277, 321.1, 14.45 FROM route r, terminal t WHERE r.name = 'Prague - Brno Zvonařka - Ostrava Svinov' AND t.name = 'Ostrava Svinov'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Hamburg - Hanover - Kassel - Nuremberg - Munich' AND t.name = 'Hamburg ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 115, 125, 131.7, 5.93 FROM route r, terminal t WHERE r.name = 'Hamburg - Hanover - Kassel - Nuremberg - Munich' AND t.name = 'Hanover Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 396, 406, 471.0, 21.2 FROM route r, terminal t WHERE r.name = 'Hamburg - Hanover - Kassel - Nuremberg - Munich' AND t.name = 'Nuremberg Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 410, 420, 476.5, 21.44 FROM route r, terminal t WHERE r.name = 'Hamburg - Hanover - Kassel - Nuremberg - Munich' AND t.name = 'Nuremberg Airport'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 543, 543, 630.8, 28.39 FROM route r, terminal t WHERE r.name = 'Hamburg - Hanover - Kassel - Nuremberg - Munich' AND t.name = 'Munich ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Dusseldorf - Essen - Dortmund - Duisburg - Berlin' AND t.name = 'Dusseldorf Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 28, 38, 22.5, 1.01 FROM route r, terminal t WHERE r.name = 'Dusseldorf - Essen - Dortmund - Duisburg - Berlin' AND t.name = 'Duisburg Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 51, 61, 39.0, 1.76 FROM route r, terminal t WHERE r.name = 'Dusseldorf - Essen - Dortmund - Duisburg - Berlin' AND t.name = 'Essen Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 87, 97, 71.0, 3.2 FROM route r, terminal t WHERE r.name = 'Dusseldorf - Essen - Dortmund - Duisburg - Berlin' AND t.name = 'Dortmund Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 427, 427, 483.9, 21.78 FROM route r, terminal t WHERE r.name = 'Dusseldorf - Essen - Dortmund - Duisburg - Berlin' AND t.name = 'Berlin ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Munich - Stuttgart - Frankfurt - Cologne' AND t.name = 'Munich Frottmaning'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 158, 168, 184.6, 8.31 FROM route r, terminal t WHERE r.name = 'Munich - Stuttgart - Frankfurt - Cologne' AND t.name = 'Stuttgart Oberturkheim'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 177, 187, 195.4, 8.79 FROM route r, terminal t WHERE r.name = 'Munich - Stuttgart - Frankfurt - Cologne' AND t.name = 'Stuttgart Airport'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 316, 326, 357.1, 16.07 FROM route r, terminal t WHERE r.name = 'Munich - Stuttgart - Frankfurt - Cologne' AND t.name = 'Frankfurt Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 448, 448, 509.3, 22.92 FROM route r, terminal t WHERE r.name = 'Munich - Stuttgart - Frankfurt - Cologne' AND t.name = 'Cologne Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Cologne Airport - Frankfurt Airport - Leipzig - Berlin Ostbahnhof' AND t.name = 'Cologne Airport'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 120, 130, 137.8, 6.2 FROM route r, terminal t WHERE r.name = 'Cologne Airport - Frankfurt Airport - Leipzig - Berlin Ostbahnhof' AND t.name = 'Frankfurt Airport'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 374, 384, 442.5, 19.91 FROM route r, terminal t WHERE r.name = 'Cologne Airport - Frankfurt Airport - Leipzig - Berlin Ostbahnhof' AND t.name = 'Leipzig Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 503, 503, 590.7, 26.58 FROM route r, terminal t WHERE r.name = 'Cologne Airport - Frankfurt Airport - Leipzig - Berlin Ostbahnhof' AND t.name = 'Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Berlin Sudkreuz - Dresden - Munich' AND t.name = 'Berlin Sudkreuz'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 139, 149, 161.8, 7.28 FROM route r, terminal t WHERE r.name = 'Berlin Sudkreuz - Dresden - Munich' AND t.name = 'Dresden Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 436, 436, 520.2, 23.41 FROM route r, terminal t WHERE r.name = 'Berlin Sudkreuz - Dresden - Munich' AND t.name = 'Munich ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Bremen - Hamburg - Berlin ZOB' AND t.name = 'Bremen Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 86, 96, 95.2, 4.28 FROM route r, terminal t WHERE r.name = 'Bremen - Hamburg - Berlin ZOB' AND t.name = 'Hamburg ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 294, 294, 342.5, 15.41 FROM route r, terminal t WHERE r.name = 'Bremen - Hamburg - Berlin ZOB' AND t.name = 'Berlin ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Gdynia - Gdańsk - Warsaw - Kraków' AND t.name = 'Gdynia Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 26, 36, 20.0, 0.9 FROM route r, terminal t WHERE r.name = 'Gdynia - Gdańsk - Warsaw - Kraków' AND t.name = 'Gdańsk Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 263, 273, 303.1, 13.64 FROM route r, terminal t WHERE r.name = 'Gdynia - Gdańsk - Warsaw - Kraków' AND t.name = 'Warsaw Zachodnia'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 275, 285, 305.9, 13.77 FROM route r, terminal t WHERE r.name = 'Gdynia - Gdańsk - Warsaw - Kraków' AND t.name = 'Warsaw Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 486, 486, 557.1, 25.07 FROM route r, terminal t WHERE r.name = 'Gdynia - Gdańsk - Warsaw - Kraków' AND t.name = 'Kraków Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Szczecin - Poznań - Łódź - Warsaw - Lublin' AND t.name = 'Szczecin Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 166, 176, 195.0, 8.78 FROM route r, terminal t WHERE r.name = 'Szczecin - Poznań - Łódź - Warsaw - Lublin' AND t.name = 'Poznań Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 326, 336, 382.8, 17.23 FROM route r, terminal t WHERE r.name = 'Szczecin - Poznań - Łódź - Warsaw - Lublin' AND t.name = 'Łódź Fabryczna'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 433, 443, 504.3, 22.69 FROM route r, terminal t WHERE r.name = 'Szczecin - Poznań - Łódź - Warsaw - Lublin' AND t.name = 'Warsaw Wschodnia'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 565, 565, 656.3, 29.53 FROM route r, terminal t WHERE r.name = 'Szczecin - Poznań - Łódź - Warsaw - Lublin' AND t.name = 'Lublin Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Wrocław - Katowice - Kraków - Bialystok' AND t.name = 'Wrocław Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 144, 154, 167.7, 7.54 FROM route r, terminal t WHERE r.name = 'Wrocław - Katowice - Kraków - Bialystok' AND t.name = 'Katowice Sadowa'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 210, 220, 237.8, 10.7 FROM route r, terminal t WHERE r.name = 'Wrocław - Katowice - Kraków - Bialystok' AND t.name = 'Kraków Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 545, 545, 643.6, 28.96 FROM route r, terminal t WHERE r.name = 'Wrocław - Katowice - Kraków - Bialystok' AND t.name = 'Bialystok Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Lille - Paris - Lyon - Marseille' AND t.name = 'Lille Europe'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 175, 185, 206.7, 9.3 FROM route r, terminal t WHERE r.name = 'Lille - Paris - Lyon - Marseille' AND t.name = 'Paris Bercy Seine'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 497, 507, 596.3, 26.83 FROM route r, terminal t WHERE r.name = 'Lille - Paris - Lyon - Marseille' AND t.name = 'Lyon Perrache'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 727, 737, 871.8, 39.23 FROM route r, terminal t WHERE r.name = 'Lille - Paris - Lyon - Marseille' AND t.name = 'Marseille Saint-Charles'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 753, 753, 891.8, 40.13 FROM route r, terminal t WHERE r.name = 'Lille - Paris - Lyon - Marseille' AND t.name = 'Marseille Airport'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Nantes - Bordeaux - Toulouse - Montpellier - Marseille' AND t.name = 'Nantes Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 233, 243, 278.7, 12.54 FROM route r, terminal t WHERE r.name = 'Nantes - Bordeaux - Toulouse - Montpellier - Marseille' AND t.name = 'Bordeaux Saint-Jean'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 411, 421, 488.1, 21.96 FROM route r, terminal t WHERE r.name = 'Nantes - Bordeaux - Toulouse - Montpellier - Marseille' AND t.name = 'Toulouse Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 576, 586, 681.9, 30.68 FROM route r, terminal t WHERE r.name = 'Nantes - Bordeaux - Toulouse - Montpellier - Marseille' AND t.name = 'Montpellier Sabines'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 687, 687, 808.5, 36.38 FROM route r, terminal t WHERE r.name = 'Nantes - Bordeaux - Toulouse - Montpellier - Marseille' AND t.name = 'Marseille Saint-Charles'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Nice - Cannes - Marseille - Lyon' AND t.name = 'Nice Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 15, 25, 5.7, 0.26 FROM route r, terminal t WHERE r.name = 'Nice - Cannes - Marseille - Lyon' AND t.name = 'Nice Airport'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 26, 36, 6.4, 0.29 FROM route r, terminal t WHERE r.name = 'Nice - Cannes - Marseille - Lyon' AND t.name = 'Nice Airport T2'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 158, 168, 159.1, 7.16 FROM route r, terminal t WHERE r.name = 'Nice - Cannes - Marseille - Lyon' AND t.name = 'Marseille Saint-Charles'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 389, 389, 435.4, 19.6 FROM route r, terminal t WHERE r.name = 'Nice - Cannes - Marseille - Lyon' AND t.name = 'Lyon Part-Dieu'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Paris Gallieni - Paris Pont de Levallois - Strasbourg' AND t.name = 'Paris Gallieni'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 18, 28, 10.3, 0.46 FROM route r, terminal t WHERE r.name = 'Paris Gallieni - Paris Pont de Levallois - Strasbourg' AND t.name = 'Paris Pont de Levallois'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 350, 350, 412.5, 18.56 FROM route r, terminal t WHERE r.name = 'Paris Gallieni - Paris Pont de Levallois - Strasbourg' AND t.name = 'Strasbourg Place de l''Etoile'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Bilbao - San Sebastian - Zaragoza - Madrid - Seville' AND t.name = 'Bilbao Intermodal'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 73, 83, 78.9, 3.55 FROM route r, terminal t WHERE r.name = 'Bilbao - San Sebastian - Zaragoza - Madrid - Seville' AND t.name = 'San Sebastian Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 246, 256, 283.0, 12.74 FROM route r, terminal t WHERE r.name = 'Bilbao - San Sebastian - Zaragoza - Madrid - Seville' AND t.name = 'Zaragoza Delicias'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 473, 483, 554.3, 24.94 FROM route r, terminal t WHERE r.name = 'Bilbao - San Sebastian - Zaragoza - Madrid - Seville' AND t.name = 'Madrid Estacion Sur'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 795, 795, 944.2, 42.49 FROM route r, terminal t WHERE r.name = 'Bilbao - San Sebastian - Zaragoza - Madrid - Seville' AND t.name = 'Seville Plaza de Armas'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Barcelona - Valencia - Alicante - Malaga - Granada' AND t.name = 'Barcelona Sants'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 251, 261, 300.7, 13.53 FROM route r, terminal t WHERE r.name = 'Barcelona - Valencia - Alicante - Malaga - Granada' AND t.name = 'Valencia Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 363, 373, 428.0, 19.26 FROM route r, terminal t WHERE r.name = 'Barcelona - Valencia - Alicante - Malaga - Granada' AND t.name = 'Alicante Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 686, 696, 819.8, 36.89 FROM route r, terminal t WHERE r.name = 'Barcelona - Valencia - Alicante - Malaga - Granada' AND t.name = 'Malaga Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 769, 769, 910.5, 40.97 FROM route r, terminal t WHERE r.name = 'Barcelona - Valencia - Alicante - Malaga - Granada' AND t.name = 'Granada Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Madrid Aeropuerto Barajas - Madrid Avenida de America - Barcelona Sants' AND t.name = 'Madrid Aeropuerto Barajas'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 17, 27, 9.2, 0.41 FROM route r, terminal t WHERE r.name = 'Madrid Aeropuerto Barajas - Madrid Avenida de America - Barcelona Sants' AND t.name = 'Madrid Avenida de America'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 427, 427, 508.9, 22.9 FROM route r, terminal t WHERE r.name = 'Madrid Aeropuerto Barajas - Madrid Avenida de America - Barcelona Sants' AND t.name = 'Barcelona Sants'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Madrid - Lisbon - Porto' AND t.name = 'Madrid Estacion Sur'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 409, 419, 498.3, 22.42 FROM route r, terminal t WHERE r.name = 'Madrid - Lisbon - Porto' AND t.name = 'Lisbon Oriente'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 424, 434, 504.9, 22.72 FROM route r, terminal t WHERE r.name = 'Madrid - Lisbon - Porto' AND t.name = 'Lisbon Sete Rios'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 652, 652, 777.0, 34.96 FROM route r, terminal t WHERE r.name = 'Madrid - Lisbon - Porto' AND t.name = 'Porto Campo 24 de Agosto'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Turin - Milan - Bologna - Florence - Rome' AND t.name = 'Turin Corso Vittorio Emanuele'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 109, 119, 124.1, 5.59 FROM route r, terminal t WHERE r.name = 'Turin - Milan - Bologna - Florence - Rome' AND t.name = 'Milan Lampugnano'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 284, 294, 330.0, 14.85 FROM route r, terminal t WHERE r.name = 'Turin - Milan - Bologna - Florence - Rome' AND t.name = 'Bologna Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 362, 372, 414.7, 18.66 FROM route r, terminal t WHERE r.name = 'Turin - Milan - Bologna - Florence - Rome' AND t.name = 'Florence Villa Constanza'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 558, 558, 647.7, 29.15 FROM route r, terminal t WHERE r.name = 'Turin - Milan - Bologna - Florence - Rome' AND t.name = 'Rome Tiburtina'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Venice - Bologna - Rome - Naples' AND t.name = 'Venice Mestre'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 16, 26, 7.6, 0.34 FROM route r, terminal t WHERE r.name = 'Venice - Bologna - Rome - Naples' AND t.name = 'Venice Tronchetto'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 340, 350, 400.6, 18.03 FROM route r, terminal t WHERE r.name = 'Venice - Bologna - Rome - Naples' AND t.name = 'Rome Tiburtina'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 500, 500, 587.8, 26.45 FROM route r, terminal t WHERE r.name = 'Venice - Bologna - Rome - Naples' AND t.name = 'Naples Metropark'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Milan Rogoredo - Milan Lampugnano - Rome Tiburtina' AND t.name = 'Milan Rogoredo'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 19, 29, 11.0, 0.49 FROM route r, terminal t WHERE r.name = 'Milan Rogoredo - Milan Lampugnano - Rome Tiburtina' AND t.name = 'Milan Lampugnano'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 415, 415, 493.8, 22.22 FROM route r, terminal t WHERE r.name = 'Milan Rogoredo - Milan Lampugnano - Rome Tiburtina' AND t.name = 'Rome Tiburtina'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Aarhus - Copenhagen - Gothenburg - Stockholm - Oslo' AND t.name = 'Aarhus Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 135, 145, 156.7, 7.05 FROM route r, terminal t WHERE r.name = 'Aarhus - Copenhagen - Gothenburg - Stockholm - Oslo' AND t.name = 'Copenhagen Ingerslevsgade'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 329, 339, 386.4, 17.39 FROM route r, terminal t WHERE r.name = 'Aarhus - Copenhagen - Gothenburg - Stockholm - Oslo' AND t.name = 'Gothenburg Nils Ericson'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 656, 666, 782.9, 35.23 FROM route r, terminal t WHERE r.name = 'Aarhus - Copenhagen - Gothenburg - Stockholm - Oslo' AND t.name = 'Stockholm Cityterminalen'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 998, 998, 1198.1, 53.92 FROM route r, terminal t WHERE r.name = 'Aarhus - Copenhagen - Gothenburg - Stockholm - Oslo' AND t.name = 'Oslo Bussterminal'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Bergen - Oslo - Stockholm' AND t.name = 'Bergen Bussterminal'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 254, 264, 304.8, 13.72 FROM route r, terminal t WHERE r.name = 'Bergen - Oslo - Stockholm' AND t.name = 'Oslo Bussterminal'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 596, 596, 720.0, 32.4 FROM route r, terminal t WHERE r.name = 'Bergen - Oslo - Stockholm' AND t.name = 'Stockholm Cityterminalen'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius' AND t.name = 'Tampere Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 138, 148, 159.9, 7.2 FROM route r, terminal t WHERE r.name = 'Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius' AND t.name = 'Helsinki Kamppi'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 214, 224, 242.8, 10.92 FROM route r, terminal t WHERE r.name = 'Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius' AND t.name = 'Tallinn Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 354, 364, 404.9, 18.22 FROM route r, terminal t WHERE r.name = 'Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius' AND t.name = 'Tartu Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 542, 552, 627.6, 28.24 FROM route r, terminal t WHERE r.name = 'Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius' AND t.name = 'Riga Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 6, 735, 745, 856.6, 38.54 FROM route r, terminal t WHERE r.name = 'Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius' AND t.name = 'Kaunas Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 7, 817, 817, 946.7, 42.6 FROM route r, terminal t WHERE r.name = 'Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius' AND t.name = 'Vilnius Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Liepaja - Daugavpils - Riga Airport - Vilnius Airport - Vilnius' AND t.name = 'Liepaja Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 288, 298, 348.0, 15.66 FROM route r, terminal t WHERE r.name = 'Liepaja - Daugavpils - Riga Airport - Vilnius Airport - Vilnius' AND t.name = 'Daugavpils Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 454, 464, 543.3, 24.45 FROM route r, terminal t WHERE r.name = 'Liepaja - Daugavpils - Riga Airport - Vilnius Airport - Vilnius' AND t.name = 'Riga Airport'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 677, 687, 809.5, 36.43 FROM route r, terminal t WHERE r.name = 'Liepaja - Daugavpils - Riga Airport - Vilnius Airport - Vilnius' AND t.name = 'Vilnius Airport'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 690, 690, 812.7, 36.57 FROM route r, terminal t WHERE r.name = 'Liepaja - Daugavpils - Riga Airport - Vilnius Airport - Vilnius' AND t.name = 'Vilnius Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Klaipeda - Kaunas - Vilnius' AND t.name = 'Klaipeda Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 169, 179, 198.9, 8.95 FROM route r, terminal t WHERE r.name = 'Klaipeda - Kaunas - Vilnius' AND t.name = 'Kaunas Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 251, 251, 289.0, 13.0 FROM route r, terminal t WHERE r.name = 'Klaipeda - Kaunas - Vilnius' AND t.name = 'Vilnius Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Manchester - Birmingham - London' AND t.name = 'Manchester Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 101, 111, 113.9, 5.13 FROM route r, terminal t WHERE r.name = 'Manchester - Birmingham - London' AND t.name = 'Birmingham Coach Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 240, 240, 275.7, 12.41 FROM route r, terminal t WHERE r.name = 'Manchester - Birmingham - London' AND t.name = 'London Victoria'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Amsterdam - Rotterdam - Antwerp - Brussels' AND t.name = 'Amsterdam Sloterdijk'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 56, 66, 57.5, 2.59 FROM route r, terminal t WHERE r.name = 'Amsterdam - Rotterdam - Antwerp - Brussels' AND t.name = 'Rotterdam Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 129, 139, 136.0, 6.12 FROM route r, terminal t WHERE r.name = 'Amsterdam - Rotterdam - Antwerp - Brussels' AND t.name = 'Antwerp Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 171, 171, 176.1, 7.92 FROM route r, terminal t WHERE r.name = 'Amsterdam - Rotterdam - Antwerp - Brussels' AND t.name = 'Brussels North'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'The Hague - Amsterdam Bijlmer - Brussels South - Bruges' AND t.name = 'The Hague Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 50, 60, 49.7, 2.24 FROM route r, terminal t WHERE r.name = 'The Hague - Amsterdam Bijlmer - Brussels South - Bruges' AND t.name = 'Amsterdam Bijlmer Arena'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 196, 206, 219.3, 9.87 FROM route r, terminal t WHERE r.name = 'The Hague - Amsterdam Bijlmer - Brussels South - Bruges' AND t.name = 'Brussels South'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 276, 276, 307.2, 13.82 FROM route r, terminal t WHERE r.name = 'The Hague - Amsterdam Bijlmer - Brussels South - Bruges' AND t.name = 'Bruges Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Innsbruck - Salzburg - Linz - Vienna' AND t.name = 'Innsbruck Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 120, 130, 137.7, 6.2 FROM route r, terminal t WHERE r.name = 'Innsbruck - Salzburg - Linz - Vienna' AND t.name = 'Salzburg Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 331, 341, 388.9, 17.5 FROM route r, terminal t WHERE r.name = 'Innsbruck - Salzburg - Linz - Vienna' AND t.name = 'Vienna Hauptbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 342, 342, 390.3, 17.56 FROM route r, terminal t WHERE r.name = 'Innsbruck - Salzburg - Linz - Vienna' AND t.name = 'Vienna International'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Graz - Vienna Westbahnhof - Vienna Hauptbahnhof' AND t.name = 'Graz Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 124, 134, 142.8, 6.42 FROM route r, terminal t WHERE r.name = 'Graz - Vienna Westbahnhof - Vienna Hauptbahnhof' AND t.name = 'Vienna Westbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 137, 137, 145.9, 6.57 FROM route r, terminal t WHERE r.name = 'Graz - Vienna Westbahnhof - Vienna Hauptbahnhof' AND t.name = 'Vienna Hauptbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Budapest - Debrecen - Szeged - Pecs' AND t.name = 'Budapest Népliget'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 162, 172, 190.4, 8.57 FROM route r, terminal t WHERE r.name = 'Budapest - Debrecen - Szeged - Pecs' AND t.name = 'Debrecen Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 316, 326, 370.6, 16.68 FROM route r, terminal t WHERE r.name = 'Budapest - Debrecen - Szeged - Pecs' AND t.name = 'Szeged Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 445, 445, 519.2, 23.37 FROM route r, terminal t WHERE r.name = 'Budapest - Debrecen - Szeged - Pecs' AND t.name = 'Pecs Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Budapest Kelenfold - Budapest Stadionok - Budapest Népliget' AND t.name = 'Budapest Kelenfold'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 16, 26, 7.3, 0.33 FROM route r, terminal t WHERE r.name = 'Budapest Kelenfold - Budapest Stadionok - Budapest Népliget' AND t.name = 'Budapest Stadionok'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 28, 28, 10.3, 0.46 FROM route r, terminal t WHERE r.name = 'Budapest Kelenfold - Budapest Stadionok - Budapest Népliget' AND t.name = 'Budapest Népliget'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Bratislava - Nitra - Košice - Zilina' AND t.name = 'Bratislava Mlynské Nivy'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 67, 77, 71.9, 3.23 FROM route r, terminal t WHERE r.name = 'Bratislava - Nitra - Košice - Zilina' AND t.name = 'Nitra Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 268, 278, 311.3, 14.01 FROM route r, terminal t WHERE r.name = 'Bratislava - Nitra - Košice - Zilina' AND t.name = 'Košice Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 432, 432, 503.6, 22.66 FROM route r, terminal t WHERE r.name = 'Bratislava - Nitra - Košice - Zilina' AND t.name = 'Zilina Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Bratislava Petrzalka - Trnava - Nitra' AND t.name = 'Bratislava Petrzalka'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 46, 56, 45.0, 2.02 FROM route r, terminal t WHERE r.name = 'Bratislava Petrzalka - Trnava - Nitra' AND t.name = 'Trnava Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 86, 86, 82.0, 3.69 FROM route r, terminal t WHERE r.name = 'Bratislava Petrzalka - Trnava - Nitra' AND t.name = 'Nitra Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Koper - Ljubljana - Maribor' AND t.name = 'Koper Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 76, 86, 83.0, 3.74 FROM route r, terminal t WHERE r.name = 'Koper - Ljubljana - Maribor' AND t.name = 'Ljubljana Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 169, 169, 187.0, 8.41 FROM route r, terminal t WHERE r.name = 'Koper - Ljubljana - Maribor' AND t.name = 'Maribor Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Sofia - Plovdiv - Varna - Burgas' AND t.name = 'Sofia Central Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 10, 20, 0.2, 0.01 FROM route r, terminal t WHERE r.name = 'Sofia - Plovdiv - Varna - Burgas' AND t.name = 'Sofia Serdika'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 127, 137, 133.7, 6.02 FROM route r, terminal t WHERE r.name = 'Sofia - Plovdiv - Varna - Burgas' AND t.name = 'Plovdiv South Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 364, 364, 417.8, 18.8 FROM route r, terminal t WHERE r.name = 'Sofia - Plovdiv - Varna - Burgas' AND t.name = 'Varna Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Timisoara - Cluj-Napoca - Brasov - Bucharest - Constanta' AND t.name = 'Timisoara Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 181, 191, 214.1, 9.63 FROM route r, terminal t WHERE r.name = 'Timisoara - Cluj-Napoca - Brasov - Bucharest - Constanta' AND t.name = 'Cluj-Napoca Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 351, 361, 413.6, 18.61 FROM route r, terminal t WHERE r.name = 'Timisoara - Cluj-Napoca - Brasov - Bucharest - Constanta' AND t.name = 'Brasov Bus Station 1'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 476, 486, 557.3, 25.08 FROM route r, terminal t WHERE r.name = 'Timisoara - Cluj-Napoca - Brasov - Bucharest - Constanta' AND t.name = 'Bucharest Filaret'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 649, 649, 760.8, 34.24 FROM route r, terminal t WHERE r.name = 'Timisoara - Cluj-Napoca - Brasov - Bucharest - Constanta' AND t.name = 'Constanta Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Sofia - Bucharest - Constanta' AND t.name = 'Sofia Central Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 10, 20, 0.2, 0.01 FROM route r, terminal t WHERE r.name = 'Sofia - Bucharest - Constanta' AND t.name = 'Sofia Serdika'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 251, 261, 288.7, 12.99 FROM route r, terminal t WHERE r.name = 'Sofia - Bucharest - Constanta' AND t.name = 'Bucharest Militari'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 267, 277, 296.2, 13.33 FROM route r, terminal t WHERE r.name = 'Sofia - Bucharest - Constanta' AND t.name = 'Bucharest Filaret'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 440, 440, 499.7, 22.49 FROM route r, terminal t WHERE r.name = 'Sofia - Bucharest - Constanta' AND t.name = 'Constanta Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Zagreb - Rijeka - Pula - Zadar - Split' AND t.name = 'Zagreb Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 116, 126, 132.4, 5.96 FROM route r, terminal t WHERE r.name = 'Zagreb - Rijeka - Pula - Zadar - Split' AND t.name = 'Rijeka Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 180, 190, 200.5, 9.02 FROM route r, terminal t WHERE r.name = 'Zagreb - Rijeka - Pula - Zadar - Split' AND t.name = 'Pula Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 301, 311, 339.8, 15.29 FROM route r, terminal t WHERE r.name = 'Zagreb - Rijeka - Pula - Zadar - Split' AND t.name = 'Zadar Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 405, 405, 457.3, 20.58 FROM route r, terminal t WHERE r.name = 'Zagreb - Rijeka - Pula - Zadar - Split' AND t.name = 'Split Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Split - Dubrovnik - Zagreb' AND t.name = 'Split Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 140, 150, 162.7, 7.32 FROM route r, terminal t WHERE r.name = 'Split - Dubrovnik - Zagreb' AND t.name = 'Dubrovnik Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 460, 460, 549.6, 24.73 FROM route r, terminal t WHERE r.name = 'Split - Dubrovnik - Zagreb' AND t.name = 'Zagreb Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Kharkiv - Kyiv - Lviv - Lviv Railway - Kyiv Vydubychi' AND t.name = 'Kharkiv Central Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 338, 348, 410.0, 18.45 FROM route r, terminal t WHERE r.name = 'Kharkiv - Kyiv - Lviv - Lviv Railway - Kyiv Vydubychi' AND t.name = 'Kyiv Central Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 723, 733, 879.1, 39.56 FROM route r, terminal t WHERE r.name = 'Kharkiv - Kyiv - Lviv - Lviv Railway - Kyiv Vydubychi' AND t.name = 'Lviv Central Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 738, 748, 885.4, 39.84 FROM route r, terminal t WHERE r.name = 'Kharkiv - Kyiv - Lviv - Lviv Railway - Kyiv Vydubychi' AND t.name = 'Lviv Railway Station Bus Stop'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 1126, 1126, 1357.5, 61.09 FROM route r, terminal t WHERE r.name = 'Kharkiv - Kyiv - Lviv - Lviv Railway - Kyiv Vydubychi' AND t.name = 'Kyiv Vydubychi Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Prague - Dresden - Berlin ZOB - Berlin Ostbahnhof' AND t.name = 'Prague Main Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 104, 114, 117.3, 5.28 FROM route r, terminal t WHERE r.name = 'Prague - Dresden - Berlin ZOB - Berlin Ostbahnhof' AND t.name = 'Dresden Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 247, 257, 283.5, 12.76 FROM route r, terminal t WHERE r.name = 'Prague - Dresden - Berlin ZOB - Berlin Ostbahnhof' AND t.name = 'Berlin ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 265, 265, 294.0, 13.23 FROM route r, terminal t WHERE r.name = 'Prague - Dresden - Berlin ZOB - Berlin Ostbahnhof' AND t.name = 'Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Prague - Brno - Vienna - Bratislava - Budapest' AND t.name = 'Prague Main Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 158, 168, 185.1, 8.33 FROM route r, terminal t WHERE r.name = 'Prague - Brno - Vienna - Bratislava - Budapest' AND t.name = 'Brno Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 259, 269, 298.7, 13.44 FROM route r, terminal t WHERE r.name = 'Prague - Brno - Vienna - Bratislava - Budapest' AND t.name = 'Vienna Hauptbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 314, 324, 355.3, 15.99 FROM route r, terminal t WHERE r.name = 'Prague - Brno - Vienna - Bratislava - Budapest' AND t.name = 'Bratislava Mlynské Nivy'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 455, 455, 518.8, 23.34 FROM route r, terminal t WHERE r.name = 'Prague - Brno - Vienna - Bratislava - Budapest' AND t.name = 'Budapest Népliget'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Prague - Wrocław - Łódź - Warsaw - Bialystok' AND t.name = 'Prague Main Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 182, 192, 215.4, 9.69 FROM route r, terminal t WHERE r.name = 'Prague - Wrocław - Łódź - Warsaw - Bialystok' AND t.name = 'Wrocław Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 340, 350, 400.0, 18.0 FROM route r, terminal t WHERE r.name = 'Prague - Wrocław - Łódź - Warsaw - Bialystok' AND t.name = 'Łódź Fabryczna'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 441, 451, 514.0, 23.13 FROM route r, terminal t WHERE r.name = 'Prague - Wrocław - Łódź - Warsaw - Bialystok' AND t.name = 'Warsaw Zachodnia'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 594, 594, 692.5, 31.16 FROM route r, terminal t WHERE r.name = 'Prague - Wrocław - Łódź - Warsaw - Bialystok' AND t.name = 'Bialystok Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Prague - Nuremberg - Frankfurt - Strasbourg - Paris' AND t.name = 'Prague Main Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 211, 221, 250.9, 11.29 FROM route r, terminal t WHERE r.name = 'Prague - Nuremberg - Frankfurt - Strasbourg - Paris' AND t.name = 'Nuremberg Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 372, 382, 439.4, 19.77 FROM route r, terminal t WHERE r.name = 'Prague - Nuremberg - Frankfurt - Strasbourg - Paris' AND t.name = 'Frankfurt Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 528, 538, 621.8, 27.98 FROM route r, terminal t WHERE r.name = 'Prague - Nuremberg - Frankfurt - Strasbourg - Paris' AND t.name = 'Strasbourg Place de l''Etoile'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 854, 864, 1017.0, 45.76 FROM route r, terminal t WHERE r.name = 'Prague - Nuremberg - Frankfurt - Strasbourg - Paris' AND t.name = 'Paris Bercy Seine'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 6, 867, 867, 1021.2, 45.96 FROM route r, terminal t WHERE r.name = 'Prague - Nuremberg - Frankfurt - Strasbourg - Paris' AND t.name = 'Paris Gallieni'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille' AND t.name = 'Prague Main Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 251, 261, 301.0, 13.55 FROM route r, terminal t WHERE r.name = 'Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille' AND t.name = 'Munich ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 450, 460, 537.0, 24.17 FROM route r, terminal t WHERE r.name = 'Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille' AND t.name = 'Zurich Airport'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 466, 476, 545.1, 24.53 FROM route r, terminal t WHERE r.name = 'Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille' AND t.name = 'Zurich Carparkplatz'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 535, 545, 618.9, 27.85 FROM route r, terminal t WHERE r.name = 'Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille' AND t.name = 'Basel SBB'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 6, 693, 703, 803.5, 36.16 FROM route r, terminal t WHERE r.name = 'Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille' AND t.name = 'Geneva Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 7, 795, 805, 918.0, 41.31 FROM route r, terminal t WHERE r.name = 'Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille' AND t.name = 'Lyon Perrache'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 8, 1025, 1025, 1193.5, 53.71 FROM route r, terminal t WHERE r.name = 'Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille' AND t.name = 'Marseille Saint-Charles'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Prague - Munich - Milan - Nice - Barcelona - Valencia' AND t.name = 'Prague Main Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 251, 261, 301.0, 13.55 FROM route r, terminal t WHERE r.name = 'Prague - Munich - Milan - Nice - Barcelona - Valencia' AND t.name = 'Munich ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 539, 549, 648.8, 29.2 FROM route r, terminal t WHERE r.name = 'Prague - Munich - Milan - Nice - Barcelona - Valencia' AND t.name = 'Milan Lampugnano'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 747, 757, 896.3, 40.33 FROM route r, terminal t WHERE r.name = 'Prague - Munich - Milan - Nice - Barcelona - Valencia' AND t.name = 'Nice Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 1151, 1161, 1389.0, 62.5 FROM route r, terminal t WHERE r.name = 'Prague - Munich - Milan - Nice - Barcelona - Valencia' AND t.name = 'Barcelona Sants'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 6, 1402, 1412, 1689.7, 76.04 FROM route r, terminal t WHERE r.name = 'Prague - Munich - Milan - Nice - Barcelona - Valencia' AND t.name = 'Valencia Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 7, 1514, 1514, 1817.0, 81.76 FROM route r, terminal t WHERE r.name = 'Prague - Munich - Milan - Nice - Barcelona - Valencia' AND t.name = 'Alicante Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Prague - Kraków - Lviv - Kyiv Central - Kyiv Vydubychi' AND t.name = 'Prague Main Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 325, 335, 393.5, 17.71 FROM route r, terminal t WHERE r.name = 'Prague - Kraków - Lviv - Kyiv Central - Kyiv Vydubychi' AND t.name = 'Kraków Central'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 569, 579, 686.2, 30.88 FROM route r, terminal t WHERE r.name = 'Prague - Kraków - Lviv - Kyiv Central - Kyiv Vydubychi' AND t.name = 'Lviv Central Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 954, 964, 1155.3, 51.99 FROM route r, terminal t WHERE r.name = 'Prague - Kraków - Lviv - Kyiv Central - Kyiv Vydubychi' AND t.name = 'Kyiv Central Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 5, 966, 966, 1158.1, 52.11 FROM route r, terminal t WHERE r.name = 'Prague - Kraków - Lviv - Kyiv Central - Kyiv Vydubychi' AND t.name = 'Kyiv Vydubychi Bus Station'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 1, 0, 10, 0.0, 0.0 FROM route r, terminal t WHERE r.name = 'Paris Bercy - Lille - Brussels North - London Victoria' AND t.name = 'Paris Bercy Seine'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 2, 175, 185, 206.7, 9.3 FROM route r, terminal t WHERE r.name = 'Paris Bercy - Lille - Brussels North - London Victoria' AND t.name = 'Lille Europe'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 3, 260, 270, 300.3, 13.51 FROM route r, terminal t WHERE r.name = 'Paris Bercy - Lille - Brussels North - London Victoria' AND t.name = 'Brussels North'
ON CONFLICT DO NOTHING;
INSERT INTO route_stop (route_id, terminal_id, sequence_order, arrival_offset_minutes, departure_offset_minutes, distance_from_origin, base_price_from_origin)
SELECT r.id, t.id, 4, 528, 528, 622.2, 28.0 FROM route r, terminal t WHERE r.name = 'Paris Bercy - Lille - Brussels North - London Victoria' AND t.name = 'London Victoria'
ON CONFLICT DO NOTHING;

-- BUSES ON ROUTES
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-001' AND r.name = 'Prague - Brno - Olomouc - Ostrava'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-002' AND r.name = 'Prague - Brno - Olomouc - Ostrava'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-003' AND r.name = 'Prague - Brno - Olomouc - Ostrava'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-004' AND r.name = 'Prague - Brno - Olomouc - Ostrava'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-005' AND r.name = 'Karlovy Vary - Prague - Pardubice - Ostrava'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-006' AND r.name = 'Karlovy Vary - Prague - Pardubice - Ostrava'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-007' AND r.name = 'Karlovy Vary - Prague - Pardubice - Ostrava'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-008' AND r.name = 'Karlovy Vary - Prague - Pardubice - Ostrava'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-009' AND r.name = 'Plzeň - Prague - Liberec'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-010' AND r.name = 'Plzeň - Prague - Liberec'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-011' AND r.name = 'Plzeň - Prague - Liberec'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-012' AND r.name = 'Plzeň - Prague - Liberec'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-013' AND r.name = 'Prague - Brno Zvonařka - Ostrava Svinov'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-014' AND r.name = 'Prague - Brno Zvonařka - Ostrava Svinov'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-015' AND r.name = 'Prague - Brno Zvonařka - Ostrava Svinov'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-016' AND r.name = 'Prague - Brno Zvonařka - Ostrava Svinov'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-017' AND r.name = 'Hamburg - Hanover - Kassel - Nuremberg - Munich'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-018' AND r.name = 'Hamburg - Hanover - Kassel - Nuremberg - Munich'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-019' AND r.name = 'Hamburg - Hanover - Kassel - Nuremberg - Munich'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-020' AND r.name = 'Hamburg - Hanover - Kassel - Nuremberg - Munich'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-021' AND r.name = 'Dusseldorf - Essen - Dortmund - Duisburg - Berlin'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-022' AND r.name = 'Dusseldorf - Essen - Dortmund - Duisburg - Berlin'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-023' AND r.name = 'Dusseldorf - Essen - Dortmund - Duisburg - Berlin'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-024' AND r.name = 'Dusseldorf - Essen - Dortmund - Duisburg - Berlin'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-025' AND r.name = 'Munich - Stuttgart - Frankfurt - Cologne'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-026' AND r.name = 'Munich - Stuttgart - Frankfurt - Cologne'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-027' AND r.name = 'Munich - Stuttgart - Frankfurt - Cologne'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-028' AND r.name = 'Munich - Stuttgart - Frankfurt - Cologne'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-029' AND r.name = 'Cologne Airport - Frankfurt Airport - Leipzig - Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-030' AND r.name = 'Cologne Airport - Frankfurt Airport - Leipzig - Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-031' AND r.name = 'Cologne Airport - Frankfurt Airport - Leipzig - Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-032' AND r.name = 'Cologne Airport - Frankfurt Airport - Leipzig - Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-033' AND r.name = 'Berlin Sudkreuz - Dresden - Munich'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-034' AND r.name = 'Berlin Sudkreuz - Dresden - Munich'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-035' AND r.name = 'Berlin Sudkreuz - Dresden - Munich'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-036' AND r.name = 'Berlin Sudkreuz - Dresden - Munich'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-037' AND r.name = 'Bremen - Hamburg - Berlin ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-038' AND r.name = 'Bremen - Hamburg - Berlin ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-039' AND r.name = 'Bremen - Hamburg - Berlin ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-040' AND r.name = 'Bremen - Hamburg - Berlin ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-041' AND r.name = 'Gdynia - Gdańsk - Warsaw - Kraków'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-042' AND r.name = 'Gdynia - Gdańsk - Warsaw - Kraków'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-043' AND r.name = 'Gdynia - Gdańsk - Warsaw - Kraków'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-044' AND r.name = 'Gdynia - Gdańsk - Warsaw - Kraków'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-045' AND r.name = 'Szczecin - Poznań - Łódź - Warsaw - Lublin'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-046' AND r.name = 'Szczecin - Poznań - Łódź - Warsaw - Lublin'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-047' AND r.name = 'Szczecin - Poznań - Łódź - Warsaw - Lublin'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-048' AND r.name = 'Szczecin - Poznań - Łódź - Warsaw - Lublin'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-049' AND r.name = 'Wrocław - Katowice - Kraków - Bialystok'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-050' AND r.name = 'Wrocław - Katowice - Kraków - Bialystok'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-051' AND r.name = 'Wrocław - Katowice - Kraków - Bialystok'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-052' AND r.name = 'Wrocław - Katowice - Kraków - Bialystok'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-053' AND r.name = 'Lille - Paris - Lyon - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-054' AND r.name = 'Lille - Paris - Lyon - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-055' AND r.name = 'Lille - Paris - Lyon - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-056' AND r.name = 'Lille - Paris - Lyon - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-057' AND r.name = 'Nantes - Bordeaux - Toulouse - Montpellier - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-058' AND r.name = 'Nantes - Bordeaux - Toulouse - Montpellier - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-059' AND r.name = 'Nantes - Bordeaux - Toulouse - Montpellier - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-060' AND r.name = 'Nantes - Bordeaux - Toulouse - Montpellier - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-061' AND r.name = 'Nice - Cannes - Marseille - Lyon'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-062' AND r.name = 'Nice - Cannes - Marseille - Lyon'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-063' AND r.name = 'Nice - Cannes - Marseille - Lyon'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-064' AND r.name = 'Nice - Cannes - Marseille - Lyon'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-065' AND r.name = 'Paris Gallieni - Paris Pont de Levallois - Strasbourg'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-066' AND r.name = 'Paris Gallieni - Paris Pont de Levallois - Strasbourg'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-067' AND r.name = 'Paris Gallieni - Paris Pont de Levallois - Strasbourg'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-068' AND r.name = 'Paris Gallieni - Paris Pont de Levallois - Strasbourg'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-069' AND r.name = 'Bilbao - San Sebastian - Zaragoza - Madrid - Seville'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-070' AND r.name = 'Bilbao - San Sebastian - Zaragoza - Madrid - Seville'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-071' AND r.name = 'Bilbao - San Sebastian - Zaragoza - Madrid - Seville'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-072' AND r.name = 'Bilbao - San Sebastian - Zaragoza - Madrid - Seville'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-073' AND r.name = 'Barcelona - Valencia - Alicante - Malaga - Granada'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-074' AND r.name = 'Barcelona - Valencia - Alicante - Malaga - Granada'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-075' AND r.name = 'Barcelona - Valencia - Alicante - Malaga - Granada'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-076' AND r.name = 'Barcelona - Valencia - Alicante - Malaga - Granada'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-077' AND r.name = 'Madrid Aeropuerto Barajas - Madrid Avenida de America - Barcelona Sants'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-078' AND r.name = 'Madrid Aeropuerto Barajas - Madrid Avenida de America - Barcelona Sants'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-079' AND r.name = 'Madrid Aeropuerto Barajas - Madrid Avenida de America - Barcelona Sants'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-080' AND r.name = 'Madrid Aeropuerto Barajas - Madrid Avenida de America - Barcelona Sants'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-081' AND r.name = 'Madrid - Lisbon - Porto'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-082' AND r.name = 'Madrid - Lisbon - Porto'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-083' AND r.name = 'Madrid - Lisbon - Porto'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-084' AND r.name = 'Madrid - Lisbon - Porto'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-085' AND r.name = 'Turin - Milan - Bologna - Florence - Rome'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-086' AND r.name = 'Turin - Milan - Bologna - Florence - Rome'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-087' AND r.name = 'Turin - Milan - Bologna - Florence - Rome'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-088' AND r.name = 'Turin - Milan - Bologna - Florence - Rome'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-089' AND r.name = 'Venice - Bologna - Rome - Naples'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-090' AND r.name = 'Venice - Bologna - Rome - Naples'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-091' AND r.name = 'Venice - Bologna - Rome - Naples'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-092' AND r.name = 'Venice - Bologna - Rome - Naples'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-093' AND r.name = 'Milan Rogoredo - Milan Lampugnano - Rome Tiburtina'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-094' AND r.name = 'Milan Rogoredo - Milan Lampugnano - Rome Tiburtina'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-095' AND r.name = 'Milan Rogoredo - Milan Lampugnano - Rome Tiburtina'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-096' AND r.name = 'Milan Rogoredo - Milan Lampugnano - Rome Tiburtina'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-097' AND r.name = 'Aarhus - Copenhagen - Gothenburg - Stockholm - Oslo'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-098' AND r.name = 'Aarhus - Copenhagen - Gothenburg - Stockholm - Oslo'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-099' AND r.name = 'Aarhus - Copenhagen - Gothenburg - Stockholm - Oslo'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-100' AND r.name = 'Aarhus - Copenhagen - Gothenburg - Stockholm - Oslo'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-101' AND r.name = 'Bergen - Oslo - Stockholm'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-102' AND r.name = 'Bergen - Oslo - Stockholm'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-103' AND r.name = 'Bergen - Oslo - Stockholm'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-104' AND r.name = 'Bergen - Oslo - Stockholm'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-105' AND r.name = 'Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-106' AND r.name = 'Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-107' AND r.name = 'Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-108' AND r.name = 'Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-109' AND r.name = 'Liepaja - Daugavpils - Riga Airport - Vilnius Airport - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-110' AND r.name = 'Liepaja - Daugavpils - Riga Airport - Vilnius Airport - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-111' AND r.name = 'Liepaja - Daugavpils - Riga Airport - Vilnius Airport - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-112' AND r.name = 'Liepaja - Daugavpils - Riga Airport - Vilnius Airport - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-113' AND r.name = 'Klaipeda - Kaunas - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-114' AND r.name = 'Klaipeda - Kaunas - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-115' AND r.name = 'Klaipeda - Kaunas - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-116' AND r.name = 'Klaipeda - Kaunas - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-117' AND r.name = 'Manchester - Birmingham - London'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-118' AND r.name = 'Manchester - Birmingham - London'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-119' AND r.name = 'Manchester - Birmingham - London'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-120' AND r.name = 'Manchester - Birmingham - London'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-121' AND r.name = 'Amsterdam - Rotterdam - Antwerp - Brussels'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-122' AND r.name = 'Amsterdam - Rotterdam - Antwerp - Brussels'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-123' AND r.name = 'Amsterdam - Rotterdam - Antwerp - Brussels'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-124' AND r.name = 'Amsterdam - Rotterdam - Antwerp - Brussels'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-125' AND r.name = 'The Hague - Amsterdam Bijlmer - Brussels South - Bruges'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-126' AND r.name = 'The Hague - Amsterdam Bijlmer - Brussels South - Bruges'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-127' AND r.name = 'The Hague - Amsterdam Bijlmer - Brussels South - Bruges'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-128' AND r.name = 'The Hague - Amsterdam Bijlmer - Brussels South - Bruges'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-129' AND r.name = 'Innsbruck - Salzburg - Linz - Vienna'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-130' AND r.name = 'Innsbruck - Salzburg - Linz - Vienna'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-131' AND r.name = 'Innsbruck - Salzburg - Linz - Vienna'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-132' AND r.name = 'Innsbruck - Salzburg - Linz - Vienna'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-133' AND r.name = 'Graz - Vienna Westbahnhof - Vienna Hauptbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-134' AND r.name = 'Graz - Vienna Westbahnhof - Vienna Hauptbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-135' AND r.name = 'Graz - Vienna Westbahnhof - Vienna Hauptbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-136' AND r.name = 'Graz - Vienna Westbahnhof - Vienna Hauptbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-137' AND r.name = 'Budapest - Debrecen - Szeged - Pecs'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-138' AND r.name = 'Budapest - Debrecen - Szeged - Pecs'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-139' AND r.name = 'Budapest - Debrecen - Szeged - Pecs'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-140' AND r.name = 'Budapest - Debrecen - Szeged - Pecs'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-141' AND r.name = 'Budapest Kelenfold - Budapest Stadionok - Budapest Népliget'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-142' AND r.name = 'Budapest Kelenfold - Budapest Stadionok - Budapest Népliget'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-143' AND r.name = 'Budapest Kelenfold - Budapest Stadionok - Budapest Népliget'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-144' AND r.name = 'Budapest Kelenfold - Budapest Stadionok - Budapest Népliget'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-145' AND r.name = 'Bratislava - Nitra - Košice - Zilina'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-146' AND r.name = 'Bratislava - Nitra - Košice - Zilina'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-147' AND r.name = 'Bratislava - Nitra - Košice - Zilina'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-148' AND r.name = 'Bratislava - Nitra - Košice - Zilina'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-149' AND r.name = 'Bratislava Petrzalka - Trnava - Nitra'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-150' AND r.name = 'Bratislava Petrzalka - Trnava - Nitra'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-151' AND r.name = 'Bratislava Petrzalka - Trnava - Nitra'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-152' AND r.name = 'Bratislava Petrzalka - Trnava - Nitra'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-153' AND r.name = 'Koper - Ljubljana - Maribor'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-154' AND r.name = 'Koper - Ljubljana - Maribor'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-155' AND r.name = 'Koper - Ljubljana - Maribor'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-156' AND r.name = 'Koper - Ljubljana - Maribor'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-157' AND r.name = 'Sofia - Plovdiv - Varna - Burgas'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-158' AND r.name = 'Sofia - Plovdiv - Varna - Burgas'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-159' AND r.name = 'Sofia - Plovdiv - Varna - Burgas'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-160' AND r.name = 'Sofia - Plovdiv - Varna - Burgas'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-161' AND r.name = 'Timisoara - Cluj-Napoca - Brasov - Bucharest - Constanta'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-162' AND r.name = 'Timisoara - Cluj-Napoca - Brasov - Bucharest - Constanta'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-163' AND r.name = 'Timisoara - Cluj-Napoca - Brasov - Bucharest - Constanta'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-164' AND r.name = 'Timisoara - Cluj-Napoca - Brasov - Bucharest - Constanta'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-165' AND r.name = 'Sofia - Bucharest - Constanta'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-166' AND r.name = 'Sofia - Bucharest - Constanta'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-167' AND r.name = 'Sofia - Bucharest - Constanta'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-168' AND r.name = 'Sofia - Bucharest - Constanta'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-169' AND r.name = 'Zagreb - Rijeka - Pula - Zadar - Split'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-170' AND r.name = 'Zagreb - Rijeka - Pula - Zadar - Split'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-171' AND r.name = 'Zagreb - Rijeka - Pula - Zadar - Split'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-172' AND r.name = 'Zagreb - Rijeka - Pula - Zadar - Split'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-173' AND r.name = 'Split - Dubrovnik - Zagreb'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-174' AND r.name = 'Split - Dubrovnik - Zagreb'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-175' AND r.name = 'Split - Dubrovnik - Zagreb'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-176' AND r.name = 'Split - Dubrovnik - Zagreb'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-177' AND r.name = 'Kharkiv - Kyiv - Lviv - Lviv Railway - Kyiv Vydubychi'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-178' AND r.name = 'Kharkiv - Kyiv - Lviv - Lviv Railway - Kyiv Vydubychi'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-179' AND r.name = 'Kharkiv - Kyiv - Lviv - Lviv Railway - Kyiv Vydubychi'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-180' AND r.name = 'Kharkiv - Kyiv - Lviv - Lviv Railway - Kyiv Vydubychi'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-181' AND r.name = 'Prague - Dresden - Berlin ZOB - Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-182' AND r.name = 'Prague - Dresden - Berlin ZOB - Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-183' AND r.name = 'Prague - Dresden - Berlin ZOB - Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-184' AND r.name = 'Prague - Dresden - Berlin ZOB - Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-185' AND r.name = 'Prague - Brno - Vienna - Bratislava - Budapest'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-186' AND r.name = 'Prague - Brno - Vienna - Bratislava - Budapest'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-187' AND r.name = 'Prague - Brno - Vienna - Bratislava - Budapest'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-188' AND r.name = 'Prague - Brno - Vienna - Bratislava - Budapest'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-189' AND r.name = 'Prague - Wrocław - Łódź - Warsaw - Bialystok'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-190' AND r.name = 'Prague - Wrocław - Łódź - Warsaw - Bialystok'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-191' AND r.name = 'Prague - Wrocław - Łódź - Warsaw - Bialystok'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-192' AND r.name = 'Prague - Wrocław - Łódź - Warsaw - Bialystok'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-193' AND r.name = 'Prague - Nuremberg - Frankfurt - Strasbourg - Paris'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-194' AND r.name = 'Prague - Nuremberg - Frankfurt - Strasbourg - Paris'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-195' AND r.name = 'Prague - Nuremberg - Frankfurt - Strasbourg - Paris'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-196' AND r.name = 'Prague - Nuremberg - Frankfurt - Strasbourg - Paris'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-197' AND r.name = 'Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-198' AND r.name = 'Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-199' AND r.name = 'Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-200' AND r.name = 'Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-201' AND r.name = 'Prague - Munich - Milan - Nice - Barcelona - Valencia'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-202' AND r.name = 'Prague - Munich - Milan - Nice - Barcelona - Valencia'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-203' AND r.name = 'Prague - Munich - Milan - Nice - Barcelona - Valencia'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-204' AND r.name = 'Prague - Munich - Milan - Nice - Barcelona - Valencia'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-205' AND r.name = 'Prague - Kraków - Lviv - Kyiv Central - Kyiv Vydubychi'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-206' AND r.name = 'Prague - Kraków - Lviv - Kyiv Central - Kyiv Vydubychi'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-207' AND r.name = 'Prague - Kraków - Lviv - Kyiv Central - Kyiv Vydubychi'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-208' AND r.name = 'Prague - Kraków - Lviv - Kyiv Central - Kyiv Vydubychi'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-209' AND r.name = 'Paris Bercy - Lille - Brussels North - London Victoria'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-210' AND r.name = 'Paris Bercy - Lille - Brussels North - London Victoria'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-211' AND r.name = 'Paris Bercy - Lille - Brussels North - London Victoria'
ON CONFLICT DO NOTHING;
INSERT INTO buses_on_routes (bus_id, route_id)
SELECT b.id, r.id FROM bus b, route r WHERE b.registration_number = 'BUS-212' AND r.name = 'Paris Bercy - Lille - Brussels North - London Victoria'
ON CONFLICT DO NOTHING;

-- DRIVERS ON ROUTES
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'lukas.martin@driver.omnibus.com' AND r.name = 'Prague - Brno - Olomouc - Ostrava'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'piotr.santos@driver.omnibus.com' AND r.name = 'Prague - Brno - Olomouc - Ostrava'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'volodymyr.dimitrov@driver.omnibus.com' AND r.name = 'Prague - Brno - Olomouc - Ostrava'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'giuseppe.bianchi@driver.omnibus.com' AND r.name = 'Prague - Brno - Olomouc - Ostrava'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'lukas.meyer@driver.omnibus.com' AND r.name = 'Karlovy Vary - Prague - Pardubice - Ostrava'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'hans.radu@driver.omnibus.com' AND r.name = 'Karlovy Vary - Prague - Pardubice - Ostrava'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'dmitri.garcia@driver.omnibus.com' AND r.name = 'Karlovy Vary - Prague - Pardubice - Ostrava'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'giuseppe.martinez@driver.omnibus.com' AND r.name = 'Karlovy Vary - Prague - Pardubice - Ostrava'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andreas.schmidt@driver.omnibus.com' AND r.name = 'Plzeň - Prague - Liberec'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'sergey.nilsson@driver.omnibus.com' AND r.name = 'Plzeň - Prague - Liberec'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'pavel.petrov@driver.omnibus.com' AND r.name = 'Plzeň - Prague - Liberec'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'petr.andersson@driver.omnibus.com' AND r.name = 'Plzeň - Prague - Liberec'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'vladimir.sokolov@driver.omnibus.com' AND r.name = 'Prague - Brno Zvonařka - Ostrava Svinov'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'dmitry.sokolov@driver.omnibus.com' AND r.name = 'Prague - Brno Zvonařka - Ostrava Svinov'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'michel.shevchenko@driver.omnibus.com' AND r.name = 'Prague - Brno Zvonařka - Ostrava Svinov'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'robert.bauer@driver.omnibus.com' AND r.name = 'Prague - Brno Zvonařka - Ostrava Svinov'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andre.schmidt@driver.omnibus.com' AND r.name = 'Hamburg - Hanover - Kassel - Nuremberg - Munich'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'dmitry.olsen@driver.omnibus.com' AND r.name = 'Hamburg - Hanover - Kassel - Nuremberg - Munich'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andreas.nowak@driver.omnibus.com' AND r.name = 'Hamburg - Hanover - Kassel - Nuremberg - Munich'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'ivan.dvorak@driver.omnibus.com' AND r.name = 'Hamburg - Hanover - Kassel - Nuremberg - Munich'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'krzysztof.nilsson@driver.omnibus.com' AND r.name = 'Dusseldorf - Essen - Dortmund - Duisburg - Berlin'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jiri.mueller@driver.omnibus.com' AND r.name = 'Dusseldorf - Essen - Dortmund - Duisburg - Berlin'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'peter.sokolov@driver.omnibus.com' AND r.name = 'Dusseldorf - Essen - Dortmund - Duisburg - Berlin'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'robert.santos@driver.omnibus.com' AND r.name = 'Dusseldorf - Essen - Dortmund - Duisburg - Berlin'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'mikhail.martinez@driver.omnibus.com' AND r.name = 'Munich - Stuttgart - Frankfurt - Cologne'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'dmitry.martin@driver.omnibus.com' AND r.name = 'Munich - Stuttgart - Frankfurt - Cologne'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'pavel.popov@driver.omnibus.com' AND r.name = 'Munich - Stuttgart - Frankfurt - Cologne'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'petr.schulz@driver.omnibus.com' AND r.name = 'Munich - Stuttgart - Frankfurt - Cologne'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'yury.svoboda@driver.omnibus.com' AND r.name = 'Cologne Airport - Frankfurt Airport - Leipzig - Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'piotr.hofmann@driver.omnibus.com' AND r.name = 'Cologne Airport - Frankfurt Airport - Leipzig - Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'stefan.fischer@driver.omnibus.com' AND r.name = 'Cologne Airport - Frankfurt Airport - Leipzig - Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'vasyl.prochazka@driver.omnibus.com' AND r.name = 'Cologne Airport - Frankfurt Airport - Leipzig - Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jean.dubois@driver.omnibus.com' AND r.name = 'Berlin Sudkreuz - Dresden - Munich'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'peter.andersson@driver.omnibus.com' AND r.name = 'Berlin Sudkreuz - Dresden - Munich'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'lars.martin@driver.omnibus.com' AND r.name = 'Berlin Sudkreuz - Dresden - Munich'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'lars.wagner@driver.omnibus.com' AND r.name = 'Berlin Sudkreuz - Dresden - Munich'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'vladimir.kolar@driver.omnibus.com' AND r.name = 'Bremen - Hamburg - Berlin ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andreas.bauer@driver.omnibus.com' AND r.name = 'Bremen - Hamburg - Berlin ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'piotr.sokolov@driver.omnibus.com' AND r.name = 'Bremen - Hamburg - Berlin ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'krzysztof.kovalenko@driver.omnibus.com' AND r.name = 'Bremen - Hamburg - Berlin ZOB'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'lars.popescu@driver.omnibus.com' AND r.name = 'Gdynia - Gdańsk - Warsaw - Kraków'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andrzej.nilsson@driver.omnibus.com' AND r.name = 'Gdynia - Gdańsk - Warsaw - Kraków'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'pierre.schmidt@driver.omnibus.com' AND r.name = 'Gdynia - Gdańsk - Warsaw - Kraków'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andreas.novak@driver.omnibus.com' AND r.name = 'Gdynia - Gdańsk - Warsaw - Kraków'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'vasyl.cerny@driver.omnibus.com' AND r.name = 'Szczecin - Poznań - Łódź - Warsaw - Lublin'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'oleksandr.dimitrov@driver.omnibus.com' AND r.name = 'Szczecin - Poznań - Łódź - Warsaw - Lublin'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'giuseppe.volkov@driver.omnibus.com' AND r.name = 'Szczecin - Poznań - Łódź - Warsaw - Lublin'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'james.kovalenko@driver.omnibus.com' AND r.name = 'Szczecin - Poznań - Łódź - Warsaw - Lublin'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'lukas.martinez@driver.omnibus.com' AND r.name = 'Wrocław - Katowice - Kraków - Bialystok'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'peter.cerny@driver.omnibus.com' AND r.name = 'Wrocław - Katowice - Kraków - Bialystok'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'antonio.silva@driver.omnibus.com' AND r.name = 'Wrocław - Katowice - Kraków - Bialystok'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'erik.fischer@driver.omnibus.com' AND r.name = 'Wrocław - Katowice - Kraków - Bialystok'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'hans.andersson@driver.omnibus.com' AND r.name = 'Lille - Paris - Lyon - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'petr.hofmann@driver.omnibus.com' AND r.name = 'Lille - Paris - Lyon - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'marco.petrov@driver.omnibus.com' AND r.name = 'Lille - Paris - Lyon - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'dmitri.gruber@driver.omnibus.com' AND r.name = 'Lille - Paris - Lyon - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'oleksandr.huber@driver.omnibus.com' AND r.name = 'Nantes - Bordeaux - Toulouse - Montpellier - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'tomasz.fischer@driver.omnibus.com' AND r.name = 'Nantes - Bordeaux - Toulouse - Montpellier - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'martin.santos@driver.omnibus.com' AND r.name = 'Nantes - Bordeaux - Toulouse - Montpellier - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'antonio.langer@driver.omnibus.com' AND r.name = 'Nantes - Bordeaux - Toulouse - Montpellier - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'sergey.morozov@driver.omnibus.com' AND r.name = 'Nice - Cannes - Marseille - Lyon'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'petr.petrov@driver.omnibus.com' AND r.name = 'Nice - Cannes - Marseille - Lyon'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'martin.fischer@driver.omnibus.com' AND r.name = 'Nice - Cannes - Marseille - Lyon'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'carlos.morozov@driver.omnibus.com' AND r.name = 'Nice - Cannes - Marseille - Lyon'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'david.sokolov@driver.omnibus.com' AND r.name = 'Paris Gallieni - Paris Pont de Levallois - Strasbourg'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'igor.fischer@driver.omnibus.com' AND r.name = 'Paris Gallieni - Paris Pont de Levallois - Strasbourg'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'antonio.petrov@driver.omnibus.com' AND r.name = 'Paris Gallieni - Paris Pont de Levallois - Strasbourg'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'sven.rossi@driver.omnibus.com' AND r.name = 'Paris Gallieni - Paris Pont de Levallois - Strasbourg'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'david.radu@driver.omnibus.com' AND r.name = 'Bilbao - San Sebastian - Zaragoza - Madrid - Seville'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'marco.dvorak@driver.omnibus.com' AND r.name = 'Bilbao - San Sebastian - Zaragoza - Madrid - Seville'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'krzysztof.andersson@driver.omnibus.com' AND r.name = 'Bilbao - San Sebastian - Zaragoza - Madrid - Seville'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'marco.kovalenko@driver.omnibus.com' AND r.name = 'Bilbao - San Sebastian - Zaragoza - Madrid - Seville'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'carlos.kowalski@driver.omnibus.com' AND r.name = 'Barcelona - Valencia - Alicante - Malaga - Granada'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'vladimir.bauer@driver.omnibus.com' AND r.name = 'Barcelona - Valencia - Alicante - Malaga - Granada'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'stefan.hansen@driver.omnibus.com' AND r.name = 'Barcelona - Valencia - Alicante - Malaga - Granada'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jozef.silva@driver.omnibus.com' AND r.name = 'Barcelona - Valencia - Alicante - Malaga - Granada'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andrey.bauer@driver.omnibus.com' AND r.name = 'Madrid Aeropuerto Barajas - Madrid Avenida de America - Barcelona Sants'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'krzysztof.wagner@driver.omnibus.com' AND r.name = 'Madrid Aeropuerto Barajas - Madrid Avenida de America - Barcelona Sants'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jozef.prochazka@driver.omnibus.com' AND r.name = 'Madrid Aeropuerto Barajas - Madrid Avenida de America - Barcelona Sants'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'sergey.kolar@driver.omnibus.com' AND r.name = 'Madrid Aeropuerto Barajas - Madrid Avenida de America - Barcelona Sants'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'volodymyr.santos@driver.omnibus.com' AND r.name = 'Madrid - Lisbon - Porto'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'pierre.bauer@driver.omnibus.com' AND r.name = 'Madrid - Lisbon - Porto'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'erik.svoboda@driver.omnibus.com' AND r.name = 'Madrid - Lisbon - Porto'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'michel.radu@driver.omnibus.com' AND r.name = 'Madrid - Lisbon - Porto'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'piotr.rossi@driver.omnibus.com' AND r.name = 'Turin - Milan - Bologna - Florence - Rome'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'alexey.wagner@driver.omnibus.com' AND r.name = 'Turin - Milan - Bologna - Florence - Rome'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'lars.schulz@driver.omnibus.com' AND r.name = 'Turin - Milan - Bologna - Florence - Rome'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jiri.silva@driver.omnibus.com' AND r.name = 'Turin - Milan - Bologna - Florence - Rome'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andrzej.garcia@driver.omnibus.com' AND r.name = 'Venice - Bologna - Rome - Naples'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'vladimir.olsen@driver.omnibus.com' AND r.name = 'Venice - Bologna - Rome - Naples'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'miguel.kovac@driver.omnibus.com' AND r.name = 'Venice - Bologna - Rome - Naples'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jiri.popov@driver.omnibus.com' AND r.name = 'Venice - Bologna - Rome - Naples'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'miguel.novak@driver.omnibus.com' AND r.name = 'Milan Rogoredo - Milan Lampugnano - Rome Tiburtina'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jozef.nowak@driver.omnibus.com' AND r.name = 'Milan Rogoredo - Milan Lampugnano - Rome Tiburtina'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'mikhail.radu@driver.omnibus.com' AND r.name = 'Milan Rogoredo - Milan Lampugnano - Rome Tiburtina'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'petr.garcia@driver.omnibus.com' AND r.name = 'Milan Rogoredo - Milan Lampugnano - Rome Tiburtina'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'carlos.nilsson@driver.omnibus.com' AND r.name = 'Aarhus - Copenhagen - Gothenburg - Stockholm - Oslo'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'milan.sokolov@driver.omnibus.com' AND r.name = 'Aarhus - Copenhagen - Gothenburg - Stockholm - Oslo'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andrey.gruber@driver.omnibus.com' AND r.name = 'Aarhus - Copenhagen - Gothenburg - Stockholm - Oslo'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'marco.kowalski@driver.omnibus.com' AND r.name = 'Aarhus - Copenhagen - Gothenburg - Stockholm - Oslo'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jan.santos@driver.omnibus.com' AND r.name = 'Bergen - Oslo - Stockholm'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'alexander.morozov@driver.omnibus.com' AND r.name = 'Bergen - Oslo - Stockholm'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'krzysztof.prochazka@driver.omnibus.com' AND r.name = 'Bergen - Oslo - Stockholm'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'tomasz.dimitrov@driver.omnibus.com' AND r.name = 'Bergen - Oslo - Stockholm'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jozef.kovalenko@driver.omnibus.com' AND r.name = 'Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'dmitri.morozov@driver.omnibus.com' AND r.name = 'Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'john.kovac@driver.omnibus.com' AND r.name = 'Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'martin.dimitrov@driver.omnibus.com' AND r.name = 'Tampere - Helsinki - Tallinn - Tartu - Riga - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'milan.prochazka@driver.omnibus.com' AND r.name = 'Liepaja - Daugavpils - Riga Airport - Vilnius Airport - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'robert.fischer@driver.omnibus.com' AND r.name = 'Liepaja - Daugavpils - Riga Airport - Vilnius Airport - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andre.fischer@driver.omnibus.com' AND r.name = 'Liepaja - Daugavpils - Riga Airport - Vilnius Airport - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'sven.mueller@driver.omnibus.com' AND r.name = 'Liepaja - Daugavpils - Riga Airport - Vilnius Airport - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jan.martinez@driver.omnibus.com' AND r.name = 'Klaipeda - Kaunas - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'sergey.dvorak@driver.omnibus.com' AND r.name = 'Klaipeda - Kaunas - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'pierre.meyer@driver.omnibus.com' AND r.name = 'Klaipeda - Kaunas - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jiri.olsen@driver.omnibus.com' AND r.name = 'Klaipeda - Kaunas - Vilnius'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'james.kowalski@driver.omnibus.com' AND r.name = 'Manchester - Birmingham - London'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'stefan.volkov@driver.omnibus.com' AND r.name = 'Manchester - Birmingham - London'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'volodymyr.radu@driver.omnibus.com' AND r.name = 'Manchester - Birmingham - London'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'pavel.dvorak@driver.omnibus.com' AND r.name = 'Manchester - Birmingham - London'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'alexander.kovalenko@driver.omnibus.com' AND r.name = 'Amsterdam - Rotterdam - Antwerp - Brussels'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'martin.shevchenko@driver.omnibus.com' AND r.name = 'Amsterdam - Rotterdam - Antwerp - Brussels'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'james.cerny@driver.omnibus.com' AND r.name = 'Amsterdam - Rotterdam - Antwerp - Brussels'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'marco.novak@driver.omnibus.com' AND r.name = 'Amsterdam - Rotterdam - Antwerp - Brussels'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'peter.rossi@driver.omnibus.com' AND r.name = 'The Hague - Amsterdam Bijlmer - Brussels South - Bruges'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andreas.garcia@driver.omnibus.com' AND r.name = 'The Hague - Amsterdam Bijlmer - Brussels South - Bruges'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'lars.dimitrov@driver.omnibus.com' AND r.name = 'The Hague - Amsterdam Bijlmer - Brussels South - Bruges'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'tomasz.radu@driver.omnibus.com' AND r.name = 'The Hague - Amsterdam Bijlmer - Brussels South - Bruges'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'james.hansen@driver.omnibus.com' AND r.name = 'Innsbruck - Salzburg - Linz - Vienna'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'erik.dimitrov@driver.omnibus.com' AND r.name = 'Innsbruck - Salzburg - Linz - Vienna'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andrey.shevchenko@driver.omnibus.com' AND r.name = 'Innsbruck - Salzburg - Linz - Vienna'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'dmitry.bondarenko@driver.omnibus.com' AND r.name = 'Innsbruck - Salzburg - Linz - Vienna'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'martin.radu@driver.omnibus.com' AND r.name = 'Graz - Vienna Westbahnhof - Vienna Hauptbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'oleksandr.olsen@driver.omnibus.com' AND r.name = 'Graz - Vienna Westbahnhof - Vienna Hauptbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'lars.horvat@driver.omnibus.com' AND r.name = 'Graz - Vienna Westbahnhof - Vienna Hauptbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'piotr.becker@driver.omnibus.com' AND r.name = 'Graz - Vienna Westbahnhof - Vienna Hauptbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'hans.kovac@driver.omnibus.com' AND r.name = 'Budapest - Debrecen - Szeged - Pecs'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'david.meyer@driver.omnibus.com' AND r.name = 'Budapest - Debrecen - Szeged - Pecs'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'volodymyr.kovalenko@driver.omnibus.com' AND r.name = 'Budapest - Debrecen - Szeged - Pecs'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'nikolay.schmidt@driver.omnibus.com' AND r.name = 'Budapest - Debrecen - Szeged - Pecs'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'pierre.martin@driver.omnibus.com' AND r.name = 'Budapest Kelenfold - Budapest Stadionok - Budapest Népliget'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'nikolay.ivanov@driver.omnibus.com' AND r.name = 'Budapest Kelenfold - Budapest Stadionok - Budapest Népliget'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'richard.dubois@driver.omnibus.com' AND r.name = 'Budapest Kelenfold - Budapest Stadionok - Budapest Népliget'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'vladimir.hofmann@driver.omnibus.com' AND r.name = 'Budapest Kelenfold - Budapest Stadionok - Budapest Népliget'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jan.novak@driver.omnibus.com' AND r.name = 'Bratislava - Nitra - Košice - Zilina'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'yury.shevchenko@driver.omnibus.com' AND r.name = 'Bratislava - Nitra - Košice - Zilina'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'vladimir.cerny@driver.omnibus.com' AND r.name = 'Bratislava - Nitra - Košice - Zilina'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'hans.wagner@driver.omnibus.com' AND r.name = 'Bratislava - Nitra - Košice - Zilina'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'krzysztof.dimitrov@driver.omnibus.com' AND r.name = 'Bratislava Petrzalka - Trnava - Nitra'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andrey.kolar@driver.omnibus.com' AND r.name = 'Bratislava Petrzalka - Trnava - Nitra'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jean.huber@driver.omnibus.com' AND r.name = 'Bratislava Petrzalka - Trnava - Nitra'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'miguel.nilsson@driver.omnibus.com' AND r.name = 'Bratislava Petrzalka - Trnava - Nitra'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'marc.bondarenko@driver.omnibus.com' AND r.name = 'Koper - Ljubljana - Maribor'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jozef.andersson@driver.omnibus.com' AND r.name = 'Koper - Ljubljana - Maribor'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'miguel.rossi@driver.omnibus.com' AND r.name = 'Koper - Ljubljana - Maribor'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'david.dubois@driver.omnibus.com' AND r.name = 'Koper - Ljubljana - Maribor'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'erik.dubois@driver.omnibus.com' AND r.name = 'Sofia - Plovdiv - Varna - Burgas'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'john.hansen@driver.omnibus.com' AND r.name = 'Sofia - Plovdiv - Varna - Burgas'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andrey.dimitrov@driver.omnibus.com' AND r.name = 'Sofia - Plovdiv - Varna - Burgas'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'michel.morozov@driver.omnibus.com' AND r.name = 'Sofia - Plovdiv - Varna - Burgas'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'giuseppe.radu@driver.omnibus.com' AND r.name = 'Timisoara - Cluj-Napoca - Brasov - Bucharest - Constanta'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'david.martin@driver.omnibus.com' AND r.name = 'Timisoara - Cluj-Napoca - Brasov - Bucharest - Constanta'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'volodymyr.bondarenko@driver.omnibus.com' AND r.name = 'Timisoara - Cluj-Napoca - Brasov - Bucharest - Constanta'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'oleksandr.ivanov@driver.omnibus.com' AND r.name = 'Timisoara - Cluj-Napoca - Brasov - Bucharest - Constanta'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'robert.dimitrov@driver.omnibus.com' AND r.name = 'Sofia - Bucharest - Constanta'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'vasyl.dubois@driver.omnibus.com' AND r.name = 'Sofia - Bucharest - Constanta'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'carlos.shevchenko@driver.omnibus.com' AND r.name = 'Sofia - Bucharest - Constanta'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'volodymyr.czech@driver.omnibus.com' AND r.name = 'Sofia - Bucharest - Constanta'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'lukas.schmidt@driver.omnibus.com' AND r.name = 'Zagreb - Rijeka - Pula - Zadar - Split'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'ivan.silva@driver.omnibus.com' AND r.name = 'Zagreb - Rijeka - Pula - Zadar - Split'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'alexey.dvorak@driver.omnibus.com' AND r.name = 'Zagreb - Rijeka - Pula - Zadar - Split'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'milan.meyer@driver.omnibus.com' AND r.name = 'Zagreb - Rijeka - Pula - Zadar - Split'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'carlos.olsen@driver.omnibus.com' AND r.name = 'Split - Dubrovnik - Zagreb'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'vladimir.silva@driver.omnibus.com' AND r.name = 'Split - Dubrovnik - Zagreb'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jean.olsen@driver.omnibus.com' AND r.name = 'Split - Dubrovnik - Zagreb'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'carlos.hansen@driver.omnibus.com' AND r.name = 'Split - Dubrovnik - Zagreb'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'alexander.bianchi@driver.omnibus.com' AND r.name = 'Kharkiv - Kyiv - Lviv - Lviv Railway - Kyiv Vydubychi'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'michel.lopez@driver.omnibus.com' AND r.name = 'Kharkiv - Kyiv - Lviv - Lviv Railway - Kyiv Vydubychi'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'peter.weber@driver.omnibus.com' AND r.name = 'Kharkiv - Kyiv - Lviv - Lviv Railway - Kyiv Vydubychi'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'miguel.bondarenko@driver.omnibus.com' AND r.name = 'Kharkiv - Kyiv - Lviv - Lviv Railway - Kyiv Vydubychi'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andrey.hofmann@driver.omnibus.com' AND r.name = 'Prague - Dresden - Berlin ZOB - Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'john.dimitrov@driver.omnibus.com' AND r.name = 'Prague - Dresden - Berlin ZOB - Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'erik.silva@driver.omnibus.com' AND r.name = 'Prague - Dresden - Berlin ZOB - Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'marco.nilsson@driver.omnibus.com' AND r.name = 'Prague - Dresden - Berlin ZOB - Berlin Ostbahnhof'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'marc.dvorak@driver.omnibus.com' AND r.name = 'Prague - Brno - Vienna - Bratislava - Budapest'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'dmitry.wagner@driver.omnibus.com' AND r.name = 'Prague - Brno - Vienna - Bratislava - Budapest'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jean.petrov@driver.omnibus.com' AND r.name = 'Prague - Brno - Vienna - Bratislava - Budapest'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'sven.martinez@driver.omnibus.com' AND r.name = 'Prague - Brno - Vienna - Bratislava - Budapest'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'jozef.volkov@driver.omnibus.com' AND r.name = 'Prague - Wrocław - Łódź - Warsaw - Bialystok'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andrzej.prochazka@driver.omnibus.com' AND r.name = 'Prague - Wrocław - Łódź - Warsaw - Bialystok'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'sergey.kovac@driver.omnibus.com' AND r.name = 'Prague - Wrocław - Łódź - Warsaw - Bialystok'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'andrey.horvat@driver.omnibus.com' AND r.name = 'Prague - Wrocław - Łódź - Warsaw - Bialystok'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'sven.hofmann@driver.omnibus.com' AND r.name = 'Prague - Nuremberg - Frankfurt - Strasbourg - Paris'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'marc.santos@driver.omnibus.com' AND r.name = 'Prague - Nuremberg - Frankfurt - Strasbourg - Paris'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'marc.kowalski@driver.omnibus.com' AND r.name = 'Prague - Nuremberg - Frankfurt - Strasbourg - Paris'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'pierre.shevchenko@driver.omnibus.com' AND r.name = 'Prague - Nuremberg - Frankfurt - Strasbourg - Paris'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'lukas.rossi@driver.omnibus.com' AND r.name = 'Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'thomas.dvorak@driver.omnibus.com' AND r.name = 'Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'alexander.schmidt@driver.omnibus.com' AND r.name = 'Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'miguel.silva@driver.omnibus.com' AND r.name = 'Prague - Munich - Zurich Airport - Zurich - Basel - Geneva - Lyon - Marseille'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'nikolay.nowak@driver.omnibus.com' AND r.name = 'Prague - Munich - Milan - Nice - Barcelona - Valencia'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'igor.gruber@driver.omnibus.com' AND r.name = 'Prague - Munich - Milan - Nice - Barcelona - Valencia'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'tomasz.meyer@driver.omnibus.com' AND r.name = 'Prague - Munich - Milan - Nice - Barcelona - Valencia'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'milan.hansen@driver.omnibus.com' AND r.name = 'Prague - Munich - Milan - Nice - Barcelona - Valencia'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'dmitri.wagner@driver.omnibus.com' AND r.name = 'Prague - Kraków - Lviv - Kyiv Central - Kyiv Vydubychi'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'stefan.silva@driver.omnibus.com' AND r.name = 'Prague - Kraków - Lviv - Kyiv Central - Kyiv Vydubychi'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'pierre.gruber@driver.omnibus.com' AND r.name = 'Prague - Kraków - Lviv - Kyiv Central - Kyiv Vydubychi'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'krzysztof.hofmann@driver.omnibus.com' AND r.name = 'Prague - Kraków - Lviv - Kyiv Central - Kyiv Vydubychi'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'thomas.ivanov@driver.omnibus.com' AND r.name = 'Paris Bercy - Lille - Brussels North - London Victoria'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'sven.kovac@driver.omnibus.com' AND r.name = 'Paris Bercy - Lille - Brussels North - London Victoria'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'sven.svoboda@driver.omnibus.com' AND r.name = 'Paris Bercy - Lille - Brussels North - London Victoria'
ON CONFLICT DO NOTHING;
INSERT INTO drivers_on_routes (driver_id, route_id)
SELECT d.user_id, r.id FROM driver d JOIN "user" u ON d.user_id = u.id, route r WHERE u.email = 'martin.kovalenko@driver.omnibus.com' AND r.name = 'Paris Bercy - Lille - Brussels North - London Victoria'
ON CONFLICT DO NOTHING;
