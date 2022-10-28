# Step 1: Create Database
## Database: premier-project
### DROP DATABASE IF EXISTS "premier-project";

```
CREATE DATABASE "premier-project"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
```

# Step 2: Create Schema
## SCHEMA: premier
### DROP SCHEMA IF EXISTS premier ;

```
CREATE SCHEMA IF NOT EXISTS premier
    AUTHORIZATION postgres;
```

# Step 3: Create Tables
## Table: premier.user_details
### DROP TABLE IF EXISTS premier.user_details;

```
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
    CONSTRAINT user_details_pkey PRIMARY KEY (loginid)
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS premier.user_details
    OWNER to postgres;
```

## Table: premier.category
### DROP TABLE IF EXISTS premier.category;

```
CREATE TABLE IF NOT EXISTS premier.category
(
    categoryid bigint NOT NULL,
    category_name text COLLATE pg_catalog."default",
    CONSTRAINT category_pkey PRIMARY KEY (categoryid)
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS premier.category
    OWNER to postgres;
```

## Table: premier.product
### DROP TABLE IF EXISTS premier.product;

```
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
```

## Table: premier.orders
### DROP TABLE IF EXISTS premier.orders;

```
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
```

## Table: premier.order_details
### DROP TABLE IF EXISTS premier.order_details;

```
CREATE TABLE IF NOT EXISTS premier.order_details
(
    orderid bigint NOT NULL,
    productid bigint NOT NULL,
    quantity integer,
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
```

## Table: premier.transaction
### DROP TABLE IF EXISTS premier.transaction;

```
CREATE TABLE IF NOT EXISTS premier.transaction
(
    transactionid bigint NOT NULL,
    orderid bigint NOT NULL,
    loginid bigint NOT NULL,
    amount numeric,
    payment_method text COLLATE pg_catalog."default",
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
```
