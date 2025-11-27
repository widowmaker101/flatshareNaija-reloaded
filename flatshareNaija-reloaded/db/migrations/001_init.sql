CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT, email TEXT, phone TEXT, city TEXT
);
CREATE TABLE IF NOT EXISTS preferences (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user TEXT, budget TEXT, city TEXT, area TEXT, lifestyle TEXT
);
CREATE TABLE IF NOT EXISTS listings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT, description TEXT, city TEXT, area TEXT,
  rent INTEGER, service_charge INTEGER,
  generator INTEGER, inverter INTEGER,
  water TEXT, security INTEGER, terms TEXT, phone TEXT
);
