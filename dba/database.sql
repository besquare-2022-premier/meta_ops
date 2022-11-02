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
    loginid integer NOT NULL DEFAULT nextval('premier.user_details_loginid_seq'::regclass),
    fname text COLLATE pg_catalog."default",
    lname text COLLATE pg_catalog."default",
    username text COLLATE pg_catalog."default" NOT NULL,
    email text COLLATE pg_catalog."default" NOT NULL,
    pwd text COLLATE pg_catalog."default" NOT NULL,
    tel_no character varying(15) COLLATE pg_catalog."default",
    address text COLLATE pg_catalog."default",
    first_join timestamp without time zone DEFAULT now(),
    access_field premier.access_level DEFAULT 'normal'::premier.access_level,
    residence text COLLATE pg_catalog."default",
    gender text COLLATE pg_catalog."default",
    birthday date,
    CONSTRAINT user_details_pkey PRIMARY KEY (loginid),
    CONSTRAINT tel_no_unique UNIQUE (tel_no),
    CONSTRAINT check_valid CHECK (tel_no::text ~ '^[0-9\.]+$'::text),
    CONSTRAINT proper_email CHECK (email ~* '^[A-Za-z0-9._+%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'::text)
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
    categoryid integer NOT NULL DEFAULT nextval('premier.category_categoryid_seq'::regclass),
    category_name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT category_pkey PRIMARY KEY (categoryid)
)
TABLESPACE pg_default;

CREATE UNIQUE INDEX IF NOT EXISTS category_name_index ON premier.category USING btree(
    category_name COLLATE pg_catalog."default"
) TABLESPACE pg_default;

-- CREATE TABLE premier.product
CREATE TABLE IF NOT EXISTS premier.product
(
    productid integer NOT NULL DEFAULT nextval('premier.product_productid_seq'::regclass),
    product_name text COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    stock integer DEFAULT '-1'::integer,
    price numeric NOT NULL,
    categoryid integer NOT NULL DEFAULT nextval('premier.product_categoryid_seq'::regclass),
    image text COLLATE pg_catalog."default" NOT NULL DEFAULT ''::text,
    CONSTRAINT product_pkey PRIMARY KEY (productid),
    CONSTRAINT fk_product FOREIGN KEY (categoryid)
        REFERENCES premier.category (categoryid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_stock_check CHECK (stock > '-1'::integer)
)
TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS product_index
    ON premier.product USING btree
    (product_name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- CREATE TABLE premier.orders
CREATE TABLE IF NOT EXISTS premier.orders
(
    orderid integer NOT NULL DEFAULT nextval('premier.orders_orderid_seq'::regclass),
    loginid integer NOT NULL DEFAULT nextval('premier.orders_loginid_seq'::regclass),
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
    orderid integer NOT NULL DEFAULT nextval('premier.order_details_orderid_seq'::regclass),
    productid integer NOT NULL DEFAULT nextval('premier.order_details_productid_seq'::regclass),
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
    transactionid integer NOT NULL DEFAULT nextval('premier.transaction_transactionid_seq'::regclass),
    orderid integer NOT NULL DEFAULT nextval('premier.transaction_orderid_seq'::regclass),
    loginid integer NOT NULL DEFAULT nextval('premier.transaction_loginid_seq'::regclass),
    amount numeric NOT NULL,
    payment_method text COLLATE pg_catalog."default",
    tx_status premier.tx_status,
    tx_time timestamp without time zone DEFAULT now(),
    tx_settle_time timestamp without time zone DEFAULT now(),
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

-- CREATE TABLE premier.user_data
CREATE TABLE IF NOT EXISTS premier.user_data
(
    loginid integer NOT NULL DEFAULT nextval('premier.user_data_loginid_seq'::regclass),
    items_bought integer DEFAULT 0,
    money_spent_myr numeric DEFAULT 0,
    CONSTRAINT user_data_loginid_fkey FOREIGN KEY (loginid)
        REFERENCES premier.user_details (loginid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

-- CREATE TABLE premier.verification
CREATE TABLE IF NOT EXISTS premier.verification
(
    verification_email text COLLATE pg_catalog."default" NOT NULL,
    verification_code character varying(25) COLLATE pg_catalog."default" NOT NULL,
    expired timestamp without time zone DEFAULT (now() + '00:30:00'::interval),
    CONSTRAINT verification_pkey PRIMARY KEY (verification_email)
)

TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS verification_index
    ON premier.verification USING btree
    (verification_code COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE VIEW premier.valid_verification_codes AS SELECT * FROM premier.verification WHERE expired>=NOW();

insert into premier.category(category_name) values ('shirts'), ('trousers'), ('underwear');
insert into premier.category(category_name) values ('shoes');
insert into premier.product(
product_name, description,stock,price, categoryid
) values (
'nike shoes', 'very nice', 50, 79.8, 4 ),
('adidas', 'good', 40, 10.0, 2),
('underwear', 'very soft', 5, 5.40, 3)
;
