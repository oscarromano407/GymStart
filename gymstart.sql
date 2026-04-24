--
-- PostgreSQL database dump
--

\restrict nB4ZVeOdAtYRNJk59S58m4vYJhv5GgjjA0aacnBecaKUQHcXW12aX2o4aGcOWvf

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2026-04-24 01:29:15

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
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 221
-- Name: dias_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dias_usuario_id_seq OWNED BY public.dias_usuario.id;


--
-- TOC entry 228 (class 1259 OID 16837)
-- Name: ejercicio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ejercicio (
    id integer NOT NULL,
    nombre character varying(100),
    grupo_muscular character varying(50),
    tipo character varying(20)
);


ALTER TABLE public.ejercicio OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16836)
-- Name: ejercicio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ejercicio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ejercicio_id_seq OWNER TO postgres;

--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 227
-- Name: ejercicio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ejercicio_id_seq OWNED BY public.ejercicio.id;


--
-- TOC entry 234 (class 1259 OID 16882)
-- Name: entrenamiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entrenamiento (
    id integer NOT NULL,
    usuario_id integer,
    rutina_dia_id integer,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    completado boolean DEFAULT false
);


ALTER TABLE public.entrenamiento OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16902)
-- Name: entrenamiento_ejercicio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entrenamiento_ejercicio (
    id integer NOT NULL,
    entrenamiento_id integer,
    ejercicio_id integer
);


ALTER TABLE public.entrenamiento_ejercicio OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16901)
-- Name: entrenamiento_ejercicio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entrenamiento_ejercicio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.entrenamiento_ejercicio_id_seq OWNER TO postgres;

--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 235
-- Name: entrenamiento_ejercicio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entrenamiento_ejercicio_id_seq OWNED BY public.entrenamiento_ejercicio.id;


--
-- TOC entry 233 (class 1259 OID 16881)
-- Name: entrenamiento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entrenamiento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.entrenamiento_id_seq OWNER TO postgres;

--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 233
-- Name: entrenamiento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entrenamiento_id_seq OWNED BY public.entrenamiento.id;


--
-- TOC entry 240 (class 1259 OID 16942)
-- Name: registro_serie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.registro_serie (
    id integer NOT NULL,
    usuario_id integer,
    ejercicio_id integer,
    kg numeric,
    reps integer,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    entrenamiento_id integer,
    serie integer
);


ALTER TABLE public.registro_serie OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16941)
-- Name: registro_serie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.registro_serie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.registro_serie_id_seq OWNER TO postgres;

--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 239
-- Name: registro_serie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.registro_serie_id_seq OWNED BY public.registro_serie.id;


--
-- TOC entry 224 (class 1259 OID 16816)
-- Name: rutina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rutina (
    id integer NOT NULL,
    nombre character varying(50),
    dias integer
);


ALTER TABLE public.rutina OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16824)
-- Name: rutina_dia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rutina_dia (
    id integer NOT NULL,
    rutina_id integer,
    nombre character varying(50),
    orden integer
);


ALTER TABLE public.rutina_dia OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16823)
-- Name: rutina_dia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rutina_dia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rutina_dia_id_seq OWNER TO postgres;

--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 225
-- Name: rutina_dia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rutina_dia_id_seq OWNED BY public.rutina_dia.id;


--
-- TOC entry 230 (class 1259 OID 16845)
-- Name: rutina_ejercicio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rutina_ejercicio (
    id integer NOT NULL,
    rutina_dia_id integer,
    ejercicio_id integer,
    series integer,
    reps character varying(20),
    orden integer
);


ALTER TABLE public.rutina_ejercicio OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16844)
-- Name: rutina_ejercicio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rutina_ejercicio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rutina_ejercicio_id_seq OWNER TO postgres;

--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 229
-- Name: rutina_ejercicio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rutina_ejercicio_id_seq OWNED BY public.rutina_ejercicio.id;


--
-- TOC entry 223 (class 1259 OID 16815)
-- Name: rutina_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rutina_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rutina_id_seq OWNER TO postgres;

--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 223
-- Name: rutina_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rutina_id_seq OWNED BY public.rutina.id;


--
-- TOC entry 238 (class 1259 OID 16920)
-- Name: serie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serie (
    id integer NOT NULL,
    entrenamiento_ejercicio_id integer,
    peso numeric(5,2),
    repeticiones integer,
    completado boolean DEFAULT false
);


ALTER TABLE public.serie OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16919)
-- Name: serie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.serie_id_seq OWNER TO postgres;

--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 237
-- Name: serie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serie_id_seq OWNED BY public.serie.id;


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
    rutina_id integer,
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
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;


--
-- TOC entry 232 (class 1259 OID 16863)
-- Name: usuario_rutina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_rutina (
    id integer NOT NULL,
    usuario_id integer,
    rutina_id integer,
    fecha_asignacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.usuario_rutina OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16862)
-- Name: usuario_rutina_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_rutina_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_rutina_id_seq OWNER TO postgres;

--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 231
-- Name: usuario_rutina_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_rutina_id_seq OWNED BY public.usuario_rutina.id;


--
-- TOC entry 4908 (class 2604 OID 16806)
-- Name: dias_usuario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dias_usuario ALTER COLUMN id SET DEFAULT nextval('public.dias_usuario_id_seq'::regclass);


--
-- TOC entry 4911 (class 2604 OID 16840)
-- Name: ejercicio id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ejercicio ALTER COLUMN id SET DEFAULT nextval('public.ejercicio_id_seq'::regclass);


--
-- TOC entry 4915 (class 2604 OID 16885)
-- Name: entrenamiento id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrenamiento ALTER COLUMN id SET DEFAULT nextval('public.entrenamiento_id_seq'::regclass);


--
-- TOC entry 4918 (class 2604 OID 16905)
-- Name: entrenamiento_ejercicio id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrenamiento_ejercicio ALTER COLUMN id SET DEFAULT nextval('public.entrenamiento_ejercicio_id_seq'::regclass);


--
-- TOC entry 4921 (class 2604 OID 16945)
-- Name: registro_serie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro_serie ALTER COLUMN id SET DEFAULT nextval('public.registro_serie_id_seq'::regclass);


--
-- TOC entry 4909 (class 2604 OID 16819)
-- Name: rutina id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rutina ALTER COLUMN id SET DEFAULT nextval('public.rutina_id_seq'::regclass);


--
-- TOC entry 4910 (class 2604 OID 16827)
-- Name: rutina_dia id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rutina_dia ALTER COLUMN id SET DEFAULT nextval('public.rutina_dia_id_seq'::regclass);


--
-- TOC entry 4912 (class 2604 OID 16848)
-- Name: rutina_ejercicio id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rutina_ejercicio ALTER COLUMN id SET DEFAULT nextval('public.rutina_ejercicio_id_seq'::regclass);


--
-- TOC entry 4919 (class 2604 OID 16923)
-- Name: serie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serie ALTER COLUMN id SET DEFAULT nextval('public.serie_id_seq'::regclass);


--
-- TOC entry 4906 (class 2604 OID 16784)
-- Name: usuario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);


--
-- TOC entry 4913 (class 2604 OID 16866)
-- Name: usuario_rutina id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_rutina ALTER COLUMN id SET DEFAULT nextval('public.usuario_rutina_id_seq'::regclass);


--
-- TOC entry 5114 (class 0 OID 16803)
-- Dependencies: 222
-- Data for Name: dias_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dias_usuario (id, usuario_id, dia) FROM stdin;
16	5	L
17	5	X
18	5	V
19	6	L
20	6	M
21	6	X
22	6	J
23	6	V
24	7	L
25	7	X
26	7	V
27	8	L
28	8	M
29	8	V
\.


--
-- TOC entry 5120 (class 0 OID 16837)
-- Dependencies: 228
-- Data for Name: ejercicio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ejercicio (id, nombre, grupo_muscular, tipo) FROM stdin;
1	Cardio caminadora	cardio	cardio
2	Sentadilla	pierna	fuerza
3	Press banca	pecho	fuerza
4	Remo barra	espalda	fuerza
5	Curl biceps	brazo	fuerza
6	Triceps polea	brazo	fuerza
7	Peso muerto	pierna	fuerza
8	Press militar	hombro	fuerza
9	Jalon al pecho	espalda	fuerza
10	Elevaciones laterales	hombro	fuerza
11	Abdominales	core	fuerza
12	Prensa	pierna	fuerza
13	Press inclinado	pecho	fuerza
14	Remo maquina	espalda	fuerza
15	Curl martillo	brazo	fuerza
16	Fondos	pecho	fuerza
17	Peso muerto rumano	pierna	fuerza
18	Sentadilla bulgara	pierna	fuerza
19	Extension cuadriceps	pierna	fuerza
20	Curl femoral acostado	pierna	fuerza
21	Pantorrillas	pierna	fuerza
\.


--
-- TOC entry 5126 (class 0 OID 16882)
-- Dependencies: 234
-- Data for Name: entrenamiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entrenamiento (id, usuario_id, rutina_dia_id, fecha, completado) FROM stdin;
1	6	12	2026-04-24 00:36:32.781735	t
2	6	12	2026-04-24 00:36:55.594755	t
4	8	1	2026-04-24 01:02:00.508346	t
6	8	1	2026-04-24 01:11:07.417699	f
\.


--
-- TOC entry 5128 (class 0 OID 16902)
-- Dependencies: 236
-- Data for Name: entrenamiento_ejercicio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entrenamiento_ejercicio (id, entrenamiento_id, ejercicio_id) FROM stdin;
\.


--
-- TOC entry 5132 (class 0 OID 16942)
-- Dependencies: 240
-- Data for Name: registro_serie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.registro_serie (id, usuario_id, ejercicio_id, kg, reps, fecha, entrenamiento_id, serie) FROM stdin;
\.


--
-- TOC entry 5116 (class 0 OID 16816)
-- Dependencies: 224
-- Data for Name: rutina; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rutina (id, nombre, dias) FROM stdin;
1	FULLBODY	3
2	TORSO_PIERNA	4
4	PPL_6DIAS	6
5	5DIAS_TORSO	5
6	5DIAS_PIERNA	5
7	6DIAS_PIERNA	6
3	TORSO_PIERNA_PRIORIDAD_PIERNA	4
\.


--
-- TOC entry 5118 (class 0 OID 16824)
-- Dependencies: 226
-- Data for Name: rutina_dia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rutina_dia (id, rutina_id, nombre, orden) FROM stdin;
1	1	D¡a 1 Fullbody	1
2	1	D¡a 2 Fullbody	2
3	1	D¡a 3 Fullbody	3
4	2	D¡a 1 Torso A	1
5	2	D¡a 2 Pierna A	2
6	2	D¡a 3 Torso B	3
7	2	D¡a 4 Pierna B	4
8	3	D¡a 1 Pierna	1
9	3	D¡a 2 Torso	2
10	3	D¡a 3 Gl£teo	3
11	3	D¡a 4 Brazo	4
12	5	D¡a 1 Torso	1
13	5	D¡a 2 Pierna	2
14	5	D¡a 3 Push	3
15	5	D¡a 4 Pull	4
16	5	D¡a 5 Legs	5
17	6	D¡a 1 Pierna	1
18	6	D¡a 2 Torso	2
19	6	D¡a 3 Gl£teo	3
20	6	D¡a 4 Pull	4
21	6	D¡a 5 Pierna	5
22	4	Push A	1
23	4	Pull A	2
24	4	Legs A	3
25	4	Push B	4
26	4	Pull B	5
27	4	Legs B	6
28	7	D¡a 1 Pierna	1
29	7	D¡a 2 Pull	2
30	7	D¡a 3 Gl£teo	3
31	7	D¡a 4 Brazo	4
32	7	D¡a 5 Pierna	5
33	7	D¡a 6 Gl£teo	6
\.


--
-- TOC entry 5122 (class 0 OID 16845)
-- Dependencies: 230
-- Data for Name: rutina_ejercicio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rutina_ejercicio (id, rutina_dia_id, ejercicio_id, series, reps, orden) FROM stdin;
1	1	2	3	8	1
2	1	12	3	10	2
3	1	3	3	8	3
4	1	4	3	10	4
5	1	5	3	12	5
6	1	6	3	12	6
7	1	21	3	15	7
8	2	7	3	6	1
9	2	17	3	10	2
10	2	8	3	8	3
11	2	9	3	10	4
12	2	10	3	12	5
13	2	11	3	15	6
14	2	20	3	12	7
15	3	12	3	10	1
16	3	18	3	10	2
17	3	13	3	8	3
18	3	14	3	10	4
19	3	15	3	12	5
20	3	16	3	10	6
21	3	19	3	12	7
22	4	3	3	8	1
23	4	4	3	8	2
24	4	8	3	10	3
25	4	9	3	10	4
26	4	5	3	12	5
27	4	6	3	12	6
28	5	2	3	8	1
29	5	17	3	10	2
30	5	12	3	10	3
31	5	19	3	12	4
32	5	20	3	12	5
33	5	21	3	15	6
34	6	13	3	8	1
35	6	14	3	10	2
36	6	10	3	12	3
37	6	9	3	10	4
38	6	15	3	12	5
39	6	16	3	10	6
40	7	18	3	10	1
41	7	17	3	10	2
42	7	12	3	10	3
43	7	19	3	12	4
44	7	20	3	12	5
45	7	21	3	15	6
46	8	2	3	8	1
47	8	17	3	10	2
48	8	12	3	10	3
49	8	19	3	12	4
50	8	20	3	12	5
51	8	21	3	15	6
52	9	3	3	8	1
53	9	4	3	8	2
54	9	8	3	10	3
55	9	9	3	10	4
56	9	10	3	12	5
57	9	5	3	12	6
58	10	17	4	10	1
59	10	18	3	10	2
60	10	12	3	10	3
61	10	19	3	12	4
62	10	20	3	12	5
63	10	21	3	15	6
64	11	5	3	10	1
65	11	15	3	12	2
66	11	6	3	12	3
67	11	16	3	10	4
68	11	8	3	10	5
69	11	10	3	12	6
70	12	3	3	8	1
71	12	4	3	8	2
72	12	8	3	10	3
73	12	9	3	10	4
74	12	5	3	12	5
75	12	6	3	12	6
76	13	2	3	8	1
77	13	17	3	10	2
78	13	12	3	10	3
79	13	19	3	12	4
80	13	20	3	12	5
81	13	21	3	15	6
82	14	3	3	8	1
83	14	13	3	10	2
84	14	8	3	8	3
85	14	10	3	12	4
86	14	6	3	12	5
87	14	16	3	10	6
88	15	9	3	10	1
89	15	4	3	8	2
90	15	14	3	10	3
91	15	10	3	12	4
92	15	5	3	12	5
93	15	15	3	12	6
94	16	2	3	8	1
95	16	17	3	10	2
96	16	12	3	10	3
97	16	19	3	12	4
98	16	20	3	12	5
99	16	21	3	15	6
100	17	2	3	8	1
101	17	17	3	10	2
102	17	12	3	10	3
103	17	19	3	12	4
104	17	20	3	12	5
105	17	21	3	15	6
106	18	3	3	8	1
107	18	4	3	8	2
108	18	8	3	10	3
109	18	9	3	10	4
110	18	5	3	12	5
111	18	6	3	12	6
112	19	17	4	10	1
113	19	18	3	10	2
114	19	12	3	10	3
115	19	19	3	12	4
116	19	20	3	12	5
117	19	21	3	15	6
118	20	9	3	10	1
119	20	4	3	8	2
120	20	14	3	10	3
121	20	10	3	12	4
122	20	5	3	12	5
123	20	15	3	12	6
124	21	17	3	10	1
125	21	19	3	12	2
126	21	20	3	12	3
127	21	21	3	15	4
128	22	3	3	8	1
129	22	13	3	10	2
130	22	8	3	8	3
131	22	10	3	12	4
132	22	6	3	12	5
133	22	16	3	10	6
134	23	9	3	10	1
135	23	4	3	8	2
136	23	14	3	10	3
137	23	10	3	12	4
138	23	5	3	12	5
139	23	15	3	12	6
140	24	2	3	8	1
141	24	17	3	10	2
142	24	12	3	10	3
143	24	19	3	12	4
144	24	20	3	12	5
145	24	21	3	15	6
146	25	13	3	8	1
147	25	3	3	10	2
148	25	8	3	10	3
149	25	10	3	12	4
150	25	16	3	10	5
151	25	6	3	12	6
152	26	4	3	8	1
153	26	14	3	10	2
154	26	9	3	10	3
155	26	10	3	12	4
156	26	15	3	12	5
157	26	5	3	12	6
158	27	18	3	10	1
159	27	17	3	10	2
160	27	12	3	10	3
161	27	19	3	12	4
162	27	20	3	12	5
163	27	21	3	15	6
164	28	2	3	8	1
165	28	17	3	10	2
166	28	12	3	10	3
167	28	19	3	12	4
168	28	20	3	12	5
169	28	21	3	15	6
170	29	9	3	10	1
171	29	4	3	8	2
172	29	14	3	10	3
173	29	10	3	12	4
174	29	5	3	12	5
175	29	15	3	12	6
176	30	17	4	10	1
177	30	18	3	10	2
178	30	12	3	10	3
179	30	20	3	12	4
180	30	19	3	12	5
181	30	21	3	15	6
182	31	5	3	10	1
183	31	15	3	12	2
184	31	6	3	12	3
185	31	16	3	10	4
186	31	8	3	10	5
187	31	10	3	12	6
188	32	17	3	10	1
189	32	18	3	10	2
190	32	12	3	10	3
191	32	19	3	12	4
192	32	20	3	12	5
193	32	21	3	15	6
194	33	17	4	10	1
195	33	18	3	10	2
196	33	12	3	10	3
197	33	20	3	12	4
198	33	19	3	12	5
199	33	21	3	15	6
\.


--
-- TOC entry 5130 (class 0 OID 16920)
-- Dependencies: 238
-- Data for Name: serie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serie (id, entrenamiento_ejercicio_id, peso, repeticiones, completado) FROM stdin;
\.


--
-- TOC entry 5112 (class 0 OID 16781)
-- Dependencies: 220
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id, nombre, correo, contrasena, genero, edad, peso, estatura, objetivo, prioridad, dias, fecha_registro, rutina_id) FROM stdin;
5	leonardo	leo@gmail.com	$2y$10$4ePEKtpmlEL9K/3Kuzq2Gupi.gizNyn8lE2hHgDMoiWjhXq9qHvxO	H	20	70.00	1.80	hipertrofia	torso	3	2026-04-15 08:14:32.554796	1
6	oscar	os@gmail.com	$2y$10$e7khFaQHz4IAuy/21ZL0quzTUAJcdFP/gdX4lmMJdWrMCJKXo/aTa	H	22	80.00	1.83	hipertrofia	torso	5	2026-04-23 23:03:45.631784	5
7	saul	god@gmail.com	$2y$10$qbrhAgOvyOG9de/dnafP9.rC4A7qpiCv90iYAF1DUJe3cplvSy6rm	H	12	77.00	1.70	perder_peso	torso	3	2026-04-23 23:18:23.888077	1
8	Test	test1@gmail.com	$2y$10$E/Bir6L9PoDezsjLjrnKou3ZFHk2ZAtQNNGd2V6Kjp6g1icgCxl9K	H	22	80.00	1.80	perder_peso	torso	3	2026-04-24 01:01:08.296018	1
\.


--
-- TOC entry 5124 (class 0 OID 16863)
-- Dependencies: 232
-- Data for Name: usuario_rutina; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario_rutina (id, usuario_id, rutina_id, fecha_asignacion) FROM stdin;
\.


--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 221
-- Name: dias_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dias_usuario_id_seq', 29, true);


--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 227
-- Name: ejercicio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ejercicio_id_seq', 21, true);


--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 235
-- Name: entrenamiento_ejercicio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entrenamiento_ejercicio_id_seq', 1, false);


--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 233
-- Name: entrenamiento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entrenamiento_id_seq', 6, true);


--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 239
-- Name: registro_serie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.registro_serie_id_seq', 47, true);


--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 225
-- Name: rutina_dia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rutina_dia_id_seq', 33, true);


--
-- TOC entry 5155 (class 0 OID 0)
-- Dependencies: 229
-- Name: rutina_ejercicio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rutina_ejercicio_id_seq', 199, true);


--
-- TOC entry 5156 (class 0 OID 0)
-- Dependencies: 223
-- Name: rutina_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rutina_id_seq', 7, true);


--
-- TOC entry 5157 (class 0 OID 0)
-- Dependencies: 237
-- Name: serie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serie_id_seq', 1, false);


--
-- TOC entry 5158 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_seq', 8, true);


--
-- TOC entry 5159 (class 0 OID 0)
-- Dependencies: 231
-- Name: usuario_rutina_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_rutina_id_seq', 1, false);


--
-- TOC entry 4933 (class 2606 OID 16809)
-- Name: dias_usuario dias_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dias_usuario
    ADD CONSTRAINT dias_usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 4939 (class 2606 OID 16843)
-- Name: ejercicio ejercicio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ejercicio
    ADD CONSTRAINT ejercicio_pkey PRIMARY KEY (id);


--
-- TOC entry 4947 (class 2606 OID 16908)
-- Name: entrenamiento_ejercicio entrenamiento_ejercicio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrenamiento_ejercicio
    ADD CONSTRAINT entrenamiento_ejercicio_pkey PRIMARY KEY (id);


--
-- TOC entry 4945 (class 2606 OID 16890)
-- Name: entrenamiento entrenamiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrenamiento
    ADD CONSTRAINT entrenamiento_pkey PRIMARY KEY (id);


--
-- TOC entry 4951 (class 2606 OID 16951)
-- Name: registro_serie registro_serie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro_serie
    ADD CONSTRAINT registro_serie_pkey PRIMARY KEY (id);


--
-- TOC entry 4937 (class 2606 OID 16830)
-- Name: rutina_dia rutina_dia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rutina_dia
    ADD CONSTRAINT rutina_dia_pkey PRIMARY KEY (id);


--
-- TOC entry 4941 (class 2606 OID 16851)
-- Name: rutina_ejercicio rutina_ejercicio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rutina_ejercicio
    ADD CONSTRAINT rutina_ejercicio_pkey PRIMARY KEY (id);


--
-- TOC entry 4935 (class 2606 OID 16822)
-- Name: rutina rutina_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rutina
    ADD CONSTRAINT rutina_pkey PRIMARY KEY (id);


--
-- TOC entry 4949 (class 2606 OID 16927)
-- Name: serie serie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serie
    ADD CONSTRAINT serie_pkey PRIMARY KEY (id);


--
-- TOC entry 4929 (class 2606 OID 16801)
-- Name: usuario usuario_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_correo_key UNIQUE (correo);


--
-- TOC entry 4931 (class 2606 OID 16799)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 4943 (class 2606 OID 16870)
-- Name: usuario_rutina usuario_rutina_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_rutina
    ADD CONSTRAINT usuario_rutina_pkey PRIMARY KEY (id);


--
-- TOC entry 4953 (class 2606 OID 16810)
-- Name: dias_usuario dias_usuario_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dias_usuario
    ADD CONSTRAINT dias_usuario_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 4961 (class 2606 OID 16914)
-- Name: entrenamiento_ejercicio entrenamiento_ejercicio_ejercicio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrenamiento_ejercicio
    ADD CONSTRAINT entrenamiento_ejercicio_ejercicio_id_fkey FOREIGN KEY (ejercicio_id) REFERENCES public.ejercicio(id);


--
-- TOC entry 4962 (class 2606 OID 16909)
-- Name: entrenamiento_ejercicio entrenamiento_ejercicio_entrenamiento_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrenamiento_ejercicio
    ADD CONSTRAINT entrenamiento_ejercicio_entrenamiento_id_fkey FOREIGN KEY (entrenamiento_id) REFERENCES public.entrenamiento(id) ON DELETE CASCADE;


--
-- TOC entry 4959 (class 2606 OID 16896)
-- Name: entrenamiento entrenamiento_rutina_dia_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrenamiento
    ADD CONSTRAINT entrenamiento_rutina_dia_id_fkey FOREIGN KEY (rutina_dia_id) REFERENCES public.rutina_dia(id);


--
-- TOC entry 4960 (class 2606 OID 16891)
-- Name: entrenamiento entrenamiento_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrenamiento
    ADD CONSTRAINT entrenamiento_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- TOC entry 4952 (class 2606 OID 16936)
-- Name: usuario fk_rutina; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_rutina FOREIGN KEY (rutina_id) REFERENCES public.rutina(id);


--
-- TOC entry 4954 (class 2606 OID 16831)
-- Name: rutina_dia rutina_dia_rutina_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rutina_dia
    ADD CONSTRAINT rutina_dia_rutina_id_fkey FOREIGN KEY (rutina_id) REFERENCES public.rutina(id) ON DELETE CASCADE;


--
-- TOC entry 4955 (class 2606 OID 16857)
-- Name: rutina_ejercicio rutina_ejercicio_ejercicio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rutina_ejercicio
    ADD CONSTRAINT rutina_ejercicio_ejercicio_id_fkey FOREIGN KEY (ejercicio_id) REFERENCES public.ejercicio(id);


--
-- TOC entry 4956 (class 2606 OID 16852)
-- Name: rutina_ejercicio rutina_ejercicio_rutina_dia_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rutina_ejercicio
    ADD CONSTRAINT rutina_ejercicio_rutina_dia_id_fkey FOREIGN KEY (rutina_dia_id) REFERENCES public.rutina_dia(id) ON DELETE CASCADE;


--
-- TOC entry 4963 (class 2606 OID 16928)
-- Name: serie serie_entrenamiento_ejercicio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serie
    ADD CONSTRAINT serie_entrenamiento_ejercicio_id_fkey FOREIGN KEY (entrenamiento_ejercicio_id) REFERENCES public.entrenamiento_ejercicio(id) ON DELETE CASCADE;


--
-- TOC entry 4957 (class 2606 OID 16876)
-- Name: usuario_rutina usuario_rutina_rutina_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_rutina
    ADD CONSTRAINT usuario_rutina_rutina_id_fkey FOREIGN KEY (rutina_id) REFERENCES public.rutina(id);


--
-- TOC entry 4958 (class 2606 OID 16871)
-- Name: usuario_rutina usuario_rutina_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_rutina
    ADD CONSTRAINT usuario_rutina_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(id) ON DELETE CASCADE;


-- Completed on 2026-04-24 01:29:15

--
-- PostgreSQL database dump complete
--

\unrestrict nB4ZVeOdAtYRNJk59S58m4vYJhv5GgjjA0aacnBecaKUQHcXW12aX2o4aGcOWvf

