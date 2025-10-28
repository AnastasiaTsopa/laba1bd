BEGIN;

CREATE TABLE IF NOT EXISTS public.sponsor
(
    sponsor_id integer NOT NULL,
    sponsor_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    contact_person character varying(100) COLLATE pg_catalog."default" NOT NULL,
    phone character varying(20) COLLATE pg_catalog."default" NOT NULL,
    email character varying(100) COLLATE pg_catalog."default" NOT NULL,
    total_budget numeric(12,2) NOT NULL,
    CONSTRAINT sponsor_pkey PRIMARY KEY (sponsor_id)
);

CREATE TABLE IF NOT EXISTS public.student
(
    student_id integer NOT NULL,
    first_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    patronymic character varying(50) COLLATE pg_catalog."default",
    course integer NOT NULL,
    gpa numeric(3,2) NOT NULL,
    email character varying(100) COLLATE pg_catalog."default" NOT NULL,
    birth_date date NOT NULL,
    CONSTRAINT student_pkey PRIMARY KEY (student_id)
);

CREATE TABLE IF NOT EXISTS public.grant
(
    grant_id integer NOT NULL,
    grant_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    grant_type character varying(50) COLLATE pg_catalog."default" NOT NULL,
    amount numeric(10,2) NOT NULL,
    description character varying(500) COLLATE pg_catalog."default",
    min_gpa numeric(3,2) NOT NULL,
    sponsor_id integer NOT NULL,
    CONSTRAINT grant_pkey PRIMARY KEY (grant_id)
);

CREATE TABLE IF NOT EXISTS public.application
(
    application_id integer NOT NULL,
    student_id integer NOT NULL,
    grant_id integer NOT NULL,
    application_date timestamp with time zone NOT NULL,
    status character varying(50) COLLATE pg_catalog."default" NOT NULL,
    justification character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT application_pkey PRIMARY KEY (application_id)
);

CREATE TABLE IF NOT EXISTS public.payment
(
    payment_id integer NOT NULL,
    application_id integer NOT NULL,
    payment_date timestamp with time zone NOT NULL,
    amount numeric(10,2) NOT NULL,
    transaction_number character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT payment_pkey PRIMARY KEY (payment_id)
);

ALTER TABLE IF EXISTS public.grant
    ADD CONSTRAINT sponsor_id_fk FOREIGN KEY (sponsor_id)
    REFERENCES public.sponsor (sponsor_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.application
    ADD CONSTRAINT student_id_fk FOREIGN KEY (student_id)
    REFERENCES public.student (student_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.application
    ADD CONSTRAINT grant_id_fk FOREIGN KEY (grant_id)
    REFERENCES public.grant (grant_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.payment
    ADD CONSTRAINT application_id_fk FOREIGN KEY (application_id)
    REFERENCES public.application (application_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;