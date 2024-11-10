--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Homebrew)
-- Dumped by pg_dump version 16.4 (Homebrew)

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
-- Name: bookings; Type: TABLE; Schema: public; Owner: paul
--

CREATE TABLE public.bookings (
    id smallint NOT NULL,
    cinema_id smallint NOT NULL,
    seat_id character varying(5) NOT NULL,
    date date NOT NULL,
    "time" time with time zone NOT NULL,
    payment_method character varying(15) NOT NULL,
    user_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.bookings OWNER TO paul;

--
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: paul
--

CREATE SEQUENCE public.bookings_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookings_id_seq OWNER TO paul;

--
-- Name: bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paul
--

ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;


--
-- Name: cinemas; Type: TABLE; Schema: public; Owner: paul
--

CREATE TABLE public.cinemas (
    id smallint NOT NULL,
    name character varying(15) NOT NULL,
    location character varying(20) NOT NULL,
    seats smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone,
    deleted_at time with time zone
);


ALTER TABLE public.cinemas OWNER TO paul;

--
-- Name: cinemas_id_seq; Type: SEQUENCE; Schema: public; Owner: paul
--

CREATE SEQUENCE public.cinemas_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cinemas_id_seq OWNER TO paul;

--
-- Name: cinemas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paul
--

ALTER SEQUENCE public.cinemas_id_seq OWNED BY public.cinemas.id;


--
-- Name: payment_methods; Type: TABLE; Schema: public; Owner: paul
--

CREATE TABLE public.payment_methods (
    id smallint NOT NULL,
    name character varying(15) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.payment_methods OWNER TO paul;

--
-- Name: payment_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: paul
--

CREATE SEQUENCE public.payment_methods_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_methods_id_seq OWNER TO paul;

--
-- Name: payment_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paul
--

ALTER SEQUENCE public.payment_methods_id_seq OWNED BY public.payment_methods.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: paul
--

CREATE TABLE public.payments (
    id smallint NOT NULL,
    booking_id smallint NOT NULL,
    payment_method_id smallint NOT NULL,
    detail json NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.payments OWNER TO paul;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: paul
--

CREATE SEQUENCE public.payments_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO paul;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paul
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: paul
--

CREATE TABLE public.sessions (
    token uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expired_at timestamp with time zone
);


ALTER TABLE public.sessions OWNER TO paul;

--
-- Name: users; Type: TABLE; Schema: public; Owner: paul
--

CREATE TABLE public.users (
    id smallint NOT NULL,
    username character varying(15) NOT NULL,
    password character varying(15) NOT NULL,
    email character varying(25) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.users OWNER TO paul;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: paul
--

CREATE SEQUENCE public.users_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO paul;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paul
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: bookings id; Type: DEFAULT; Schema: public; Owner: paul
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);


--
-- Name: cinemas id; Type: DEFAULT; Schema: public; Owner: paul
--

ALTER TABLE ONLY public.cinemas ALTER COLUMN id SET DEFAULT nextval('public.cinemas_id_seq'::regclass);


--
-- Name: payment_methods id; Type: DEFAULT; Schema: public; Owner: paul
--

ALTER TABLE ONLY public.payment_methods ALTER COLUMN id SET DEFAULT nextval('public.payment_methods_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: paul
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: paul
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: paul
--

COPY public.bookings (id, cinema_id, seat_id, date, "time", payment_method, user_id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: cinemas; Type: TABLE DATA; Schema: public; Owner: paul
--

COPY public.cinemas (id, name, location, seats, created_at, updated_at, deleted_at) FROM stdin;
1	Cinema XXI	Jakarta	50	2024-05-01 10:30:12+07	\N	\N
2	CGV	Bandung	80	2024-05-15 14:45:37+07	\N	\N
3	Cinepolis	Surabaya	100	2024-06-11 09:15:44+07	\N	\N
4	Flix	Denpasar	50	2024-05-20 13:28:30+07	\N	\N
5	Cinema XXI	Medan	80	2024-04-25 17:42:50+07	\N	\N
6	CGV	Manado	100	2024-05-08 12:18:22+07	\N	\N
7	Cinepolis	Bogor	50	2024-04-20 11:57:10+07	\N	\N
8	Flix	Surakarta	80	2024-06-12 16:03:45+07	\N	\N
9	Cinema XXI	Pontianak	100	2024-05-29 10:50:11+07	\N	\N
10	CGV	Bekasi	50	2024-05-18 15:34:29+07	\N	\N
11	Cinepolis	Depok	80	2024-04-11 08:29:14+07	\N	\N
12	Flix	Palembang	100	2024-06-15 14:50:37+07	\N	\N
13	Cinema XXI	Makassar	50	2024-04-02 10:19:58+07	\N	\N
14	CGV	Malang	80	2024-04-29 11:22:10+07	\N	\N
15	Cinepolis	Samarinda	100	2024-05-04 12:34:28+07	\N	\N
16	Flix	Tasikmalaya	50	2024-05-16 17:12:13+07	\N	\N
17	Cinema XXI	Pekanbaru	80	2024-06-09 09:42:29+07	\N	\N
18	CGV	Semarang	100	2024-05-21 13:11:10+07	\N	\N
19	Cinepolis	Jakarta	50	2024-05-06 14:48:52+07	\N	\N
20	Flix	Bandung	80	2024-04-15 16:19:36+07	\N	\N
21	Cinema XXI	Surabaya	100	2024-05-12 09:27:53+07	\N	\N
22	CGV	Denpasar	50	2024-06-18 10:35:28+07	\N	\N
23	Cinepolis	Medan	80	2024-04-30 11:44:47+07	\N	\N
24	Flix	Manado	100	2024-05-01 12:39:18+07	\N	\N
25	Cinema XXI	Bogor	50	2024-05-25 14:22:33+07	\N	\N
26	CGV	Surakarta	80	2024-06-05 15:17:09+07	\N	\N
27	Cinepolis	Pontianak	100	2024-05-26 16:10:47+07	\N	\N
28	Flix	Bekasi	50	2024-04-14 17:18:10+07	\N	\N
29	Cinema XXI	Depok	80	2024-06-10 13:14:52+07	\N	\N
30	CGV	Palembang	100	2024-05-17 10:25:50+07	\N	\N
31	Cinepolis	Makassar	50	2024-04-29 15:33:44+07	\N	\N
32	Flix	Malang	80	2024-04-22 14:20:15+07	\N	\N
33	Cinema XXI	Samarinda	100	2024-05-20 09:45:26+07	\N	\N
34	CGV	Tasikmalaya	50	2024-04-04 13:30:28+07	\N	\N
35	Cinepolis	Pekanbaru	80	2024-06-01 11:05:12+07	\N	\N
36	Flix	Semarang	100	2024-05-09 10:15:39+07	\N	\N
37	Cinema XXI	Bandung	80	2024-05-07 10:40:13+07	\N	\N
38	CGV	Jakarta	50	2024-04-17 16:33:24+07	\N	\N
39	Cinepolis	Denpasar	100	2024-06-10 08:40:28+07	\N	\N
40	Flix	Surabaya	80	2024-04-19 13:45:29+07	\N	\N
41	Cinema XXI	Malang	50	2024-04-18 15:32:55+07	\N	\N
42	CGV	Bogor	80	2024-05-12 12:17:42+07	\N	\N
43	Cinepolis	Surakarta	100	2024-06-12 09:25:14+07	\N	\N
44	Flix	Medan	50	2024-05-29 13:05:19+07	\N	\N
\.


--
-- Data for Name: payment_methods; Type: TABLE DATA; Schema: public; Owner: paul
--

COPY public.payment_methods (id, name, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: paul
--

COPY public.payments (id, booking_id, payment_method_id, detail, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: paul
--

COPY public.sessions (token, user_id, created_at, expired_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: paul
--

COPY public.users (id, username, password, email, created_at, updated_at, deleted_at) FROM stdin;
1	x	x	x@x.x	2024-11-10 22:11:17.24349+07	\N	\N
\.


--
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paul
--

SELECT pg_catalog.setval('public.bookings_id_seq', 1, false);


--
-- Name: cinemas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paul
--

SELECT pg_catalog.setval('public.cinemas_id_seq', 44, true);


--
-- Name: payment_methods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paul
--

SELECT pg_catalog.setval('public.payment_methods_id_seq', 1, false);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paul
--

SELECT pg_catalog.setval('public.payments_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paul
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: paul
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: cinemas cinemas_name_location_key; Type: CONSTRAINT; Schema: public; Owner: paul
--

ALTER TABLE ONLY public.cinemas
    ADD CONSTRAINT cinemas_name_location_key UNIQUE (name, location);


--
-- Name: cinemas cinemas_pkey; Type: CONSTRAINT; Schema: public; Owner: paul
--

ALTER TABLE ONLY public.cinemas
    ADD CONSTRAINT cinemas_pkey PRIMARY KEY (id);


--
-- Name: payment_methods payment_methods_name_key; Type: CONSTRAINT; Schema: public; Owner: paul
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT payment_methods_name_key UNIQUE (name);


--
-- Name: payment_methods payment_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: paul
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT payment_methods_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: paul
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (token);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: paul
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: paul
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: paul
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

