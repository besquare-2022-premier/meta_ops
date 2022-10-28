-- CREATE DATABASE
CREATE DATABASE "premier-project"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

-- CREATE SCHEMA
CREATE SCHEMA IF NOT EXISTS premier
    AUTHORIZATION postgres;

-- CREATE TABLE premier.user_details
CREATE TABLE IF NOT EXISTS premier.user_details
(
    loginid bigint NOT NULL,
    fname text COLLATE pg_catalog."default",
    lname text COLLATE pg_catalog."default",
    username text COLLATE pg_catalog."default",
    email text COLLATE pg_catalog."default",
    pwd text COLLATE pg_catalog."default",
    tel_no bigint,
    address text COLLATE pg_catalog."default",
    first_join timestamp without time zone,
    access_field text COLLATE pg_catalog."default",
    residence text COLLATE pg_catalog."default",
    CONSTRAINT user_details_pkey PRIMARY KEY (loginid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS premier.user_details
    OWNER to postgres;

CREATE UNIQUE INDEX IF NOT EXISTS user_details_index
    ON premier.user_details USING btree
    (loginid ASC NULLS LAST, username COLLATE pg_catalog."default" ASC NULLS LAST, email COLLATE pg_catalog."default" ASC NULLS LAST, tel_no ASC NULLS LAST)
    TABLESPACE pg_default;

-- CREATE TABLE premier.category
CREATE TABLE IF NOT EXISTS premier.category
(
    categoryid bigint NOT NULL,
    category_name text COLLATE pg_catalog."default",
    CONSTRAINT category_pkey PRIMARY KEY (categoryid)
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS premier.category
    OWNER to postgres;

-- CREATE TABLE premier.product
CREATE TABLE IF NOT EXISTS premier.product
(
    productid bigint NOT NULL,
    product_name text COLLATE pg_catalog."default",
    description text COLLATE pg_catalog."default",
    stock integer,
    price numeric,
    categoryid bigint,
    CONSTRAINT product_pkey PRIMARY KEY (productid),
    CONSTRAINT fk_product FOREIGN KEY (categoryid)
        REFERENCES premier.category (categoryid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS premier.product
    OWNER to postgres;

CREATE INDEX IF NOT EXISTS product_index
    ON premier.product USING btree
    (product_name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- CREATE TABLE premier.orders
CREATE TABLE IF NOT EXISTS premier.orders
(
    orderid bigint NOT NULL,
    loginid bigint NOT NULL,
    ship_address text COLLATE pg_catalog."default",
    CONSTRAINT orders_pkey PRIMARY KEY (orderid),
    CONSTRAINT fk_orders FOREIGN KEY (loginid)
        REFERENCES premier.user_details (loginid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS premier.orders
    OWNER to postgres;

-- CREATE TABLE premier.order_details
CREATE TABLE IF NOT EXISTS premier.order_details
(
    orderid bigint NOT NULL,
    productid bigint NOT NULL,
    quantity integer,
    price numeric,
    CONSTRAINT order_details_pkey PRIMARY KEY (orderid, productid),
    CONSTRAINT order_details_orderid_fkey FOREIGN KEY (orderid)
        REFERENCES premier.orders (orderid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT order_details_productid_fkey FOREIGN KEY (productid)
        REFERENCES premier.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS premier.order_details
    OWNER to postgres;

-- CREATE TABLE premier.transaction
CREATE TABLE IF NOT EXISTS premier.transaction
(
    transactionid bigint NOT NULL,
    orderid bigint NOT NULL,
    loginid bigint NOT NULL,
    amount numeric,
    payment_method text COLLATE pg_catalog."default",
    tx_status text COLLATE pg_catalog."default",
    CONSTRAINT transaction_pkey PRIMARY KEY (transactionid),
    CONSTRAINT transaction_loginid_fkey FOREIGN KEY (loginid)
        REFERENCES premier.user_details (loginid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT transaction_orderid_fkey FOREIGN KEY (orderid)
        REFERENCES premier.orders (orderid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS premier.transaction
    OWNER to postgres;