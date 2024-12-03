CREATE SCHEMA IF NOT EXISTS dwh;

CREATE TABLE IF NOT EXISTS dwh.people (
  name TEXT,
  region_name TEXT
);

CREATE TABLE IF NOT EXISTS dwh.returns (
    order_id TEXT,
    returned BOOLEAN
);

CREATE TABLE IF NOT EXISTS dwh.orders (
    category TEXT,
    city_name TEXT,
    country_name TEXT,
    customer_id TEXT,
    customer_name TEXT,
    discount FLOAT,
    order_date TEXT,
    order_id TEXT,
    postal_code TEXT,
    product_id TEXT,
    product_name TEXT,
    profit FLOAT,
    quantity INTEGER,
    region_name TEXT,
    sales FLOAT,
    segment TEXT,
    ship_date TEXT,
    ship_mode TEXT,
    state_name TEXT,
    sub_category TEXT
);
