
-- MySQL schema for Esports Ticketing (billeterie)
DROP DATABASE IF EXISTS esports_billeterie;
CREATE DATABASE esports_billeterie CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE esports_billeterie;

CREATE TABLE events (
  event_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  venue VARCHAR(255),
  start_date DATETIME,
  end_date DATETIME,
  capacity INT DEFAULT 10000,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE clients (
  client_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(200) UNIQUE,
  phone VARCHAR(30),
  city VARCHAR(100),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  client_id INT NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(30) DEFAULT 'paid',
  FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tickets (
  ticket_id INT AUTO_INCREMENT PRIMARY KEY,
  event_id INT NOT NULL,
  client_id INT NOT NULL,
  order_id INT,
  category VARCHAR(50),
  price DECIMAL(8,2),
  seat VARCHAR(50),
  purchase_date DATETIME,
  status VARCHAR(30) DEFAULT 'valid',
  qr_code VARCHAR(255),
  FOREIGN KEY (event_id) REFERENCES events(event_id) ON DELETE CASCADE,
  FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE,
  FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  method VARCHAR(50),
  paid_at DATETIME,
  status VARCHAR(30) DEFAULT 'completed',
  FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Index for quick lookup
CREATE INDEX idx_ticket_event ON tickets(event_id);
CREATE INDEX idx_ticket_client ON tickets(client_id);


-- EVENTS
INSERT INTO events (event_id, name, description, venue, start_date, end_date, capacity, created_at) VALUES (1, 'LoL Worlds 2025 - Play-In', 'LoL Worlds 2025 - Play-In at Accor Arena, Paris — International League of Legends Championship event.', 'Accor Arena, Paris', '2025-10-20 23:00:00', '2025-10-21 03:00:00', 5000, NOW());
INSERT INTO events (event_id, name, description, venue, start_date, end_date, capacity, created_at) VALUES (2, 'LoL Worlds 2025 - Group Stage Day 1', 'LoL Worlds 2025 - Group Stage Day 1 at T-Mobile Arena, Las Vegas — International League of Legends Championship event.', 'T-Mobile Arena, Las Vegas', '2025-10-23 18:00:00', '2025-10-23 22:00:00', 10000, NOW());
INSERT INTO events (event_id, name, description, venue, start_date, end_date, capacity, created_at) VALUES (3, 'LoL Worlds 2025 - Group Stage Day 2', 'LoL Worlds 2025 - Group Stage Day 2 at Mx Arena, Seoul — International League of Legends Championship event.', 'Mx Arena, Seoul', '2025-10-26 19:00:00', '2025-10-26 23:00:00', 8000, NOW());
INSERT INTO events (event_id, name, description, venue, start_date, end_date, capacity, created_at) VALUES (4, 'LoL Worlds 2025 - Quarterfinals', 'LoL Worlds 2025 - Quarterfinals at SAP Center, San Jose — International League of Legends Championship event.', 'SAP Center, San Jose', '2025-10-29 19:00:00', '2025-10-29 23:00:00', 5000, NOW());
INSERT INTO events (event_id, name, description, venue, start_date, end_date, capacity, created_at) VALUES (5, 'LoL Worlds 2025 - Quarterfinals Day 2', 'LoL Worlds 2025 - Quarterfinals Day 2 at Shanghai Esports Stadium — International League of Legends Championship event.', 'Shanghai Esports Stadium', '2025-11-01 23:00:00', '2025-11-02 03:00:00', 5000, NOW());
INSERT INTO events (event_id, name, description, venue, start_date, end_date, capacity, created_at) VALUES (6, 'LoL Worlds 2025 - Semifinals', 'LoL Worlds 2025 - Semifinals at Avicii Arena, Stockholm — International League of Legends Championship event.', 'Avicii Arena, Stockholm', '2025-11-04 22:00:00', '2025-11-05 02:00:00', 15000, NOW());
INSERT INTO events (event_id, name, description, venue, start_date, end_date, capacity, created_at) VALUES (7, 'LoL Worlds 2025 - Finals', 'LoL Worlds 2025 - Finals at Helsinki Arena — International League of Legends Championship event.', 'Helsinki Arena', '2025-11-07 18:00:00', '2025-11-07 22:00:00', 5000, NOW());
INSERT INTO events (event_id, name, description, venue, start_date, end_date, capacity, created_at) VALUES (8, 'LoL Worlds 2025 - Opening Ceremony', 'LoL Worlds 2025 - Opening Ceremony at Olympiahalle, Munich — International League of Legends Championship event.', 'Olympiahalle, Munich', '2025-11-10 18:00:00', '2025-11-10 22:00:00', 8000, NOW());
INSERT INTO events (event_id, name, description, venue, start_date, end_date, capacity, created_at) VALUES (9, 'LoL Worlds 2025 - Fan Festival', 'LoL Worlds 2025 - Fan Festival at Estadio Movistar, Madrid — International League of Legends Championship event.', 'Estadio Movistar, Madrid', '2025-11-13 19:00:00', '2025-11-13 23:00:00', 5000, NOW());
INSERT INTO events (event_id, name, description, venue, start_date, end_date, capacity, created_at) VALUES (10, 'LoL Worlds 2025 - Closing Party', 'LoL Worlds 2025 - Closing Party at ExCeL London — International League of Legends Championship event.', 'ExCeL London', '2025-11-16 22:00:00', '2025-11-17 02:00:00', 8000, NOW());

-- CLIENTS
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (1, 'Oliver', 'Rossi', 'oliver.rossi1@example.com', '+89582334538', 'San Jose', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (2, 'Aiden', 'Dupont', 'aiden.dupont2@example.com', '+73849621470', 'Helsinki', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (3, 'Zoe', 'Carvalho', 'zoe.carvalho3@example.com', '+72331191390', 'Stockholm', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (4, 'Sofia', 'Smith', 'sofia.smith4@example.com', '+130203848421', 'Stockholm', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (5, 'Leo', 'Kim', 'leo.kim5@example.com', '+100966647391', 'Paris', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (6, 'Ava', 'Ivanov', 'ava.ivanov6@example.com', '+64506448196', 'Seoul', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (7, 'Oliver', 'Khan', 'oliver.khan7@example.com', '+193764130526', 'Stockholm', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (8, 'Isabella', 'Brown', 'isabella.brown8@example.com', '+50149203558', 'Shanghai', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (9, 'Chloe', 'Smith', 'chloe.smith9@example.com', '+92208449460', 'Helsinki', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (10, 'Aiden', 'Moreau', 'aiden.moreau10@example.com', '+195995619255', 'Stockholm', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (11, 'Olivia', 'Wang', 'olivia.wang11@example.com', '+123324956459', 'Madrid', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (12, 'Liam', 'Kim', 'liam.kim12@example.com', '+195283758720', 'London', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (13, 'Mia', 'Silva', 'mia.silva13@example.com', '+151507437181', 'Madrid', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (14, 'Oliver', 'Johnson', 'oliver.johnson14@example.com', '+116924970419', 'Paris', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (15, 'Mia', 'Martin', 'mia.martin15@example.com', '+113530747414', 'Madrid', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (16, 'Liam', 'Brown', 'liam.brown16@example.com', '+178870854579', 'Stockholm', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (17, 'Ethan', 'Lopez', 'ethan.lopez17@example.com', '+134790256940', 'Munich', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (18, 'Noah', 'Carvalho', 'noah.carvalho18@example.com', '+68364814270', 'London', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (19, 'Oliver', 'Carvalho', 'oliver.carvalho19@example.com', '+182560027313', 'San Jose', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (20, 'Evelyn', 'Wang', 'evelyn.wang20@example.com', '+89248532577', 'London', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (21, 'Logan', 'Smith', 'logan.smith21@example.com', '+45217734861', 'Las Vegas', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (22, 'Olivia', 'Rossi', 'olivia.rossi22@example.com', '+185168212356', 'Helsinki', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (23, 'Evelyn', 'Kim', 'evelyn.kim23@example.com', '+152668132202', 'Madrid', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (24, 'Oliver', 'Dupont', 'oliver.dupont24@example.com', '+62831980933', 'London', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (25, 'Aiden', 'Lefevre', 'aiden.lefevre25@example.com', '+61415143362', 'Helsinki', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (26, 'Olivia', 'Moreau', 'olivia.moreau26@example.com', '+33875340444', 'Madrid', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (27, 'Luna', 'Silva', 'luna.silva27@example.com', '+162214257751', 'Madrid', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (28, 'Luna', 'Kim', 'luna.kim28@example.com', '+83264109919', 'Stockholm', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (29, 'Olivia', 'Ivanov', 'olivia.ivanov29@example.com', '+168100614068', 'San Jose', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (30, 'Zoe', 'Lopez', 'zoe.lopez30@example.com', '+37220117054', 'Stockholm', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (31, 'Chloe', 'Johnson', 'chloe.johnson31@example.com', '+47358633898', 'San Jose', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (32, 'Liam', 'Smith', 'liam.smith32@example.com', '+157976198296', 'Seoul', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (33, 'Oliver', 'Nguyen', 'oliver.nguyen33@example.com', '+65808402051', 'Munich', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (34, 'Oliver', 'Silva', 'oliver.silva34@example.com', '+100666585408', 'San Jose', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (35, 'Mason', 'Brown', 'mason.brown35@example.com', '+171910959828', 'Shanghai', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (36, 'Chloe', 'O''Neil', 'chloe.o''neil36@example.com', '+199500957212', 'Munich', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (37, 'Luna', 'Moreau', 'luna.moreau37@example.com', '+63366186631', 'Shanghai', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (38, 'Liam', 'Lefevre', 'liam.lefevre38@example.com', '+38731691672', 'London', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (39, 'Mia', 'Sato', 'mia.sato39@example.com', '+89107721109', 'Seoul', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (40, 'Emma', 'Johnson', 'emma.johnson40@example.com', '+50133729406', 'Stockholm', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (41, 'Liam', 'Schmidt', 'liam.schmidt41@example.com', '+93399012686', 'Munich', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (42, 'Ethan', 'Ivanov', 'ethan.ivanov42@example.com', '+66876693898', 'San Jose', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (43, 'Isabella', 'Lopez', 'isabella.lopez43@example.com', '+95942478695', 'Munich', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (44, 'Mason', 'Brown', 'mason.brown44@example.com', '+57204078666', 'Helsinki', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (45, 'Leo', 'Rossi', 'leo.rossi45@example.com', '+138601463916', 'Paris', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (46, 'Sofia', 'Martin', 'sofia.martin46@example.com', '+136881913386', 'Stockholm', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (47, 'Sofia', 'Johnson', 'sofia.johnson47@example.com', '+82304235259', 'London', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (48, 'Ava', 'Nguyen', 'ava.nguyen48@example.com', '+141297018781', 'Madrid', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (49, 'Ava', 'Johnson', 'ava.johnson49@example.com', '+52575808013', 'London', NOW());
INSERT INTO clients (client_id, first_name, last_name, email, phone, city, created_at) VALUES (50, 'Sofia', 'Martin', 'sofia.martin50@example.com', '+199680451872', 'Paris', NOW());

-- ORDERS
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (1, 6, 45.00, '2025-10-03 18:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (2, 25, 120.00, '2025-09-30 19:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (3, 4, 30.00, '2025-10-09 07:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (4, 11, 30.00, '2025-10-15 02:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (5, 8, 45.00, '2025-11-10 09:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (6, 34, 75.00, '2025-10-19 14:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (7, 42, 120.00, '2025-10-31 09:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (8, 7, 45.00, '2025-10-18 11:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (9, 29, 75.00, '2025-11-11 22:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (10, 43, 45.00, '2025-10-13 10:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (11, 46, 45.00, '2025-10-03 14:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (12, 6, 75.00, '2025-10-21 13:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (13, 46, 30.00, '2025-10-03 17:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (14, 36, 120.00, '2025-10-23 08:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (15, 43, 75.00, '2025-10-13 11:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (16, 27, 45.00, '2025-10-04 15:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (17, 7, 30.00, '2025-10-08 07:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (18, 15, 45.00, '2025-10-02 12:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (19, 44, 75.00, '2025-11-01 01:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (20, 3, 120.00, '2025-09-14 02:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (21, 13, 30.00, '2025-09-27 02:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (22, 48, 75.00, '2025-09-19 09:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (23, 47, 75.00, '2025-10-13 06:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (24, 43, 45.00, '2025-10-02 18:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (25, 28, 75.00, '2025-10-14 07:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (26, 11, 75.00, '2025-10-01 16:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (27, 44, 45.00, '2025-10-29 16:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (28, 50, 120.00, '2025-10-09 20:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (29, 26, 45.00, '2025-10-01 12:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (30, 34, 30.00, '2025-11-01 04:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (31, 39, 120.00, '2025-10-07 05:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (32, 48, 120.00, '2025-10-07 03:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (33, 29, 75.00, '2025-09-18 16:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (34, 25, 45.00, '2025-09-21 05:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (35, 27, 30.00, '2025-10-13 03:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (36, 20, 120.00, '2025-09-29 11:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (37, 28, 30.00, '2025-10-30 04:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (38, 35, 120.00, '2025-10-14 03:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (39, 12, 75.00, '2025-09-29 13:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (40, 18, 75.00, '2025-10-03 17:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (41, 15, 30.00, '2025-10-20 23:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (42, 31, 45.00, '2025-10-11 23:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (43, 46, 45.00, '2025-10-21 09:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (44, 26, 30.00, '2025-10-21 21:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (45, 39, 30.00, '2025-10-18 02:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (46, 27, 30.00, '2025-10-31 05:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (47, 42, 120.00, '2025-10-14 13:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (48, 18, 45.00, '2025-10-16 08:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (49, 12, 45.00, '2025-10-22 23:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (50, 36, 45.00, '2025-09-18 06:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (51, 31, 120.00, '2025-10-26 06:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (52, 43, 75.00, '2025-10-18 23:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (53, 45, 75.00, '2025-10-28 08:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (54, 49, 45.00, '2025-09-18 03:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (55, 13, 45.00, '2025-09-27 19:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (56, 36, 45.00, '2025-10-25 23:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (57, 31, 75.00, '2025-10-10 15:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (58, 32, 30.00, '2025-10-17 11:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (59, 39, 45.00, '2025-10-18 13:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (60, 20, 30.00, '2025-11-02 02:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (61, 6, 45.00, '2025-10-25 06:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (62, 31, 30.00, '2025-10-02 21:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (63, 41, 45.00, '2025-11-06 14:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (64, 4, 75.00, '2025-09-27 16:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (65, 45, 75.00, '2025-10-31 23:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (66, 48, 75.00, '2025-09-27 22:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (67, 18, 30.00, '2025-10-13 02:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (68, 12, 120.00, '2025-10-16 11:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (69, 43, 45.00, '2025-10-03 21:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (70, 3, 30.00, '2025-10-15 02:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (71, 43, 120.00, '2025-10-20 00:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (72, 29, 45.00, '2025-09-21 01:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (73, 41, 45.00, '2025-11-15 05:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (74, 8, 30.00, '2025-10-22 02:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (75, 31, 45.00, '2025-10-27 23:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (76, 5, 120.00, '2025-10-31 14:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (77, 38, 45.00, '2025-10-19 01:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (78, 30, 45.00, '2025-10-10 15:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (79, 3, 120.00, '2025-10-25 07:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (80, 33, 75.00, '2025-10-13 08:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (81, 27, 30.00, '2025-09-15 21:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (82, 22, 120.00, '2025-10-09 18:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (83, 41, 45.00, '2025-10-25 09:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (84, 2, 75.00, '2025-09-26 10:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (85, 27, 45.00, '2025-10-22 03:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (86, 38, 45.00, '2025-10-08 22:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (87, 19, 45.00, '2025-10-23 23:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (88, 17, 75.00, '2025-11-03 11:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (89, 37, 75.00, '2025-10-14 23:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (90, 50, 120.00, '2025-09-11 12:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (91, 40, 45.00, '2025-10-12 09:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (92, 47, 30.00, '2025-10-14 13:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (93, 24, 75.00, '2025-10-24 20:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (94, 30, 45.00, '2025-09-17 07:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (95, 1, 30.00, '2025-09-24 11:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (96, 7, 120.00, '2025-09-19 12:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (97, 30, 120.00, '2025-10-12 08:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (98, 35, 120.00, '2025-09-29 01:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (99, 27, 120.00, '2025-09-29 12:00:00', 'paid');
INSERT INTO orders (order_id, client_id, total_amount, created_at, status) VALUES (100, 24, 75.00, '2025-10-19 06:00:00', 'paid');

-- PAYMENTS
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (1, 1, 45.00, 'card', '2025-10-03 18:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (2, 2, 120.00, 'card', '2025-09-30 19:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (3, 3, 30.00, 'apple_pay', '2025-10-09 07:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (4, 4, 30.00, 'paypal', '2025-10-15 02:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (5, 5, 45.00, 'apple_pay', '2025-11-10 09:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (6, 6, 75.00, 'apple_pay', '2025-10-19 14:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (7, 7, 120.00, 'apple_pay', '2025-10-31 09:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (8, 8, 45.00, 'card', '2025-10-18 11:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (9, 9, 75.00, 'paypal', '2025-11-11 22:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (10, 10, 45.00, 'card', '2025-10-13 10:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (11, 11, 45.00, 'card', '2025-10-03 14:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (12, 12, 75.00, 'apple_pay', '2025-10-21 13:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (13, 13, 30.00, 'apple_pay', '2025-10-03 17:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (14, 14, 120.00, 'card', '2025-10-23 08:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (15, 15, 75.00, 'card', '2025-10-13 11:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (16, 16, 45.00, 'apple_pay', '2025-10-04 15:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (17, 17, 30.00, 'card', '2025-10-08 07:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (18, 18, 45.00, 'paypal', '2025-10-02 12:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (19, 19, 75.00, 'paypal', '2025-11-01 01:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (20, 20, 120.00, 'apple_pay', '2025-09-14 02:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (21, 21, 30.00, 'apple_pay', '2025-09-27 02:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (22, 22, 75.00, 'card', '2025-09-19 09:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (23, 23, 75.00, 'paypal', '2025-10-13 06:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (24, 24, 45.00, 'card', '2025-10-02 18:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (25, 25, 75.00, 'apple_pay', '2025-10-14 07:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (26, 26, 75.00, 'card', '2025-10-01 16:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (27, 27, 45.00, 'apple_pay', '2025-10-29 16:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (28, 28, 120.00, 'paypal', '2025-10-09 20:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (29, 29, 45.00, 'apple_pay', '2025-10-01 12:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (30, 30, 30.00, 'apple_pay', '2025-11-01 04:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (31, 31, 120.00, 'card', '2025-10-07 05:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (32, 32, 120.00, 'paypal', '2025-10-07 03:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (33, 33, 75.00, 'card', '2025-09-18 16:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (34, 34, 45.00, 'card', '2025-09-21 05:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (35, 35, 30.00, 'paypal', '2025-10-13 03:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (36, 36, 120.00, 'paypal', '2025-09-29 11:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (37, 37, 30.00, 'apple_pay', '2025-10-30 04:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (38, 38, 120.00, 'paypal', '2025-10-14 03:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (39, 39, 75.00, 'paypal', '2025-09-29 13:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (40, 40, 75.00, 'paypal', '2025-10-03 17:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (41, 41, 30.00, 'card', '2025-10-20 23:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (42, 42, 45.00, 'apple_pay', '2025-10-11 23:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (43, 43, 45.00, 'paypal', '2025-10-21 09:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (44, 44, 30.00, 'apple_pay', '2025-10-21 21:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (45, 45, 30.00, 'card', '2025-10-18 02:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (46, 46, 30.00, 'apple_pay', '2025-10-31 05:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (47, 47, 120.00, 'card', '2025-10-14 13:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (48, 48, 45.00, 'paypal', '2025-10-16 08:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (49, 49, 45.00, 'paypal', '2025-10-22 23:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (50, 50, 45.00, 'apple_pay', '2025-09-18 06:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (51, 51, 120.00, 'paypal', '2025-10-26 06:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (52, 52, 75.00, 'paypal', '2025-10-18 23:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (53, 53, 75.00, 'apple_pay', '2025-10-28 08:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (54, 54, 45.00, 'card', '2025-09-18 03:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (55, 55, 45.00, 'card', '2025-09-27 19:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (56, 56, 45.00, 'paypal', '2025-10-25 23:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (57, 57, 75.00, 'paypal', '2025-10-10 15:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (58, 58, 30.00, 'paypal', '2025-10-17 11:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (59, 59, 45.00, 'paypal', '2025-10-18 13:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (60, 60, 30.00, 'apple_pay', '2025-11-02 02:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (61, 61, 45.00, 'apple_pay', '2025-10-25 06:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (62, 62, 30.00, 'paypal', '2025-10-02 21:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (63, 63, 45.00, 'card', '2025-11-06 14:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (64, 64, 75.00, 'paypal', '2025-09-27 16:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (65, 65, 75.00, 'paypal', '2025-10-31 23:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (66, 66, 75.00, 'apple_pay', '2025-09-27 22:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (67, 67, 30.00, 'paypal', '2025-10-13 02:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (68, 68, 120.00, 'paypal', '2025-10-16 11:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (69, 69, 45.00, 'apple_pay', '2025-10-03 21:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (70, 70, 30.00, 'card', '2025-10-15 02:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (71, 71, 120.00, 'apple_pay', '2025-10-20 00:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (72, 72, 45.00, 'card', '2025-09-21 01:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (73, 73, 45.00, 'card', '2025-11-15 05:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (74, 74, 30.00, 'paypal', '2025-10-22 02:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (75, 75, 45.00, 'card', '2025-10-27 23:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (76, 76, 120.00, 'apple_pay', '2025-10-31 14:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (77, 77, 45.00, 'paypal', '2025-10-19 01:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (78, 78, 45.00, 'paypal', '2025-10-10 15:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (79, 79, 120.00, 'card', '2025-10-25 07:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (80, 80, 75.00, 'card', '2025-10-13 08:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (81, 81, 30.00, 'card', '2025-09-15 21:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (82, 82, 120.00, 'card', '2025-10-09 18:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (83, 83, 45.00, 'paypal', '2025-10-25 09:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (84, 84, 75.00, 'apple_pay', '2025-09-26 10:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (85, 85, 45.00, 'paypal', '2025-10-22 03:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (86, 86, 45.00, 'paypal', '2025-10-08 22:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (87, 87, 45.00, 'apple_pay', '2025-10-23 23:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (88, 88, 75.00, 'paypal', '2025-11-03 11:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (89, 89, 75.00, 'apple_pay', '2025-10-14 23:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (90, 90, 120.00, 'card', '2025-09-11 12:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (91, 91, 45.00, 'paypal', '2025-10-12 09:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (92, 92, 30.00, 'apple_pay', '2025-10-14 13:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (93, 93, 75.00, 'card', '2025-10-24 20:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (94, 94, 45.00, 'paypal', '2025-09-17 07:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (95, 95, 30.00, 'paypal', '2025-09-24 11:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (96, 96, 120.00, 'apple_pay', '2025-09-19 12:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (97, 97, 120.00, 'card', '2025-10-12 08:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (98, 98, 120.00, 'card', '2025-09-29 01:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (99, 99, 120.00, 'card', '2025-09-29 12:10:00', 'completed');
INSERT INTO payments (payment_id, order_id, amount, method, paid_at, status) VALUES (100, 100, 75.00, 'card', '2025-10-19 06:10:00', 'completed');

-- TICKETS
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (1, 4, 6, 1, 'Standard', 45.00, 'R31-S14', '2025-10-03 18:00:00', 'valid', 'QR000001');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (2, 5, 25, 2, 'Standard', 120.00, 'R45-S36', '2025-09-30 19:00:00', 'valid', 'QR000002');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (3, 10, 4, 3, 'Premium', 30.00, 'R4-S4', '2025-10-09 07:00:00', 'valid', 'QR000003');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (4, 1, 11, 4, 'VIP', 30.00, 'R5-S39', '2025-10-15 02:00:00', 'used', 'QR000004');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (5, 10, 8, 5, 'Standard', 45.00, 'R3-S40', '2025-11-10 09:00:00', 'valid', 'QR000005');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (6, 6, 34, 6, 'Standard', 75.00, 'R46-S21', '2025-10-19 14:00:00', 'valid', 'QR000006');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (7, 5, 42, 7, 'Standard', 120.00, 'R49-S5', '2025-10-31 09:00:00', 'valid', 'QR000007');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (8, 2, 7, 8, 'Standard', 45.00, 'R9-S23', '2025-10-18 11:00:00', 'valid', 'QR000008');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (9, 9, 29, 9, 'Premium', 75.00, 'R42-S34', '2025-11-11 22:00:00', 'valid', 'QR000009');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (10, 2, 43, 10, 'Standard', 45.00, 'R7-S36', '2025-10-13 10:00:00', 'valid', 'QR000010');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (11, 6, 46, 11, 'Premium', 45.00, 'R17-S33', '2025-10-03 14:00:00', 'used', 'QR000011');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (12, 7, 6, 12, 'Standard', 75.00, 'R22-S9', '2025-10-21 13:00:00', 'valid', 'QR000012');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (13, 7, 46, 13, 'Standard', 30.00, 'R45-S10', '2025-10-03 17:00:00', 'valid', 'QR000013');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (14, 3, 36, 14, 'Standard', 120.00, 'R20-S24', '2025-10-23 08:00:00', 'valid', 'QR000014');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (15, 2, 43, 15, 'Premium', 75.00, 'R27-S40', '2025-10-13 11:00:00', 'used', 'QR000015');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (16, 1, 27, 16, 'Premium', 45.00, 'R22-S27', '2025-10-04 15:00:00', 'valid', 'QR000016');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (17, 7, 7, 17, 'VIP', 30.00, 'R15-S13', '2025-10-08 07:00:00', 'valid', 'QR000017');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (18, 1, 15, 18, 'Standard', 45.00, 'R18-S5', '2025-10-02 12:00:00', 'valid', 'QR000018');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (19, 9, 44, 19, 'VIP', 75.00, 'R8-S17', '2025-11-01 01:00:00', 'cancelled', 'QR000019');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (20, 2, 3, 20, 'Standard', 120.00, 'R21-S28', '2025-09-14 02:00:00', 'valid', 'QR000020');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (21, 5, 13, 21, 'Premium', 30.00, 'R1-S34', '2025-09-27 02:00:00', 'valid', 'QR000021');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (22, 4, 48, 22, 'Standard', 75.00, 'R43-S22', '2025-09-19 09:00:00', 'valid', 'QR000022');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (23, 5, 47, 23, 'Premium', 75.00, 'R21-S26', '2025-10-13 06:00:00', 'valid', 'QR000023');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (24, 7, 43, 24, 'Premium', 45.00, 'R20-S26', '2025-10-02 18:00:00', 'valid', 'QR000024');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (25, 10, 28, 25, 'Standard', 75.00, 'R29-S14', '2025-10-14 07:00:00', 'valid', 'QR000025');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (26, 2, 11, 26, 'Standard', 75.00, 'R41-S40', '2025-10-01 16:00:00', 'valid', 'QR000026');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (27, 5, 44, 27, 'Premium', 45.00, 'R10-S2', '2025-10-29 16:00:00', 'cancelled', 'QR000027');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (28, 2, 50, 28, 'Standard', 120.00, 'R41-S37', '2025-10-09 20:00:00', 'valid', 'QR000028');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (29, 4, 26, 29, 'Premium', 45.00, 'R1-S7', '2025-10-01 12:00:00', 'valid', 'QR000029');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (30, 8, 34, 30, 'Standard', 30.00, 'R8-S30', '2025-11-01 04:00:00', 'valid', 'QR000030');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (31, 6, 39, 31, 'Premium', 120.00, 'R47-S33', '2025-10-07 05:00:00', 'valid', 'QR000031');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (32, 8, 48, 32, 'Standard', 120.00, 'R16-S18', '2025-10-07 03:00:00', 'valid', 'QR000032');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (33, 2, 29, 33, 'Standard', 75.00, 'R22-S21', '2025-09-18 16:00:00', 'valid', 'QR000033');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (34, 3, 25, 34, 'Standard', 45.00, 'R27-S22', '2025-09-21 05:00:00', 'valid', 'QR000034');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (35, 7, 27, 35, 'VIP', 30.00, 'R49-S37', '2025-10-13 03:00:00', 'valid', 'QR000035');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (36, 7, 20, 36, 'Standard', 120.00, 'R48-S35', '2025-09-29 11:00:00', 'valid', 'QR000036');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (37, 8, 28, 37, 'Standard', 30.00, 'R43-S26', '2025-10-30 04:00:00', 'used', 'QR000037');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (38, 1, 35, 38, 'Standard', 120.00, 'R43-S2', '2025-10-14 03:00:00', 'valid', 'QR000038');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (39, 1, 12, 39, 'Standard', 75.00, 'R14-S30', '2025-09-29 13:00:00', 'valid', 'QR000039');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (40, 7, 18, 40, 'Premium', 75.00, 'R31-S2', '2025-10-03 17:00:00', 'cancelled', 'QR000040');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (41, 2, 15, 41, 'Premium', 30.00, 'R16-S13', '2025-10-20 23:00:00', 'valid', 'QR000041');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (42, 2, 31, 42, 'Standard', 45.00, 'R17-S24', '2025-10-11 23:00:00', 'valid', 'QR000042');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (43, 2, 46, 43, 'Floor', 45.00, 'R7-S38', '2025-10-21 09:00:00', 'valid', 'QR000043');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (44, 4, 26, 44, 'Standard', 30.00, 'R41-S16', '2025-10-21 21:00:00', 'valid', 'QR000044');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (45, 2, 39, 45, 'Standard', 30.00, 'R28-S24', '2025-10-18 02:00:00', 'valid', 'QR000045');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (46, 8, 27, 46, 'Standard', 30.00, 'R24-S30', '2025-10-31 05:00:00', 'valid', 'QR000046');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (47, 5, 42, 47, 'Standard', 120.00, 'R47-S38', '2025-10-14 13:00:00', 'used', 'QR000047');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (48, 8, 18, 48, 'Premium', 45.00, 'R37-S40', '2025-10-16 08:00:00', 'valid', 'QR000048');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (49, 8, 12, 49, 'Standard', 45.00, 'R17-S22', '2025-10-22 23:00:00', 'valid', 'QR000049');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (50, 1, 36, 50, 'Standard', 45.00, 'R47-S27', '2025-09-18 06:00:00', 'valid', 'QR000050');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (51, 8, 31, 51, 'Premium', 120.00, 'R6-S19', '2025-10-26 06:00:00', 'valid', 'QR000051');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (52, 10, 43, 52, 'Standard', 75.00, 'R34-S23', '2025-10-18 23:00:00', 'valid', 'QR000052');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (53, 8, 45, 53, 'Standard', 75.00, 'R15-S8', '2025-10-28 08:00:00', 'valid', 'QR000053');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (54, 3, 49, 54, 'Standard', 45.00, 'R31-S18', '2025-09-18 03:00:00', 'valid', 'QR000054');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (55, 5, 13, 55, 'Standard', 45.00, 'R20-S1', '2025-09-27 19:00:00', 'valid', 'QR000055');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (56, 5, 36, 56, 'Premium', 45.00, 'R49-S32', '2025-10-25 23:00:00', 'valid', 'QR000056');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (57, 8, 31, 57, 'Standard', 75.00, 'R4-S17', '2025-10-10 15:00:00', 'valid', 'QR000057');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (58, 2, 32, 58, 'Standard', 30.00, 'R37-S20', '2025-10-17 11:00:00', 'valid', 'QR000058');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (59, 10, 39, 59, 'Premium', 45.00, 'R25-S29', '2025-10-18 13:00:00', 'used', 'QR000059');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (60, 10, 20, 60, 'Premium', 30.00, 'R48-S7', '2025-11-02 02:00:00', 'valid', 'QR000060');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (61, 3, 6, 61, 'Standard', 45.00, 'R5-S11', '2025-10-25 06:00:00', 'valid', 'QR000061');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (62, 5, 31, 62, 'Standard', 30.00, 'R46-S19', '2025-10-02 21:00:00', 'valid', 'QR000062');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (63, 10, 41, 63, 'Standard', 45.00, 'R35-S15', '2025-11-06 14:00:00', 'valid', 'QR000063');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (64, 3, 4, 64, 'Standard', 75.00, 'R37-S19', '2025-09-27 16:00:00', 'valid', 'QR000064');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (65, 7, 45, 65, 'Standard', 75.00, 'R32-S29', '2025-10-31 23:00:00', 'valid', 'QR000065');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (66, 6, 48, 66, 'Standard', 75.00, 'R15-S37', '2025-09-27 22:00:00', 'cancelled', 'QR000066');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (67, 10, 18, 67, 'Premium', 30.00, 'R12-S31', '2025-10-13 02:00:00', 'valid', 'QR000067');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (68, 10, 12, 68, 'Premium', 120.00, 'R32-S6', '2025-10-16 11:00:00', 'valid', 'QR000068');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (69, 2, 43, 69, 'Standard', 45.00, 'R45-S32', '2025-10-03 21:00:00', 'used', 'QR000069');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (70, 8, 3, 70, 'Standard', 30.00, 'R21-S8', '2025-10-15 02:00:00', 'valid', 'QR000070');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (71, 9, 43, 71, 'Standard', 120.00, 'R13-S34', '2025-10-20 00:00:00', 'valid', 'QR000071');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (72, 1, 29, 72, 'Standard', 45.00, 'R9-S19', '2025-09-21 01:00:00', 'valid', 'QR000072');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (73, 10, 41, 73, 'Premium', 45.00, 'R20-S36', '2025-11-15 05:00:00', 'valid', 'QR000073');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (74, 8, 8, 74, 'Premium', 30.00, 'R10-S32', '2025-10-22 02:00:00', 'valid', 'QR000074');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (75, 8, 31, 75, 'Standard', 45.00, 'R10-S25', '2025-10-27 23:00:00', 'valid', 'QR000075');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (76, 5, 5, 76, 'Standard', 120.00, 'R33-S18', '2025-10-31 14:00:00', 'valid', 'QR000076');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (77, 8, 38, 77, 'Standard', 45.00, 'R31-S23', '2025-10-19 01:00:00', 'valid', 'QR000077');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (78, 6, 30, 78, 'Floor', 45.00, 'R16-S37', '2025-10-10 15:00:00', 'used', 'QR000078');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (79, 6, 3, 79, 'Premium', 120.00, 'R25-S25', '2025-10-25 07:00:00', 'cancelled', 'QR000079');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (80, 10, 33, 80, 'VIP', 75.00, 'R29-S7', '2025-10-13 08:00:00', 'valid', 'QR000080');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (81, 3, 27, 81, 'Standard', 30.00, 'R17-S22', '2025-09-15 21:00:00', 'valid', 'QR000081');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (82, 9, 22, 82, 'Floor', 120.00, 'R41-S32', '2025-10-09 18:00:00', 'valid', 'QR000082');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (83, 5, 41, 83, 'Premium', 45.00, 'R28-S7', '2025-10-25 09:00:00', 'valid', 'QR000083');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (84, 1, 2, 84, 'Premium', 75.00, 'R19-S23', '2025-09-26 10:00:00', 'valid', 'QR000084');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (85, 10, 27, 85, 'Standard', 45.00, 'R6-S40', '2025-10-22 03:00:00', 'valid', 'QR000085');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (86, 3, 38, 86, 'Standard', 45.00, 'R17-S30', '2025-10-08 22:00:00', 'valid', 'QR000086');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (87, 9, 19, 87, 'Standard', 45.00, 'R23-S38', '2025-10-23 23:00:00', 'cancelled', 'QR000087');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (88, 8, 17, 88, 'Standard', 75.00, 'R25-S31', '2025-11-03 11:00:00', 'valid', 'QR000088');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (89, 5, 37, 89, 'Standard', 75.00, 'R43-S26', '2025-10-14 23:00:00', 'valid', 'QR000089');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (90, 1, 50, 90, 'Premium', 120.00, 'R19-S15', '2025-09-11 12:00:00', 'valid', 'QR000090');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (91, 5, 40, 91, 'Premium', 45.00, 'R41-S3', '2025-10-12 09:00:00', 'valid', 'QR000091');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (92, 3, 47, 92, 'VIP', 30.00, 'R21-S27', '2025-10-14 13:00:00', 'valid', 'QR000092');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (93, 9, 24, 93, 'Premium', 75.00, 'R17-S31', '2025-10-24 20:00:00', 'used', 'QR000093');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (94, 2, 30, 94, 'Premium', 45.00, 'R15-S26', '2025-09-17 07:00:00', 'valid', 'QR000094');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (95, 5, 1, 95, 'Standard', 30.00, 'R44-S17', '2025-09-24 11:00:00', 'valid', 'QR000095');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (96, 4, 7, 96, 'Standard', 120.00, 'R36-S21', '2025-09-19 12:00:00', 'valid', 'QR000096');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (97, 5, 30, 97, 'Standard', 120.00, 'R3-S3', '2025-10-12 08:00:00', 'valid', 'QR000097');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (98, 3, 35, 98, 'Standard', 120.00, 'R43-S35', '2025-09-29 01:00:00', 'valid', 'QR000098');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (99, 2, 27, 99, 'Premium', 120.00, 'R18-S3', '2025-09-29 12:00:00', 'valid', 'QR000099');
INSERT INTO tickets (ticket_id, event_id, client_id, order_id, category, price, seat, purchase_date, status, qr_code) VALUES (100, 2, 24, 100, 'Standard', 75.00, 'R42-S23', '2025-10-19 06:00:00', 'valid', 'QR000100');
