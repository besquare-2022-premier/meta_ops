# Merch

Welcome to the meta repository for the Merch project. This repository will contain the information which required for the entire team.
Please dont leak the content of this repository. It is definitely confidential.

## Table of contents

- Entity Relationship Diagram
- SQL tables
- API documentation

## Database

-- Database: besquare-2022-premier
-- DROP DATABASE IF EXISTS "besquare-2022-premier";

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
 
-- Table: public.category
-- DROP TABLE IF EXISTS public.category;

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
