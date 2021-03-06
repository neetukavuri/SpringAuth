--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

DROP DATABASE IF EXISTS demodb;

CREATE DATABASE demodb;

\c demodb

CREATE USER dbuser with encrypted password 'dbuser';
GRANT ALL privileges on database demodb to dbuser;

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: dbuser
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(20)
);


ALTER TABLE public.roles OWNER TO dbuser;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: dbuser
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO dbuser;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dbuser
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: dbuser
--

CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.user_roles OWNER TO dbuser;

--
-- Name: users; Type: TABLE; Schema: public; Owner: dbuser
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying(255),
    password character varying(255),
    username character varying(255),
    created_by character varying(255),
    created_date timestamp without time zone,
    modified_by character varying(255),
    modified_date timestamp without time zone
);


ALTER TABLE public.users OWNER TO dbuser;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: dbuser
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO dbuser;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dbuser
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: dbuser
--

COPY public.roles (id, name) FROM stdin;
1	ROLE_USER
2	ROLE_MODERATOR
3	ROLE_ADMIN
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: dbuser
--

COPY public.user_roles (user_id, role_id) FROM stdin;
1	1
2	3
2	1
3	2
3	1
4	1
5	1
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: dbuser
--

COPY public.users (id, email, password, username, created_by, created_date, modified_by, modified_date) FROM stdin;
1	neetu.kavuri@gmail.com	$2a$10$Zd4gPkkyCNOO98PKRe.X2.xPkkYQzclxIybHK44P3PigrkD0FvByu	nkavuri	\N	\N	\N	\N
2	demoadmin@kwality.com	$2a$10$VMNexR9sD9PuT0p2YLRTtu/FGbZMQ/djTwrskymgQXwRpYA5149mK	admin	\N	\N	\N	\N
3	demomod@kwality.com	$2a$10$a8WLbAHuj8IlRQqi78kOy.808EKFBg74Jl3GHo0bnY9E71PSQoOZi	mod	\N	\N	\N	\N
5	ckavuri@gmail.com	$2a$10$nn8pk4pL9QrFsOB2T2i5aup8oAUKbqYR9vlsG0pkoARmW/pC7MdvC	ckavuri	\N	\N	anonymousUser	2021-03-03 14:47:54.376
4	tkavuri1@gmail.com	$2a$10$OL4JN5n5i64jqPYj5Qy8puMtV1Jy33V6rUYjVbAdTfT16W6lZtoau	tkavuri	\N	\N	\N	\N
\.


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dbuser
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dbuser
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: users uk6dotkott2kjsp8vw4d0m25fb7; Type: CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk6dotkott2kjsp8vw4d0m25fb7 UNIQUE (email);


--
-- Name: users ukr43af9ap4edm43mmtq01oddj6; Type: CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT ukr43af9ap4edm43mmtq01oddj6 UNIQUE (username);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: user_roles fkh8ciramu9cc9q3qcqiv4ue8a6; Type: FK CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fkh8ciramu9cc9q3qcqiv4ue8a6 FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: user_roles fkhfh9dx7w3ubf1co1vdev94g3f; Type: FK CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fkhfh9dx7w3ubf1co1vdev94g3f FOREIGN KEY (user_id) REFERENCES public.users(id);

COMMIT;
--
-- PostgreSQL database dump complete
--

