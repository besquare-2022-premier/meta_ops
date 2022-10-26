## CREATE DATABASE: "besquare-2022-premier"
```
CREATE DATABASE "besquare-2022-premier"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
 ```

## Table: public.category
## DROP TABLE IF EXISTS public.category;
```
CREATE TABLE IF NOT EXISTS public.category
(
    categoryid bigint NOT NULL,
    category_name text COLLATE pg_catalog."default",
    CONSTRAINT category_pkey PRIMARY KEY (categoryid)
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.category
    OWNER to postgres;
```

## Table: public.order_details
## DROP TABLE IF EXISTS public.order_details;
```
CREATE TABLE IF NOT EXISTS public.order_details
(
    orderid bigint NOT NULL,
    productid bigint NOT NULL,
    quantity integer
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_details
    OWNER to postgres;
```
    
## Table: public.orders
## DROP TABLE IF EXISTS public.orders;
```
CREATE TABLE IF NOT EXISTS public.orders
(
    orderid bigint NOT NULL,
    loginid bigint NOT NULL,
    ship_address text COLLATE pg_catalog."default",
    CONSTRAINT orders_pkey PRIMARY KEY (orderid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.orders
    OWNER to postgres;
```

## Table: public.product
## DROP TABLE IF EXISTS public.product;
```
CREATE TABLE IF NOT EXISTS public.product
(
    productid bigint NOT NULL,
    product_name text COLLATE pg_catalog."default",
    description text COLLATE pg_catalog."default",
    stock integer,
    price numeric,
    categoryid bigint,
    CONSTRAINT product_pkey PRIMARY KEY (productid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product
    OWNER to postgres;
```

## Table: public.transaction
## DROP TABLE IF EXISTS public.transaction;
```
CREATE TABLE IF NOT EXISTS public.transaction
(
    transactionid bigint NOT NULL,
    orderid bigint NOT NULL,
    loginid bigint NOT NULL,
    amount numeric,
    payment_method text COLLATE pg_catalog."default",
    CONSTRAINT transaction_pkey PRIMARY KEY (transactionid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.transaction
    OWNER to postgres;
```

## Table: public.user_details
## DROP TABLE IF EXISTS public.user_details;
```
CREATE TABLE IF NOT EXISTS public.user_details
(
    loginid bigint NOT NULL,
    fname text COLLATE pg_catalog."default",
    lname text COLLATE pg_catalog."default",
    username text COLLATE pg_catalog."default",
    email text COLLATE pg_catalog."default",
    pwd text COLLATE pg_catalog."default",
    tel_no bigint,
    address text COLLATE pg_catalog."default",
    CONSTRAINT user_details_pkey PRIMARY KEY (loginid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.user_details
    OWNER to postgres;
```
