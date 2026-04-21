--
-- PostgreSQL database dump
--

\restrict ROF9SzilOBJGYtPdLz0PxtYeUzQw2cQCyUobB9czpfieYu9uleXX4nbKRoxrSuP

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2026-04-20 23:40:31

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 222 (class 1259 OID 16803)
-- Name: dias_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dias_usuario (
    id integer NOT NULL,
    usuario_id integer,
    dia character varying(10)
);


ALTER TABLE public.dias_usuario OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16802)
-- Name: dias_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dias_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dias_usuario_id_seq OWNER TO postgres;

--
-- TOC entry 5032 (class 0 OID 0)
-- Dependencies: 221
-- Name: dias_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dias_usuario_id_seq OWNED BY public.dias_usuario.id;


--
-- TOC entry 220 (class 1259 OID 16781)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    correo character varying(100) NOT NULL,
    contrasena text CONSTRAINT "usuario_contrase¤a_not_null" NOT NULL,
    genero character(1) NOT NULL,
    edad integer,
    peso numeric(5,2),
    estatura numeric(5,2),
    objetivo character varying(50),
    prioridad character varying(20),
    dias integer,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT usuario_dias_check CHECK (((dias >= 3) AND (dias <= 6))),
    CONSTRAINT usuario_edad_check CHECK (((edad >= 12) AND (edad <= 80))),
    CONSTRAINT usuario_genero_check CHECK ((genero = ANY (ARRAY['H'::bpchar, 'M'::bpchar]))),
    CONSTRAINT usuario_objetivo_check CHECK (((objetivo)::text = ANY ((ARRAY['hipertrofia'::character varying, 'perder_peso'::character varying, 'recomposicion'::character varying])::text[]))),
    CONSTRAINT usuario_prioridad_check CHECK (((prioridad)::text = ANY ((ARRAY['torso'::character varying, 'pierna'::character varying])::text[])))
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16780)
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_id_seq OWNER TO postgres;

--
-- TOC entry 5033 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;


--
-- TOC entry 4863 (class 2604 OID 16806)
-- Name: dias_usuario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dias_usuario ALTER COLUMN id SET DEFAULT nextval('public.dias_usuario_id_seq'::regclass);


--
-- TOC entry 4861 (class 2604 OID 16784)
-- Name: usuario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);


--
-- TOC entry 5026 (class 0 OID 16803)
-- Dependencies: 222
-- Data for Name: dias_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dias_usuario (id, usuario_id, dia) FROM stdin;
16	5	L
17	5	X
18	5	V
\.


--
-- TOC entry 5024 (class 0 OID 16781)
-- Dependencies: 220
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id, nombre, correo, contrasena, genero, edad, peso, estatura, objetivo, prioridad, dias, fecha_registro) FROM stdin;
5	leonardo	leo@gmail.com	$2y$10$4ePEKtpmlEL9K/3Kuzq2Gupi.gizNyn8lE2hHgDMoiWjhXq9qHvxO	H	20	70.00	1.80	hipertrofia	torso	3	2026-04-15 08:14:32.554796
\.


--
-- TOC entry 5034 (class 0 OID 0)
-- Dependencies: 221
-- Name: dias_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dias_usuario_id_seq', 18, true);


--
-- TOC entry 5035 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_seq', 5, true);


--
-- TOC entry 4874 (class 2606 OID 16809)
-- Name: dias_usuario dias_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dias_usuario
    ADD CONSTRAINT dias_usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 4870 (class 2606 OID 16801)
-- Name: usuario usuario_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_correo_key UNIQUE (correo);


--
-- TOC entry 4872 (class 2606 OID 16799)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 4875 (class 2606 OID 16810)
-- Name: dias_usuario dias_usuario_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dias_usuario
    ADD CONSTRAINT dias_usuario_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(id) ON DELETE CASCADE;


-- Completed on 2026-04-20 23:40:31

--
-- PostgreSQL database dump complete
--

\unrestrict ROF9SzilOBJGYtPdLz0PxtYeUzQw2cQCyUobB9czpfieYu9uleXX4nbKRoxrSuP

