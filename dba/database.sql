-- CREATE DATABASE
-- CREATE DATABASE "premier_project"
--     WITH 
--     ENCODING = 'UTF8'
--     LC_COLLATE = 'en_US.UTF-8'
--     LC_CTYPE = 'en_US.UTF-8'
--     TABLESPACE = pg_default
--     CONNECTION LIMIT = -1;

-- CREATE SCHEMA
CREATE SCHEMA IF NOT EXISTS premier;

CREATE TYPE premier.access_level AS ENUM ('normal','admin');
CREATE TYPE premier.tx_status AS ENUM ('created','succeeded','failed','cancelled');
CREATE DOMAIN premier.currency AS numeric not null check(value>0);

-- CREATE TABLE premier.user_details
CREATE TABLE IF NOT EXISTS premier.user_details
(
    loginid serial NOT NULL,
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
    secure_word TEXT NOT NULL,
    CONSTRAINT user_details_pkey PRIMARY KEY (loginid),
    CONSTRAINT tel_no_unique UNIQUE (tel_no),
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
    categoryid serial NOT NULL,
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
    productid serial NOT NULL,
    product_name text COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    stock integer DEFAULT '-1'::integer,
    price integer NOT NULL,
    categoryid integer NOT NULL,
    image text COLLATE pg_catalog."default" NOT NULL DEFAULT ''::text,
    CONSTRAINT product_pkey PRIMARY KEY (productid),
    CONSTRAINT fk_product FOREIGN KEY (categoryid)
        REFERENCES premier.category (categoryid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_stock_check CHECK (stock >= '-1'::integer)
)
TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS product_index
    ON premier.product USING btree
    (product_name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- CREATE TABLE premier.orders
CREATE TABLE IF NOT EXISTS premier.orders
(
    orderid serial NOT NULL,
    loginid integer NOT NULL,
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
    orderid integer NOT NULL,
    productid integer NOT NULL,
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
    transactionid serial NOT NULL,
    orderid integer NOT NULL,
    loginid integer NOT NULL,
    amount integer NOT NULL,
    payment_method text COLLATE pg_catalog."default",
    tx_status premier.tx_status default 'created',
    tx_time timestamp without time zone DEFAULT now(),
    tx_reference text NULL,
    tx_settle_time timestamp without time zone ,
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
    loginid integer NOT NULL,
    items_bought integer DEFAULT 0,
    money_spent_myr integer DEFAULT 0,
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

CREATE TABLE premier.authentication_access_tokens (
    access_token CHAR(20) PRIMARY KEY,
    loginid integer NOT NULL,
    expiry timestamp without time zone NOT NULL DEFAULT NOW()+ INTERVAL '1 day',
    CONSTRAINT fk_loginid FOREIGN KEY(loginid) REFERENCES premier.user_details(loginid)
);

CREATE VIEW premier.valid_access_tokens AS (SELECT * FROM premier.authentication_access_tokens WHERE expiry>=NOW());

ALTER VIEW premier.valid_access_tokens ALTER COLUMN expiry SET DEFAULT NOW()+ INTERVAL '1 day';

CREATE TYPE premier.rating AS ENUM ('1','2','3','4','5');

CREATE TABLE premier.product_review
(
    productid integer NOT NULL,
    loginid integer NOT NULL,
    product_rating premier.rating,
    product_review text NOT NULL,
    review_time timestamp DEFAULT now(),
    CONSTRAINT product_review_fkey FOREIGN KEY (productid)
        REFERENCES premier.product (productid),
    CONSTRAINT product_review_loginid_fkey FOREIGN KEY (loginid)
        REFERENCES premier.user_details (loginid)
);

CREATE TABLE premier.community_topic
(
    topicid serial NOT NULL,
    topic text NOT NULL,
    CONSTRAINT community_topic_pkey PRIMARY KEY (topicid)
);

CREATE TABLE premier.community_message
(
    messageid serial NOT NULL,
    topicid integer NOT NULL,
    loginid integer NOT NULL,
    message_content text NOT NULL,
    message_time timestamp DEFAULT now(),
    replying integer NULL,
    CONSTRAINT community_message_pkey PRIMARY KEY (messageid),
    CONSTRAINT community_message_topicid_fkey FOREIGN KEY (topicid)
        REFERENCES premier.community_topic (topicid),
    CONSTRAINT community_message_loginid_fkey FOREIGN KEY (loginid)
        REFERENCES premier.user_details (loginid),
    CONSTRAINT community_replying_to_ref FOREIGN KEY (replying)
        REFERENCES premier.community_message (messageid)
);

-- Ingest the data
\copy premier.category FROM './categories.csv' csv
\copy premier.product FROM './products.csv' csv

create or replace procedure premier.nuke_invalids() language plpgsql as $$
begin
delete from premier.authentication_access_tokens where expiry<NOW();
delete from premier.verification where expired < NOW();
end;$$;