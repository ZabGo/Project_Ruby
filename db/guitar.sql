DROP TABLE IF EXISTS guitars;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS types;
DROP TABLE IF EXISTS manufacturers;

CREATE TABLE manufacturers(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  address VARCHAR(255),
  phone VARCHAR(255),
  email VARCHAR(255)
);

CREATE TABLE types(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
);


CREATE TABLE products(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  type INT8 REFERENCES types(id) ON DELETE CASCADE,
  description TEXT,
  quantity INT4,
  buying_cost INT4,
  selling_price INT4,
  manufacturer_id INT8 REFERENCES manufacturers(id) ON DELETE CASCADE
);


CREATE TABLE guitars(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  pickup_id INT8 REFERENCES products(id) ON DELETE CASCADE,
  bridge_id INT8 REFERENCES products(id) ON DELETE CASCADE,
  string_id INT8 REFERENCES products(id) ON DELETE CASCADE
);
