-- =========================================================
-- Schema MySQL - Base "evenement" (BTS SIO SLAM)
-- Objectif : Auth (email unique + password_hash), Events, Inscriptions, Payments
-- =========================================================

DROP DATABASE IF EXISTS evenement;
CREATE DATABASE evenement
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE evenement;

-- =========================
-- Table: users
-- =========================
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  role VARCHAR(50) NOT NULL DEFAULT 'participant',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =========================
-- Table: events
-- =========================
CREATE TABLE events (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT NULL,
  location VARCHAR(255) NULL,
  date DATETIME NULL,
  price DECIMAL(10,2) NOT NULL DEFAULT 0,
  capacity INT NULL,
  organizer_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  photos TEXT NULL,

  INDEX idx_events_date (date),
  INDEX idx_events_org (organizer_id),

  CONSTRAINT fk_events_organizer
    FOREIGN KEY (organizer_id) REFERENCES users(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- =========================
-- Table: inscriptions (inscriptions / participations)
-- =========================
CREATE TABLE inscriptions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  event_id INT NOT NULL,
  date_registered TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(20) NOT NULL DEFAULT 'pending',

  UNIQUE KEY uq_inscription (user_id, event_id),
  INDEX idx_ins_user (user_id),
  INDEX idx_ins_event (event_id),

  CONSTRAINT fk_ins_user
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  CONSTRAINT fk_ins_event
    FOREIGN KEY (event_id) REFERENCES events(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- =========================
-- Table: payments
-- =========================
CREATE TABLE payments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  event_id INT NOT NULL,
  amount DECIMAL(10,2) NOT NULL DEFAULT 0,
  status VARCHAR(20) NOT NULL DEFAULT 'pending',
  payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

  INDEX idx_pay_user (user_id),
  INDEX idx_pay_event (event_id),

  CONSTRAINT fk_pay_user
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  CONSTRAINT fk_pay_event
    FOREIGN KEY (event_id) REFERENCES events(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- =========================
-- Seed minimal (optionnel)
-- =========================
-- Remplace le hash par un vrai hash bcrypt si tu veux un admin direct.
INSERT INTO users (name, email, password_hash, role)
VALUES ('Admin', 'admin@event.local', '$2b$10$CHANGE_ME_HASH', 'admin');
