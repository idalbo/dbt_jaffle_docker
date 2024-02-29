CREATE SCHEMA if not exists jaffle_shop;

CREATE table if not exists jaffle_shop.raw_customers (
    id int,
    first_name varchar,
    last_name varchar
);


CREATE table if not exists jaffle_shop.raw_orders (
    id int,
    user_id int,
    order_date timestamp without time zone,
    status varchar
);

CREATE table if not exists jaffle_shop.raw_payments (
    id int,
    order_id int,
    payment_method varchar,
    amount float
);

CREATE SCHEMA if not exists prod;

CREATE table if not exists prod.raw_customers (
    id int,
    first_name varchar,
    last_name varchar
);


CREATE table if not exists prod.raw_orders (
    id int,
    user_id int,
    order_date timestamp without time zone,
    status varchar
);

CREATE table if not exists prod.raw_payments (
    id int,
    order_id int,
    payment_method varchar,
    amount float
);