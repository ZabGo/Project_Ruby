DROP TABLE IF EXISTS manufacturers;
DROP TABLE IF EXISTS guitars;
DROP TABLE IF EXISTS bridges;
DROP TABLE IF EXISTS pickups;
DROP TABLE IF EXISTS strings;
DROP TABLE IF EXISTS tunning_keys;
DROP TABLE IF EXISTS woods;

CREATE TABLE bridges(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(255),
  strings_spacing INT,
  mounting_type VARCHAR(255),
  quantity INT,
  buying_cost INT,
  selling_price INT

);
CREATE TABLE pickups(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(255),
  ouput VARCHAR(255),
  strings_number INT,
  quantity INT,
  buying_cost INT,
  selling_price INT

);
CREATE TABLE tunning_keys(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(255),
  number_of_key INT,
  quantity INT,
  buying_cost INT,
  selling_price INT

);

CREATE TABLE strings(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  strength_string VARCHAR(255),
  material VARCHAR(255),
  scale VARCHAR(255),
  quantity INT,
  buying_cost INT,
  selling_price INT

);

CREATE TABLE woods(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  piece VARCHAR(255),
  type VARCHAR(255),
  dimmension VARCHAR(255),
  quantity INT,
  buying_cost INT,
  selling_price INT

);
CREATE TABLE guitars(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  bridges_id INT8 REFERENCES bridges(id) ON DELETE CASCADE,
  pickups_id INT8 REFERENCES pickups(id) ON DELETE CASCADE,
  tunning_keys_id INT8 REFERENCES tunning_keys(id) ON DELETE CASCADE,
  woods_id INT8 REFERENCES woods(id) ON DELETE CASCADE

);

CREATE TABLE manufacturers(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  address VARCHAR(255),
  phone VARCHAR(255),
  email VARCHAR(255)

)
