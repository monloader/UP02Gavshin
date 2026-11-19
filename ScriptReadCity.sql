--
-- PostgreSQL database dump
--

\restrict Uihxkyr3T9c8QBWeoRtinCCgcVXpH6fJFQTVRJ4Ogx5rdlPiv3idPTFBx4Nm0Ug

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-19 17:22:09

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
-- TOC entry 226 (class 1259 OID 16500)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16499)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 225
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 228 (class 1259 OID 16511)
-- Name: manufacturers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manufacturers (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.manufacturers OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16510)
-- Name: manufacturers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manufacturers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.manufacturers_id_seq OWNER TO postgres;

--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 227
-- Name: manufacturers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manufacturers_id_seq OWNED BY public.manufacturers.id;


--
-- TOC entry 240 (class 1259 OID 16630)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    article character varying(20) NOT NULL,
    quantity integer NOT NULL,
    CONSTRAINT order_items_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16629)
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 239
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- TOC entry 236 (class 1259 OID 16590)
-- Name: order_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_status (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.order_status OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16589)
-- Name: order_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_status_id_seq OWNER TO postgres;

--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 235
-- Name: order_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_status_id_seq OWNED BY public.order_status.id;


--
-- TOC entry 238 (class 1259 OID 16601)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    order_date date NOT NULL,
    delivery_date date NOT NULL,
    pickup_point_id integer NOT NULL,
    user_id integer NOT NULL,
    code integer NOT NULL,
    order_status_id integer NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16600)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 237
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- TOC entry 234 (class 1259 OID 16579)
-- Name: pickups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pickups (
    id integer NOT NULL,
    postal_code character varying(10) NOT NULL,
    city character varying(100) NOT NULL,
    street character varying(150) NOT NULL,
    house character varying(20)
);


ALTER TABLE public.pickups OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16578)
-- Name: pickups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pickups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pickups_id_seq OWNER TO postgres;

--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 233
-- Name: pickups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pickups_id_seq OWNED BY public.pickups.id;


--
-- TOC entry 232 (class 1259 OID 16533)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    article character varying(20) NOT NULL,
    name character varying(255) NOT NULL,
    unit_id integer NOT NULL,
    price numeric(10,2) NOT NULL,
    supplier_id integer NOT NULL,
    manufacturer_id integer NOT NULL,
    category_id integer NOT NULL,
    sale integer DEFAULT 0 NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    description character varying(1000),
    photo character varying(255),
    CONSTRAINT products_price_check CHECK ((price >= (0)::numeric)),
    CONSTRAINT products_quantity_check CHECK ((quantity >= 0)),
    CONSTRAINT products_sale_check CHECK (((sale >= 0) AND (sale <= 100)))
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16532)
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 231
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- TOC entry 222 (class 1259 OID 16470)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16469)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 221
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 230 (class 1259 OID 16522)
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16521)
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.suppliers_id_seq OWNER TO postgres;

--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 229
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliers_id_seq OWNED BY public.suppliers.id;


--
-- TOC entry 220 (class 1259 OID 16395)
-- Name: units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.units (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.units OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16394)
-- Name: units_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.units_id_seq OWNER TO postgres;

--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 219
-- Name: units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.units_id_seq OWNED BY public.units.id;


--
-- TOC entry 224 (class 1259 OID 16481)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    role_id integer NOT NULL,
    fio character varying(255) NOT NULL,
    login character varying(100) NOT NULL,
    password character varying(100) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16480)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5155 (class 0 OID 0)
-- Dependencies: 223
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4909 (class 2604 OID 16503)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 4910 (class 2604 OID 16514)
-- Name: manufacturers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers ALTER COLUMN id SET DEFAULT nextval('public.manufacturers_id_seq'::regclass);


--
-- TOC entry 4918 (class 2604 OID 16633)
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- TOC entry 4916 (class 2604 OID 16593)
-- Name: order_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status ALTER COLUMN id SET DEFAULT nextval('public.order_status_id_seq'::regclass);


--
-- TOC entry 4917 (class 2604 OID 16604)
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- TOC entry 4915 (class 2604 OID 16582)
-- Name: pickups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickups ALTER COLUMN id SET DEFAULT nextval('public.pickups_id_seq'::regclass);


--
-- TOC entry 4912 (class 2604 OID 16536)
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- TOC entry 4907 (class 2604 OID 16473)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4911 (class 2604 OID 16525)
-- Name: suppliers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- TOC entry 4906 (class 2604 OID 16398)
-- Name: units id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units ALTER COLUMN id SET DEFAULT nextval('public.units_id_seq'::regclass);


--
-- TOC entry 4908 (class 2604 OID 16484)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5125 (class 0 OID 16500)
-- Dependencies: 226
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories (id, name) VALUES (1, 'Художественная литература');
INSERT INTO public.categories (id, name) VALUES (2, 'Учебник для вузов');
INSERT INTO public.categories (id, name) VALUES (3, 'Хрестоматия');
INSERT INTO public.categories (id, name) VALUES (4, 'Учебное пособие');


--
-- TOC entry 5127 (class 0 OID 16511)
-- Dependencies: 228
-- Data for Name: manufacturers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.manufacturers (id, name) VALUES (1, 'Яуза');
INSERT INTO public.manufacturers (id, name) VALUES (2, 'Т8 Издательские технологии');
INSERT INTO public.manufacturers (id, name) VALUES (3, 'Прогресс книга');
INSERT INTO public.manufacturers (id, name) VALUES (4, 'Время');
INSERT INTO public.manufacturers (id, name) VALUES (6, 'Неолит');
INSERT INTO public.manufacturers (id, name) VALUES (7, 'Амрита-Русь');
INSERT INTO public.manufacturers (id, name) VALUES (8, 'Златоуст');
INSERT INTO public.manufacturers (id, name) VALUES (9, 'Аспект Пресс');
INSERT INTO public.manufacturers (id, name) VALUES (10, 'ВКН');
INSERT INTO public.manufacturers (id, name) VALUES (5, 'Лениздат');


--
-- TOC entry 5139 (class 0 OID 16630)
-- Dependencies: 240
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (1, 1, 'А112Т4', 2);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (2, 1, 'G843H5', 2);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (3, 2, 'G843H5', 1);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (4, 2, 'А112Т4', 1);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (5, 3, 'D325D4', 10);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (6, 3, 'S432T5', 10);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (7, 4, 'F325D4', 5);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (8, 4, 'D325D4', 4);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (9, 5, 'G432G6', 20);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (10, 5, 'H542F5', 20);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (11, 6, 'А112Т4', 2);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (12, 6, 'G843H5', 2);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (13, 7, 'C346F5', 3);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (14, 7, 'F256G6', 3);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (15, 8, 'F325D4', 1);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (16, 8, 'G432G6', 1);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (17, 9, 'J532V5', 5);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (18, 9, 'F256G6', 1);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (19, 13, 'G843H5', 1);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (21, 14, 'G843H5', 1);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (23, 15, 'S432T5', 2);
INSERT INTO public.order_items (id, order_id, article, quantity) VALUES (28, 18, 'А111A1', 1);


--
-- TOC entry 5135 (class 0 OID 16590)
-- Dependencies: 236
-- Data for Name: order_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_status (id, name) VALUES (1, 'Завершен');
INSERT INTO public.order_status (id, name) VALUES (2, 'Новый ');


--
-- TOC entry 5137 (class 0 OID 16601)
-- Dependencies: 238
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orders (id, order_date, delivery_date, pickup_point_id, user_id, code, order_status_id) VALUES (1, '2024-02-27', '2024-04-20', 1, 10, 901, 1);
INSERT INTO public.orders (id, order_date, delivery_date, pickup_point_id, user_id, code, order_status_id) VALUES (2, '2023-09-28', '2024-04-21', 11, 7, 902, 1);
INSERT INTO public.orders (id, order_date, delivery_date, pickup_point_id, user_id, code, order_status_id) VALUES (3, '2024-03-21', '2024-04-22', 2, 8, 903, 1);
INSERT INTO public.orders (id, order_date, delivery_date, pickup_point_id, user_id, code, order_status_id) VALUES (4, '2024-02-20', '2024-04-23', 11, 9, 904, 1);
INSERT INTO public.orders (id, order_date, delivery_date, pickup_point_id, user_id, code, order_status_id) VALUES (5, '2024-03-17', '2024-04-24', 2, 10, 905, 1);
INSERT INTO public.orders (id, order_date, delivery_date, pickup_point_id, user_id, code, order_status_id) VALUES (6, '2024-03-01', '2024-04-25', 15, 7, 906, 1);
INSERT INTO public.orders (id, order_date, delivery_date, pickup_point_id, user_id, code, order_status_id) VALUES (7, '2024-02-28', '2024-04-26', 3, 8, 907, 1);
INSERT INTO public.orders (id, order_date, delivery_date, pickup_point_id, user_id, code, order_status_id) VALUES (8, '2024-03-31', '2024-04-27', 19, 9, 908, 2);
INSERT INTO public.orders (id, order_date, delivery_date, pickup_point_id, user_id, code, order_status_id) VALUES (9, '2024-04-02', '2024-04-28', 5, 10, 909, 2);
INSERT INTO public.orders (id, order_date, delivery_date, pickup_point_id, user_id, code, order_status_id) VALUES (11, '2026-11-18', '2026-11-20', 2, 3, 910, 2);
INSERT INTO public.orders (id, order_date, delivery_date, pickup_point_id, user_id, code, order_status_id) VALUES (13, '2026-11-19', '2026-11-21', 7, 3, 911, 2);
INSERT INTO public.orders (id, order_date, delivery_date, pickup_point_id, user_id, code, order_status_id) VALUES (14, '2026-11-18', '2026-11-21', 1, 3, 912, 2);
INSERT INTO public.orders (id, order_date, delivery_date, pickup_point_id, user_id, code, order_status_id) VALUES (15, '2026-11-26', '2026-11-28', 31, 2, 913, 2);
INSERT INTO public.orders (id, order_date, delivery_date, pickup_point_id, user_id, code, order_status_id) VALUES (18, '2026-11-21', '2026-11-28', 5, 1, 914, 1);


--
-- TOC entry 5133 (class 0 OID 16579)
-- Dependencies: 234
-- Data for Name: pickups; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (1, '420151', 'г. Лесной', 'ул. Вишневая', '32');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (2, '125061', 'г. Лесной', 'ул. Подгорная', '8');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (3, '630370', 'г. Лесной', 'ул. Шоссейная', '24');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (4, '400562', 'г. Лесной', 'ул. Зеленая', '32');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (5, '614510', 'г. Лесной', 'ул. Маяковского', '47');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (6, '410542', 'г. Лесной', 'ул. Светлая', '46');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (7, '620839', 'г. Лесной', 'ул. Цветочная', '8');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (8, '443890', 'г. Лесной', 'ул. Коммунистическая', '1');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (9, '603379', 'г. Лесной', 'ул. Спортивная', '46');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (10, '603721', 'г. Лесной', 'ул. Гоголя', '41');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (11, '410172', 'г. Лесной', 'ул. Северная', '13');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (12, '614611', 'г. Лесной', 'ул. Молодежная', '50');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (13, '454311', 'г.Лесной', 'ул. Новая', '19');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (14, '660007', 'г.Лесной', 'ул. Октябрьская', '19');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (15, '603036', 'г. Лесной', 'ул. Садовая', '4');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (16, '394060', 'г.Лесной', 'ул. Фрунзе', '43');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (17, '410661', 'г. Лесной', 'ул. Школьная', '50');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (18, '625590', 'г. Лесной', 'ул. Коммунистическая', '20');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (19, '625683', 'г. Лесной', 'ул. 8 Марта', '25');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (20, '450983', 'г.Лесной', 'ул. Комсомольская', '26');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (21, '394782', 'г. Лесной', 'ул. Чехова', '3');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (22, '603002', 'г. Лесной', 'ул. Дзержинского', '28');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (23, '450558', 'г. Лесной', 'ул. Набережная', '30');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (24, '344288', 'г. Лесной', 'ул. Чехова', '1');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (25, '614164', 'г.Лесной', 'ул. Степная', '30');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (26, '394242', 'г. Лесной', 'ул. Коммунистическая', '43');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (27, '660540', 'г. Лесной', 'ул. Солнечная', '25');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (28, '125837', 'г. Лесной', 'ул. Шоссейная', '40');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (29, '125703', 'г. Лесной', 'ул. Партизанская', '49');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (30, '625283', 'г. Лесной', 'ул. Победы', '46');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (31, '614753', 'г. Лесной', 'ул. Полевая', '35');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (32, '426030', 'г. Лесной', 'ул. Маяковского', '44');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (33, '450375', 'г. Лесной ', 'ул. Клубная', '44');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (34, '625560', 'г. Лесной', 'ул. Некрасова', '12');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (35, '630201', 'г. Лесной', 'ул. Комсомольская', '17');
INSERT INTO public.pickups (id, postal_code, city, street, house) VALUES (36, '190949', 'г. Лесной', 'ул. Мичурина', '26');


--
-- TOC entry 5131 (class 0 OID 16533)
-- Dependencies: 232
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (2, 'G843H5', 'Тайны и загадки отца БраунаТайны и загадки отца Брауна', 1, 193.00, 2, 1, 1, 30, 9, 'Гилберт Кит Честертон — признанный классик английской литературы, один из самых ярких писателей первой половины XX века. Классикой стали его романы и многочисленные эссе, однако любовь массового читателя принесли ему рассказы об отце Брауне, тихом, застенчивом священнике, мастерски раскрывающем наиболее запутанные загадки и преступления. ', '2.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (3, 'D325D4', 'Девайс', 1, 1599.00, 3, 2, 1, 5, 12, 'Молодой фрилансер Захар Скаро устраивается на очередную подработку. Задача, казалось бы, тривиальная: тестирование нового устройства. Вот только вопрос в том, тестированием какой реальности занимается этот новый Девайс?', '3.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (4, 'S432T5', 'Необыкновенное обыкновенное чудо. Школьные истории', 1, 549.00, 4, 2, 1, 15, 15, 'Книга про школьные истории', '4.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (5, 'F325D4', 'Чук и Гек', 1, 209.00, 5, 2, 1, 18, 3, 'В книгу вошли повести и рассказы Аркадия Петровича Гайдара: Чук и Гек, Горячий камень и Сказка о военной тайне, о Мальчише-Кибальчише и его твердом слове', '5.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (6, 'G432G6', 'Информационная безопасность. Национальные стандарты Российской Федерации. 3-е издание. Учебное пособие', 1, 3899.00, 6, 3, 2, 22, 3, 'В учебном пособии рассмотрено более 300 действующих открытых документов национальной системы стандартизации Российской Федерации, включая международные и межгосударственные стандарты в области информационной безопасности по состоянию на начало 2023 года.', '6.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (7, 'H542F5', 'Linux. Командная строка. Лучшие практики', 1, 1799.00, 7, 3, 2, 4, 5, 'Перейдите на новый уровень работы в Linux! Если вы системный администратор, разработчик программного обеспечения, SRE-инженер или пользователь Linux, книга поможет вам работать быстрее, элегантнее и эффективнее. ', '7.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (8, 'C346F5', 'Квантовые миры и возникновение пространства-времени', 1, 1349.00, 8, 3, 2, 5, 4, 'Шон Кэрролл — физик-теоретик и один из самых известных в мире популяризаторов науки — заставляет нас по-новому взглянуть на физику. Столкновение с главной загадкой квантовой механики полностью поменяет наши представления о пространстве и времени.', '8.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (9, 'F256G6', 'Вселенная. Происхождение жизни, смысл нашего существования и огромный космос', 1, 1799.00, 8, 3, 2, 6, 2, 'Знаменитый физик Шон Кэрролл в свойственной ему увлекательной манере объясняет принципы, которые лежат в основах научных революций от Дарвина до Эйнштейна, и показывает как невероятные научные открытия последнего столетия изменили наш мир.', '9.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (10, 'J532V5', 'Пушкин. Бродский. Империя и судьба. В 2-х томах (комплект из 2-х книг)', 1, 529.00, 9, 4, 3, 8, 6, 'Первая книга двухтомника «Пушкин. Бродский. Империя и судьба» пронизана пушкинской темой. Пушкин — «певец империи и свободы» — присутствует даже там, где он впрямую не упоминается, ибо его судьба, как и судьба других героев книги, органично связана с трагедией великой империи.', '10.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (11, 'G643F4', 'Иосиф Бродский. Избранные эссе (комплект из 6-ти книг)', 1, 4925.00, 10, 5, 3, 2, 24, 'Шесть сборников избранных эссе Иосифа Бродского (1940-1996), великого поэта, драматурга, мыслителя, лауреата Нобелевской премии по литературе (1987): «Будущее или далекое прошлое», «Верь своей боли», «Как читать книгу», «О русской литературе», «О тирании», «Путеводитель по переименованному городу». Все тексты представлены на английском языке и в переводе на русский и открывают автора не только как поэта, но как историка, критика, и глубокого и ироничного мыслителя.', '11.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (12, 'J326V5', 'Тысячелетие императорской керамикиv', 1, 2599.00, 11, 5, 3, 5, 4, 'Фарфор стал величайшим символом китайской культуры. Это одно из выдающихся изобретений, внесших неоценимый вклад в мировую цивилизацию. ', '12.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (13, 'J632F6', 'Вечные спутники: Портреты из всемирной литературы', 1, 1599.00, 12, 5, 3, 0, 6, 'Книга Вечные спутники - это цикл критических очерков о культуре и великих литераторах, сопровождавших жизнь и творчество русского писателя, поэта, литературного критика и общественного деятеля Дмитрия Мережковского (1865–1941). ', '13.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (1, 'А112Т4', 'Прокляты и убиты', 1, 585.00, 1, 1, 1, 25, 6, 'Роман-эпопею Прокляты и убиты Виктора Астафьева по праву считают одним из самых сильных и пронзительных произведений отечественной военной прозы.', '1.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (14, 'G632H6', 'Формирование литературной репутации Н.Г.Чернышевского в ХIX-XXI веках', 1, 1349.00, 13, 6, 3, 2, 8, 'Монография Д. А. Щербакова - новаторская. Поэтапно рассмотрены не только многочисленные суждения известных отечественных и зарубежных критиков, литературоведов, философов и политиков, различным образом характеризовавших Н. Г. Чернышевского в связи и вне связи со знаменитым романом Что делать? ', '14.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (15, 'G543F5', 'Религиозные верования с древнейших времен до наших дней', 1, 879.00, 13, 7, 3, 4, 6, 'Настоящее издание представляет собой сборник переводов лекций по истории дохристианских и нехристианских религий, прочитанных в Лондоне в период с 1888 по 1891 гг. авторитетными исследователями данного раздела религиоведения. ', '16.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (16, 'M642E5', 'Теория искусства. Краткий путеводитель', 1, 879.00, 14, 6, 3, 3, 2, 'Путеводитель по теории искусства', '15.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (17, 'B653G6', 'Русский язык: Первые шаги. Часть 3. Учебное пособие', 1, 2699.00, 15, 8, 4, 8, 9, 'Пособие является завершающей частью учебного комплекса. Третья часть содержит 10 уроков (21-30, последний-повторительный). Усвоение лексико-грамматического материала рассчитано примерно на 200-240 часов аудиторных занятий. ', '17.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (18, 'J735J7', 'Синтетический образ индивидуального психического мира', 1, 1099.00, 16, 8, 3, 9, 4, 'Психика подобна определенным объектам, это фиксируют сами люди в языке и искусстве. В данном исследовании рассматриваются в этом плане образы сосуда, воронки, дерева и крепости.', '18.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (19, 'H436H7', 'Английский язык в спорте: Учебное пособие', 1, 1999.00, 17, 9, 4, 2, 0, 'Учебное пособие подготовлено для слушателей, изу чающих английский язык как язык специальности', '19.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (20, 'H475R5', 'Лексика и грамматика современного китайского языка (к тому II учебника «Новый практический курс китайского языка» под редакцией Лю Сюня): учебное пособие', 1, 600.00, 18, 10, 4, 25, 10, 'Пособие выступает дополнением ко второму тому учебника «Новый практический курс китайского языка» (под редакцией Лю Сюня). ', '20.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, supplier_id, manufacturer_id, category_id, sale, quantity, description, photo) VALUES (32, 'А111A1', 'мертвые души', 1, 1500.00, 3, 2, 1, 30, 20, 'что то там про души', 'b3b13fc3-e8df-4364-9c55-2393891d6e05.jpg');


--
-- TOC entry 5121 (class 0 OID 16470)
-- Dependencies: 222
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles (id, name) VALUES (1, 'Администратор');
INSERT INTO public.roles (id, name) VALUES (2, 'Менеджер');
INSERT INTO public.roles (id, name) VALUES (3, 'Авторизированный клиент');


--
-- TOC entry 5129 (class 0 OID 16522)
-- Dependencies: 230
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.suppliers (id, name) VALUES (1, 'Виктор Астафьев');
INSERT INTO public.suppliers (id, name) VALUES (2, 'Гилберт Кит Честертон');
INSERT INTO public.suppliers (id, name) VALUES (3, 'Кирилл Каланджи');
INSERT INTO public.suppliers (id, name) VALUES (4, 'Людмила Улицкая');
INSERT INTO public.suppliers (id, name) VALUES (5, 'Аркадий Гайдар');
INSERT INTO public.suppliers (id, name) VALUES (6, 'Юрий Родичев');
INSERT INTO public.suppliers (id, name) VALUES (7, 'Дэниел Джей Барретт');
INSERT INTO public.suppliers (id, name) VALUES (8, 'Шон Кэрролл');
INSERT INTO public.suppliers (id, name) VALUES (9, 'Яков Гордин');
INSERT INTO public.suppliers (id, name) VALUES (10, 'Иосиф Бродский');
INSERT INTO public.suppliers (id, name) VALUES (11, 'Янь Чуннянь');
INSERT INTO public.suppliers (id, name) VALUES (12, 'Дмитрий Мережковский');
INSERT INTO public.suppliers (id, name) VALUES (13, 'Дмитрий Щербаков');
INSERT INTO public.suppliers (id, name) VALUES (14, 'Роджер Осборн, Дэн Стерджис');
INSERT INTO public.suppliers (id, name) VALUES (15, 'Любовь Беликова, Инна Ерофеева, Татьяна Шутова');
INSERT INTO public.suppliers (id, name) VALUES (16, 'Сергей Моргачев');
INSERT INTO public.suppliers (id, name) VALUES (17, 'Екатерина Габарта, Ирина Игнатьева');
INSERT INTO public.suppliers (id, name) VALUES (18, 'Татьяна Лопаткина, Софья Маннапова');


--
-- TOC entry 5119 (class 0 OID 16395)
-- Dependencies: 220
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.units (id, name) VALUES (1, 'шт.');


--
-- TOC entry 5123 (class 0 OID 16481)
-- Dependencies: 224
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, role_id, fio, login, password) VALUES (1, 1, 'Никифорова Анна Семеновна', '94d5ous@gmail.com', 'uzWC67');
INSERT INTO public.users (id, role_id, fio, login, password) VALUES (2, 1, 'Стелина Евгения Петровна', 'uth4iz@mail.com', '2L6KZG');
INSERT INTO public.users (id, role_id, fio, login, password) VALUES (3, 1, 'Михайлюк Анна Вячеславовна', '5d4zbu@tutanota.com', 'rwVDh9');
INSERT INTO public.users (id, role_id, fio, login, password) VALUES (4, 2, 'Ситдикова Елена Анатольевна', 'ptec8ym@yahoo.com', 'LdNyos');
INSERT INTO public.users (id, role_id, fio, login, password) VALUES (5, 2, 'Ворсин Петр Евгеньевич', '1qz4kw@mail.com', 'gynQMT');
INSERT INTO public.users (id, role_id, fio, login, password) VALUES (6, 2, 'Старикова Елена Павловна', '4np6se@mail.com', 'AtnDjr');
INSERT INTO public.users (id, role_id, fio, login, password) VALUES (7, 3, 'Никифорова Весения Николаевна', 'yzls62@outlook.com', 'JlFRCZ');
INSERT INTO public.users (id, role_id, fio, login, password) VALUES (8, 3, 'Сазонов Руслан Германович', '1diph5e@tutanota.com', '8ntwUp');
INSERT INTO public.users (id, role_id, fio, login, password) VALUES (9, 3, 'Одинцов Серафим Артёмович', 'tjde7c@yahoo.com', 'YOyhfR');
INSERT INTO public.users (id, role_id, fio, login, password) VALUES (10, 3, 'Степанов Михаил Артёмович', 'wpmrc3do@tutanota.com', 'RSbvHv');


--
-- TOC entry 5156 (class 0 OID 0)
-- Dependencies: 225
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- TOC entry 5157 (class 0 OID 0)
-- Dependencies: 227
-- Name: manufacturers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manufacturers_id_seq', 1, false);


--
-- TOC entry 5158 (class 0 OID 0)
-- Dependencies: 239
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 28, true);


--
-- TOC entry 5159 (class 0 OID 0)
-- Dependencies: 235
-- Name: order_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_status_id_seq', 1, false);


--
-- TOC entry 5160 (class 0 OID 0)
-- Dependencies: 237
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 18, true);


--
-- TOC entry 5161 (class 0 OID 0)
-- Dependencies: 233
-- Name: pickups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pickups_id_seq', 1, false);


--
-- TOC entry 5162 (class 0 OID 0)
-- Dependencies: 231
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 33, true);


--
-- TOC entry 5163 (class 0 OID 0)
-- Dependencies: 221
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- TOC entry 5164 (class 0 OID 0)
-- Dependencies: 229
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 1, false);


--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 219
-- Name: units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.units_id_seq', 1, false);


--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 223
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- TOC entry 4936 (class 2606 OID 16509)
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- TOC entry 4938 (class 2606 OID 16507)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4940 (class 2606 OID 16520)
-- Name: manufacturers manufacturers_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT manufacturers_name_key UNIQUE (name);


--
-- TOC entry 4942 (class 2606 OID 16518)
-- Name: manufacturers manufacturers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT manufacturers_pkey PRIMARY KEY (id);


--
-- TOC entry 4960 (class 2606 OID 16640)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4954 (class 2606 OID 16599)
-- Name: order_status order_status_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status
    ADD CONSTRAINT order_status_name_key UNIQUE (name);


--
-- TOC entry 4956 (class 2606 OID 16597)
-- Name: order_status order_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status
    ADD CONSTRAINT order_status_pkey PRIMARY KEY (id);


--
-- TOC entry 4958 (class 2606 OID 16613)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4952 (class 2606 OID 16588)
-- Name: pickups pickups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickups
    ADD CONSTRAINT pickups_pkey PRIMARY KEY (id);


--
-- TOC entry 4948 (class 2606 OID 16557)
-- Name: products products_article_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_article_key UNIQUE (article);


--
-- TOC entry 4950 (class 2606 OID 16555)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 4928 (class 2606 OID 16479)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 4930 (class 2606 OID 16477)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4944 (class 2606 OID 16531)
-- Name: suppliers suppliers_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_name_key UNIQUE (name);


--
-- TOC entry 4946 (class 2606 OID 16529)
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- TOC entry 4924 (class 2606 OID 16404)
-- Name: units units_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_name_key UNIQUE (name);


--
-- TOC entry 4926 (class 2606 OID 16402)
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- TOC entry 4932 (class 2606 OID 16493)
-- Name: users users_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);


--
-- TOC entry 4934 (class 2606 OID 16491)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4969 (class 2606 OID 16646)
-- Name: order_items order_items_article_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_article_fkey FOREIGN KEY (article) REFERENCES public.products(article) ON DELETE RESTRICT;


--
-- TOC entry 4970 (class 2606 OID 16641)
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- TOC entry 4966 (class 2606 OID 16624)
-- Name: orders orders_order_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_order_status_id_fkey FOREIGN KEY (order_status_id) REFERENCES public.order_status(id) ON DELETE RESTRICT;


--
-- TOC entry 4967 (class 2606 OID 16614)
-- Name: orders orders_pickup_point_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pickup_point_id_fkey FOREIGN KEY (pickup_point_id) REFERENCES public.pickups(id) ON DELETE RESTRICT;


--
-- TOC entry 4968 (class 2606 OID 16619)
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- TOC entry 4962 (class 2606 OID 16573)
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE RESTRICT;


--
-- TOC entry 4963 (class 2606 OID 16568)
-- Name: products products_manufacturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturers(id) ON DELETE RESTRICT;


--
-- TOC entry 4964 (class 2606 OID 16563)
-- Name: products products_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id) ON DELETE RESTRICT;


--
-- TOC entry 4965 (class 2606 OID 16558)
-- Name: products products_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE RESTRICT;


--
-- TOC entry 4961 (class 2606 OID 16494)
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE RESTRICT;


-- Completed on 2026-11-19 17:22:09

--
-- PostgreSQL database dump complete
--

\unrestrict Uihxkyr3T9c8QBWeoRtinCCgcVXpH6fJFQTVRJ4Ogx5rdlPiv3idPTFBx4Nm0Ug

