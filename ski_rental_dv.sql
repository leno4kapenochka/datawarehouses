CREATE DATABASE ski_rental_dv
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE SCHEMA IF NOT EXISTS public
    AUTHORIZATION pg_database_owner;

COMMENT ON SCHEMA public
    IS 'standard public schema';

GRANT USAGE ON SCHEMA public TO PUBLIC;

GRANT ALL ON SCHEMA public TO pg_database_owner;

CREATE TABLE IF NOT EXISTS public."Hub_rental"
(
    rental_key integer NOT NULL,
    load_date "char",
    record_source "char",
    CONSTRAINT "Hub_rental_pkey" PRIMARY KEY (rental_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Hub_rental"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."Hub_client"
(
    client_key integer NOT NULL,
    load_date "char",
    record_source "char",
    CONSTRAINT "Hub_client_pkey" PRIMARY KEY (client_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Hub_client"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."Hub_ski"
(
    ski_key integer NOT NULL,
    load_date "char",
    record_source "char",
    CONSTRAINT "Hub_ski_pkey" PRIMARY KEY (ski_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Hub_ski"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."Hub_boots"
(
    boots_key integer NOT NULL,
    load_date "char",
    record_source "char",
    CONSTRAINT "Hub_boots_pkey" PRIMARY KEY (boots_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Hub_boots"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."Hub_rate"
(
    "rate_key " integer NOT NULL,
    load_date "char",
    record_source "char",
    CONSTRAINT "Hub_rate_pkey" PRIMARY KEY ("rate_key ")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Hub_rate"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."Link_rental_details"
(
    rental_details_key integer NOT NULL,
    load_date "char",
    record_source "char",
    "rental_key " integer,
    "client_key " integer,
    "ski_key " integer,
    "boots_key " integer,
    CONSTRAINT "Link_rental_details_pkey" PRIMARY KEY (rental_details_key),
    CONSTRAINT boots FOREIGN KEY ("boots_key ")
        REFERENCES public."Hub_boots" (boots_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT client FOREIGN KEY ("client_key ")
        REFERENCES public."Hub_client" (client_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT rental FOREIGN KEY ("rental_key ")
        REFERENCES public."Hub_rental" (rental_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT ski FOREIGN KEY ("ski_key ")
        REFERENCES public."Hub_ski" (ski_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Link_rental_details"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."Link_client_details"
(
    "client_details_key " integer NOT NULL,
    load_date "char",
    record_source "char",
    "client_key " integer,
    "rate_key " integer,
    CONSTRAINT "Link_client_details_pkey" PRIMARY KEY ("client_details_key "),
    CONSTRAINT client FOREIGN KEY ("client_key ")
        REFERENCES public."Hub_client" (client_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT rate FOREIGN KEY ("rate_key ")
        REFERENCES public."Hub_rate" ("rate_key ") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Link_client_details"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."Satellite_rental"
(
    "rental_key " integer NOT NULL,
    load_date "char",
    record_source "char",
    start_time "char",
    end_time "char",
    CONSTRAINT "Satellite_rental_pkey" PRIMARY KEY ("rental_key "),
    CONSTRAINT rental FOREIGN KEY ("rental_key ")
        REFERENCES public."Hub_rental" (rental_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Satellite_rental"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."Satellite_client"
(
    "client_key " integer NOT NULL,
    load_date "char",
    record_source "char",
    surname "char",
    name "char",
    document "char",
    phone_number bigint,
    age integer,
    CONSTRAINT "Satellite_client_pkey" PRIMARY KEY ("client_key "),
    CONSTRAINT client FOREIGN KEY ("client_key ")
        REFERENCES public."Hub_client" (client_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Satellite_client"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."Satellite_ski"
(
    "ski_key " integer NOT NULL,
    load_date "char",
    record_source "char",
    description_ski "char",
    description_ski_pole "char",
    CONSTRAINT "Satellite_ski_pkey" PRIMARY KEY ("ski_key "),
    CONSTRAINT ski FOREIGN KEY ("ski_key ")
        REFERENCES public."Hub_ski" (ski_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Satellite_ski"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."Satellite_boots"
(
    "boots_key " integer NOT NULL,
    load_date "char",
    record_source "char",
    size integer,
    description "char",
    CONSTRAINT "Satellite_boots_pkey" PRIMARY KEY ("boots_key "),
    CONSTRAINT boots FOREIGN KEY ("boots_key ")
        REFERENCES public."Hub_boots" (boots_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Satellite_boots"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."Satellite_rate"
(
    "rate_key " integer NOT NULL,
    load_date "char",
    record_source "char",
    price integer,
    description "char",
    CONSTRAINT "Satellite_rate_pkey" PRIMARY KEY ("rate_key "),
    CONSTRAINT rate FOREIGN KEY ("rate_key ")
        REFERENCES public."Hub_rate" ("rate_key ") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Satellite_rate"
    OWNER to postgres;

