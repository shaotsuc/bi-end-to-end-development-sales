CREATE SCHEMA IF NOT EXISTS dwh;

CREATE TABLE IF NOT EXISTS dwh.people (
  name TEXT,
  region_name TEXT
);

CREATE TABLE IF NOT EXISTS dwh.returns (
    order_id UUID,
    returned BOOLEAN,
    PRIMARY KEY(order_id)
);


CREATE TABLE IF NOT EXISTS dwh.orders (
    category TEXT,
    city_name TEXT,
    country_name TEXT,
    customer_id UUID,
    customer_name TEXT,
    discount NUMERIC,
    order_date DATE,
    order_id UUID REFERENCES dwh.returns(order_id),
    postal_code TEXT,
    product_id TEXT,
    profit NUMERIC,
    quantity INTEGER,
    region_name TEXT,
    sales NUMERIC,
    segment TEXT,
    ship_date DATE,
    ship_mode TEXT,
    state_name TEXT,
    sub_category TEXT
    PRIMARY KEY(order_id)
);
