PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  email TEXT NOT NULL,
  phone TEXT NOT NULL,
  city TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS preferences (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  budget INTEGER NOT NULL,
  city TEXT NOT NULL,
  area TEXT NOT NULL,
  lifestyle TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS listings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  city TEXT NOT NULL,
  area TEXT NOT NULL,
  rent INTEGER NOT NULL,
  has_generator INTEGER NOT NULL DEFAULT 0,
  has_inverter  INTEGER NOT NULL DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Dedup key: same title + city + area
CREATE UNIQUE INDEX IF NOT EXISTS uniq_listings_title_city_area
ON listings(title, city, area);

CREATE INDEX IF NOT EXISTS idx_listings_city_area ON listings(city, area);
CREATE INDEX IF NOT EXISTS idx_listings_rent ON listings(rent);

-- Audit table
CREATE TABLE IF NOT EXISTS audit_log (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  action TEXT NOT NULL,
  entity TEXT NOT NULL,
  entity_id INTEGER,
  detail TEXT,
  at DATETIME DEFAULT CURRENT_TIMESTAMP
);
