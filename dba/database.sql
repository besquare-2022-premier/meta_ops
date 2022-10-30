-- CREATE DATABASE
CREATE DATABASE "premier_project"
    WITH 
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

-- CREATE SCHEMA
CREATE SCHEMA IF NOT EXISTS premier;

CREATE TYPE premier.access_level AS ENUM ('normal','admin');
CREATE TYPE premier.tx_status AS ENUM ('created','succeeded','failed','cancelled');
CREATE DOMAIN premier.currency AS numeric not null check(value>0);

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
    gender text COLLATE pg_catalog."default",
    birthday date,
    CONSTRAINT user_details_pkey PRIMARY KEY (loginid)
)

TABLESPACE pg_default;

CREATE UNIQUE INDEX IF NOT EXISTS user_details_index_username ON premier.user_details USING btree (
    username COLLATE pg_catalog."default" ASC
) TABLESPACE pg_default;
CREATE UNIQUE INDEX IF NOT EXISTS user_details_index_email ON premier.user_details USING btree (
    email COLLATE pg_catalog."default" ASC
) TABLESPACE pg_default;

-- CREATE TABLE premier.category
CREATE TABLE IF NOT EXISTS premier.category
(
    categoryid bigint NOT NULL,
    category_name text COLLATE pg_catalog."default",
    CONSTRAINT category_pkey PRIMARY KEY (categoryid)
)
TABLESPACE pg_default;

CREATE UNIQUE INDEX IF NOT EXISTS category_name_index ON premier.category USING btree(
    category_name COLLATE pg_catalog."default"
) TABLESPACE pg_default;

-- CREATE TABLE premier.product
CREATE TABLE IF NOT EXISTS premier.product
(
    productid bigint NOT NULL,
    product_name text COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    stock integer default(-1) check(stock>-1),
    price premier.currency,
    categoryid bigint,
    image text COLLATE pg_catalog."default" NOT NULL DEFAULT(''),
    CONSTRAINT product_pkey PRIMARY KEY (productid),
    CONSTRAINT fk_product FOREIGN KEY (categoryid)
        REFERENCES premier.category (categoryid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS product_index
    ON premier.product USING btree
    (product_name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- CREATE TABLE premier.orders
CREATE TABLE IF NOT EXISTS premier.orders
(
    orderid bigint NOT NULL,
    loginid bigint NOT NULL,
    ship_address text COLLATE pg_catalog."default" NOT NULL,
    country text COLLATE pg_catalog."default" NOT NULL,
    
    CONSTRAINT orders_pkey PRIMARY KEY (orderid),
    CONSTRAINT fk_orders FOREIGN KEY (loginid)
        REFERENCES premier.user_details (loginid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;

-- CREATE TABLE premier.order_details
CREATE TABLE IF NOT EXISTS premier.order_details
(
    orderid bigint NOT NULL,
    productid bigint NOT NULL,
    quantity integer NOT NULL,
    price premier.currency,
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

-- CREATE TABLE premier.transaction
CREATE TABLE IF NOT EXISTS premier.transaction
(
    transactionid bigint NOT NULL,
    orderid bigint NOT NULL,
    loginid bigint NOT NULL,
    amount premier.currency,
    payment_method text COLLATE pg_catalog."default",
    tx_status premier.tx_status not null default ('created'),
    tx_time timestamp without time zone not null default now(),
    tx_settle_time timestamp without time zone,
    CONSTRAINT transaction_pkey PRIMARY KEY (transactionid,orderid,loginid),
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

-- CREATE TABLE premier.user_data
CREATE TABLE IF NOT EXISTS premier.user_data
(
    loginid bigint NOT NULL,
    items_bought integer,
    money_spent_myr numeric,
    CONSTRAINT user_data_loginid_fkey FOREIGN KEY (loginid)
        REFERENCES premier.user_details (loginid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS premier.user_data
    OWNER to postgres;
