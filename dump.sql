--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

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
-- Name: products; Type: TABLE; Schema: public; Owner: amosmurmu
--

CREATE TABLE public.products (
    id integer NOT NULL,
    request_id uuid,
    product_name character varying(255),
    input_images text[],
    output_images text[]
);


ALTER TABLE public.products OWNER TO amosmurmu;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: amosmurmu
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO amosmurmu;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: amosmurmu
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: requests; Type: TABLE; Schema: public; Owner: amosmurmu
--

CREATE TABLE public.requests (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    status character varying(20),
    created_at timestamp without time zone DEFAULT now(),
    file_hash text,
    file_path text,
    CONSTRAINT requests_status_check CHECK (((status)::text = ANY ((ARRAY['PENDING'::character varying, 'PROCESSING'::character varying, 'PROCESSED'::character varying, 'FAILED'::character varying])::text[])))
);


ALTER TABLE public.requests OWNER TO amosmurmu;

--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: amosmurmu
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: amosmurmu
--

COPY public.products (id, request_id, product_name, input_images, output_images) FROM stdin;
1	f3551e37-a4ff-4677-97c6-5376ca926f87	Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops	{https://picsum.photos/200/300?random=180,https://picsum.photos/200/300?random=839,https://picsum.photos/200/300?random=402,https://picsum.photos/200/300?random=12}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743168981/compressed_images/compressed-1743168980688.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743168984/compressed_images/compressed-1743168983631.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743168988/compressed_images/compressed-1743168986781.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743168990/compressed_images/compressed-1743168989500.jpg}
2	f3551e37-a4ff-4677-97c6-5376ca926f87	Mens Casual Premium Slim Fit T-Shirts	{https://picsum.photos/200/300?random=486,https://picsum.photos/200/300?random=289,https://picsum.photos/200/300?random=146,https://picsum.photos/200/300?random=970}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743168993/compressed_images/compressed-1743168992351.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743168996/compressed_images/compressed-1743168995590.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743168999/compressed_images/compressed-1743168998720.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169002/compressed_images/compressed-1743169001604.jpg}
3	f3551e37-a4ff-4677-97c6-5376ca926f87	Mens Cotton Jacket	{https://picsum.photos/200/300?random=63,https://picsum.photos/200/300?random=177,https://picsum.photos/200/300?random=413,https://picsum.photos/200/300?random=148}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169006/compressed_images/compressed-1743169004765.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169009/compressed_images/compressed-1743169007901.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169012/compressed_images/compressed-1743169011412.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169015/compressed_images/compressed-1743169014514.jpg}
4	f3551e37-a4ff-4677-97c6-5376ca926f87	Mens Casual Slim Fit	{https://picsum.photos/200/300?random=131,https://picsum.photos/200/300?random=649,https://picsum.photos/200/300?random=205,https://picsum.photos/200/300?random=956}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169018/compressed_images/compressed-1743169017844.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169021/compressed_images/compressed-1743169020699.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169025/compressed_images/compressed-1743169023939.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169028/compressed_images/compressed-1743169026924.jpg}
5	f3551e37-a4ff-4677-97c6-5376ca926f87	John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet	{https://picsum.photos/200/300?random=276,https://picsum.photos/200/300?random=184,https://picsum.photos/200/300?random=493,https://picsum.photos/200/300?random=355}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169030/compressed_images/compressed-1743169029444.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169033/compressed_images/compressed-1743169032475.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169036/compressed_images/compressed-1743169035291.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169039/compressed_images/compressed-1743169038565.jpg}
6	f3551e37-a4ff-4677-97c6-5376ca926f87	Solid Gold Petite Micropave	{https://picsum.photos/200/300?random=37,https://picsum.photos/200/300?random=458,https://picsum.photos/200/300?random=737,https://picsum.photos/200/300?random=723}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169042/compressed_images/compressed-1743169041569.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169046/compressed_images/compressed-1743169044805.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169049/compressed_images/compressed-1743169047989.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169052/compressed_images/compressed-1743169051080.jpg}
7	f3551e37-a4ff-4677-97c6-5376ca926f87	White Gold Plated Princess	{https://picsum.photos/200/300?random=214,https://picsum.photos/200/300?random=805,https://picsum.photos/200/300?random=409,https://picsum.photos/200/300?random=754}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169056/compressed_images/compressed-1743169054165.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169059/compressed_images/compressed-1743169058634.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169062/compressed_images/compressed-1743169061774.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169066/compressed_images/compressed-1743169065357.jpg}
8	f3551e37-a4ff-4677-97c6-5376ca926f87	Pierced Owl Rose Gold Plated Stainless Steel Double	{https://picsum.photos/200/300?random=207,https://picsum.photos/200/300?random=178,https://picsum.photos/200/300?random=168,https://picsum.photos/200/300?random=258}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169069/compressed_images/compressed-1743169068436.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169072/compressed_images/compressed-1743169071586.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169075/compressed_images/compressed-1743169074651.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169078/compressed_images/compressed-1743169077520.jpg}
9	f3551e37-a4ff-4677-97c6-5376ca926f87	WD 2TB Elements Portable External Hard Drive - USB 3.0	{https://picsum.photos/200/300?random=612,https://picsum.photos/200/300?random=16,https://picsum.photos/200/300?random=947,https://picsum.photos/200/300?random=612}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169081/compressed_images/compressed-1743169080591.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169085/compressed_images/compressed-1743169084048.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169087/compressed_images/compressed-1743169086779.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169090/compressed_images/compressed-1743169089365.jpg}
10	f3551e37-a4ff-4677-97c6-5376ca926f87	SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s	{https://picsum.photos/200/300?random=971,https://picsum.photos/200/300?random=429,https://picsum.photos/200/300?random=246,https://picsum.photos/200/300?random=321}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169093/compressed_images/compressed-1743169092441.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169097/compressed_images/compressed-1743169095796.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169100/compressed_images/compressed-1743169098905.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169103/compressed_images/compressed-1743169102134.jpg}
11	f3551e37-a4ff-4677-97c6-5376ca926f87	Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5	{https://picsum.photos/200/300?random=315,https://picsum.photos/200/300?random=152,https://picsum.photos/200/300?random=259,https://picsum.photos/200/300?random=909}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169105/compressed_images/compressed-1743169105001.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169108/compressed_images/compressed-1743169107728.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169112/compressed_images/compressed-1743169110935.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169120/compressed_images/compressed-1743169119015.jpg}
12	f3551e37-a4ff-4677-97c6-5376ca926f87	WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive	{https://picsum.photos/200/300?random=743,https://picsum.photos/200/300?random=538,https://picsum.photos/200/300?random=26,https://picsum.photos/200/300?random=574}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169123/compressed_images/compressed-1743169121771.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169125/compressed_images/compressed-1743169124925.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169128/compressed_images/compressed-1743169127843.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169132/compressed_images/compressed-1743169130815.jpg}
13	f3551e37-a4ff-4677-97c6-5376ca926f87	Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin	{https://picsum.photos/200/300?random=57,https://picsum.photos/200/300?random=606,https://picsum.photos/200/300?random=469,https://picsum.photos/200/300?random=627}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169135/compressed_images/compressed-1743169133950.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169138/compressed_images/compressed-1743169136919.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169141/compressed_images/compressed-1743169140075.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169144/compressed_images/compressed-1743169143119.jpg}
14	f3551e37-a4ff-4677-97c6-5376ca926f87	Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor (LC49HG90DMNXZA) – Super Ultrawide Screen QLED	{https://picsum.photos/200/300?random=466,https://picsum.photos/200/300?random=645,https://picsum.photos/200/300?random=594,https://picsum.photos/200/300?random=947}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169147/compressed_images/compressed-1743169146257.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169150/compressed_images/compressed-1743169149125.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169153/compressed_images/compressed-1743169152247.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169156/compressed_images/compressed-1743169155299.jpg}
15	f3551e37-a4ff-4677-97c6-5376ca926f87	BIYLACLESEN Women's 3-in-1 Snowboard Jacket Winter Coats	{https://picsum.photos/200/300?random=938,https://picsum.photos/200/300?random=687,https://picsum.photos/200/300?random=879,https://picsum.photos/200/300?random=64}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169159/compressed_images/compressed-1743169158388.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169162/compressed_images/compressed-1743169161379.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169165/compressed_images/compressed-1743169164449.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169168/compressed_images/compressed-1743169167066.jpg}
16	f3551e37-a4ff-4677-97c6-5376ca926f87	Lock and Love Women's Removable Hooded Faux Leather Moto Biker Jacket	{https://picsum.photos/200/300?random=624,https://picsum.photos/200/300?random=809,https://picsum.photos/200/300?random=937,https://picsum.photos/200/300?random=139}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169171/compressed_images/compressed-1743169169805.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169174/compressed_images/compressed-1743169172932.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169177/compressed_images/compressed-1743169176147.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169180/compressed_images/compressed-1743169179156.jpg}
17	f3551e37-a4ff-4677-97c6-5376ca926f87	Rain Jacket Women Windbreaker Striped Climbing Raincoats	{https://picsum.photos/200/300?random=653,https://picsum.photos/200/300?random=237,https://picsum.photos/200/300?random=869,https://picsum.photos/200/300?random=961}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169183/compressed_images/compressed-1743169182156.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169185/compressed_images/compressed-1743169184979.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169188/compressed_images/compressed-1743169187889.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169191/compressed_images/compressed-1743169190707.jpg}
18	f3551e37-a4ff-4677-97c6-5376ca926f87	MBJ Women's Solid Short Sleeve Boat Neck V	{https://picsum.photos/200/300?random=872,https://picsum.photos/200/300?random=857,https://picsum.photos/200/300?random=64,https://picsum.photos/200/300?random=845}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169195/compressed_images/compressed-1743169193843.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169198/compressed_images/compressed-1743169197123.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169201/compressed_images/compressed-1743169199965.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169204/compressed_images/compressed-1743169203135.jpg}
19	f3551e37-a4ff-4677-97c6-5376ca926f87	Opna Women's Short Sleeve Moisture	{https://picsum.photos/200/300?random=798,https://picsum.photos/200/300?random=45,https://picsum.photos/200/300?random=642,https://picsum.photos/200/300?random=744}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169207/compressed_images/compressed-1743169206166.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169210/compressed_images/compressed-1743169209340.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169213/compressed_images/compressed-1743169212510.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169216/compressed_images/compressed-1743169215715.jpg}
20	f3551e37-a4ff-4677-97c6-5376ca926f87	DANVOUY Womens T Shirt Casual Cotton Short	{https://picsum.photos/200/300?random=911,https://picsum.photos/200/300?random=41,https://picsum.photos/200/300?random=81,https://picsum.photos/200/300?random=502}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743169219/compressed_images/compressed-1743169218776.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169223/compressed_images/compressed-1743169221892.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169226/compressed_images/compressed-1743169225190.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743169229/compressed_images/compressed-1743169227896.jpg}
21	a57eb123-a589-47a5-b20d-05599b44ea2a	Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops	{https://picsum.photos/200/300?random=728,https://picsum.photos/200/300?random=80,https://picsum.photos/200/300?random=889,https://picsum.photos/200/300?random=4}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174163/compressed_images/compressed-1743174161286.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174166/compressed_images/compressed-1743174165513.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174170/compressed_images/compressed-1743174169198.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174173/compressed_images/compressed-1743174172462.jpg}
22	a57eb123-a589-47a5-b20d-05599b44ea2a	Mens Casual Premium Slim Fit T-Shirts	{https://picsum.photos/200/300?random=422,https://picsum.photos/200/300?random=840,https://picsum.photos/200/300?random=900,https://picsum.photos/200/300?random=987}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174176/compressed_images/compressed-1743174175666.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174180/compressed_images/compressed-1743174179215.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174183/compressed_images/compressed-1743174182318.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174188/compressed_images/compressed-1743174185743.jpg}
23	a57eb123-a589-47a5-b20d-05599b44ea2a	Mens Cotton Jacket	{https://picsum.photos/200/300?random=129,https://picsum.photos/200/300?random=1000,https://picsum.photos/200/300?random=699,https://picsum.photos/200/300?random=571}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174191/compressed_images/compressed-1743174190398.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174195/compressed_images/compressed-1743174193960.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174197/compressed_images/compressed-1743174196886.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174201/compressed_images/compressed-1743174200046.jpg}
24	a57eb123-a589-47a5-b20d-05599b44ea2a	Mens Casual Slim Fit	{https://picsum.photos/200/300?random=859,https://picsum.photos/200/300?random=170,https://picsum.photos/200/300?random=667,https://picsum.photos/200/300?random=175}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174204/compressed_images/compressed-1743174203092.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174207/compressed_images/compressed-1743174206477.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174211/compressed_images/compressed-1743174209745.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174214/compressed_images/compressed-1743174213269.jpg}
25	a57eb123-a589-47a5-b20d-05599b44ea2a	John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet	{https://picsum.photos/200/300?random=965,https://picsum.photos/200/300?random=127,https://picsum.photos/200/300?random=865,https://picsum.photos/200/300?random=770}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174217/compressed_images/compressed-1743174216540.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174221/compressed_images/compressed-1743174220005.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174225/compressed_images/compressed-1743174224059.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174228/compressed_images/compressed-1743174227558.jpg}
26	a57eb123-a589-47a5-b20d-05599b44ea2a	Solid Gold Petite Micropave	{https://picsum.photos/200/300?random=190,https://picsum.photos/200/300?random=260,https://picsum.photos/200/300?random=528,https://picsum.photos/200/300?random=202}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174231/compressed_images/compressed-1743174230400.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174235/compressed_images/compressed-1743174233756.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174238/compressed_images/compressed-1743174237739.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174242/compressed_images/compressed-1743174241003.jpg}
27	a57eb123-a589-47a5-b20d-05599b44ea2a	White Gold Plated Princess	{https://picsum.photos/200/300?random=765,https://picsum.photos/200/300?random=481,https://picsum.photos/200/300?random=303,https://picsum.photos/200/300?random=937}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174250/compressed_images/compressed-1743174249355.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174253/compressed_images/compressed-1743174252462.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174257/compressed_images/compressed-1743174256236.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174261/compressed_images/compressed-1743174259566.jpg}
28	a57eb123-a589-47a5-b20d-05599b44ea2a	Pierced Owl Rose Gold Plated Stainless Steel Double	{https://picsum.photos/200/300?random=998,https://picsum.photos/200/300?random=875,https://picsum.photos/200/300?random=263,https://picsum.photos/200/300?random=478}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174265/compressed_images/compressed-1743174264116.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174268/compressed_images/compressed-1743174267463.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174272/compressed_images/compressed-1743174271520.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174276/compressed_images/compressed-1743174274851.jpg}
29	a57eb123-a589-47a5-b20d-05599b44ea2a	WD 2TB Elements Portable External Hard Drive - USB 3.0	{https://picsum.photos/200/300?random=689,https://picsum.photos/200/300?random=856,https://picsum.photos/200/300?random=590,https://picsum.photos/200/300?random=49}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174280/compressed_images/compressed-1743174279016.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174282/compressed_images/compressed-1743174281878.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174286/compressed_images/compressed-1743174285018.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174290/compressed_images/compressed-1743174288295.jpg}
30	a57eb123-a589-47a5-b20d-05599b44ea2a	SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s	{https://picsum.photos/200/300?random=187,https://picsum.photos/200/300?random=5,https://picsum.photos/200/300?random=924,https://picsum.photos/200/300?random=915}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174293/compressed_images/compressed-1743174292926.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174296/compressed_images/compressed-1743174295777.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174299/compressed_images/compressed-1743174298661.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174303/compressed_images/compressed-1743174301925.jpg}
31	a57eb123-a589-47a5-b20d-05599b44ea2a	Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5	{https://picsum.photos/200/300?random=194,https://picsum.photos/200/300?random=629,https://picsum.photos/200/300?random=656,https://picsum.photos/200/300?random=405}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174306/compressed_images/compressed-1743174305172.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174309/compressed_images/compressed-1743174308141.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174313/compressed_images/compressed-1743174311663.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174316/compressed_images/compressed-1743174315948.jpg}
32	a57eb123-a589-47a5-b20d-05599b44ea2a	WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive	{https://picsum.photos/200/300?random=125,https://picsum.photos/200/300?random=202,https://picsum.photos/200/300?random=209,https://picsum.photos/200/300?random=892}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174319/compressed_images/compressed-1743174318856.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174323/compressed_images/compressed-1743174322036.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174326/compressed_images/compressed-1743174325506.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174330/compressed_images/compressed-1743174328692.jpg}
33	a57eb123-a589-47a5-b20d-05599b44ea2a	Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin	{https://picsum.photos/200/300?random=365,https://picsum.photos/200/300?random=360,https://picsum.photos/200/300?random=907,https://picsum.photos/200/300?random=7}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174333/compressed_images/compressed-1743174332141.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174337/compressed_images/compressed-1743174335986.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174341/compressed_images/compressed-1743174340077.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174344/compressed_images/compressed-1743174343246.jpg}
34	a57eb123-a589-47a5-b20d-05599b44ea2a	Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor (LC49HG90DMNXZA) – Super Ultrawide Screen QLED	{https://picsum.photos/200/300?random=417,https://picsum.photos/200/300?random=821,https://picsum.photos/200/300?random=196,https://picsum.photos/200/300?random=625}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174348/compressed_images/compressed-1743174346950.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174351/compressed_images/compressed-1743174350358.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174355/compressed_images/compressed-1743174354161.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174359/compressed_images/compressed-1743174357757.jpg}
35	a57eb123-a589-47a5-b20d-05599b44ea2a	BIYLACLESEN Women's 3-in-1 Snowboard Jacket Winter Coats	{https://picsum.photos/200/300?random=948,https://picsum.photos/200/300?random=842,https://picsum.photos/200/300?random=165,https://picsum.photos/200/300?random=579}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174362/compressed_images/compressed-1743174361506.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174365/compressed_images/compressed-1743174364776.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174369/compressed_images/compressed-1743174367998.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174372/compressed_images/compressed-1743174371112.jpg}
36	a57eb123-a589-47a5-b20d-05599b44ea2a	Lock and Love Women's Removable Hooded Faux Leather Moto Biker Jacket	{https://picsum.photos/200/300?random=39,https://picsum.photos/200/300?random=658,https://picsum.photos/200/300?random=565,https://picsum.photos/200/300?random=767}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174376/compressed_images/compressed-1743174375024.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174379/compressed_images/compressed-1743174378280.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174382/compressed_images/compressed-1743174381186.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174385/compressed_images/compressed-1743174384076.jpg}
37	a57eb123-a589-47a5-b20d-05599b44ea2a	Rain Jacket Women Windbreaker Striped Climbing Raincoats	{https://picsum.photos/200/300?random=803,https://picsum.photos/200/300?random=590,https://picsum.photos/200/300?random=637,https://picsum.photos/200/300?random=737}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174389/compressed_images/compressed-1743174388224.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174392/compressed_images/compressed-1743174391178.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174395/compressed_images/compressed-1743174394427.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174398/compressed_images/compressed-1743174397594.jpg}
38	a57eb123-a589-47a5-b20d-05599b44ea2a	MBJ Women's Solid Short Sleeve Boat Neck V	{https://picsum.photos/200/300?random=626,https://picsum.photos/200/300?random=55,https://picsum.photos/200/300?random=94,https://picsum.photos/200/300?random=647}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174401/compressed_images/compressed-1743174400581.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174405/compressed_images/compressed-1743174403887.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174408/compressed_images/compressed-1743174407367.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174411/compressed_images/compressed-1743174410635.jpg}
39	a57eb123-a589-47a5-b20d-05599b44ea2a	Opna Women's Short Sleeve Moisture	{https://picsum.photos/200/300?random=88,https://picsum.photos/200/300?random=167,https://picsum.photos/200/300?random=79,https://picsum.photos/200/300?random=285}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174415/compressed_images/compressed-1743174414124.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174418/compressed_images/compressed-1743174417586.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174421/compressed_images/compressed-1743174420587.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174428/compressed_images/compressed-1743174427775.jpg}
40	a57eb123-a589-47a5-b20d-05599b44ea2a	DANVOUY Womens T Shirt Casual Cotton Short	{https://picsum.photos/200/300?random=192,https://picsum.photos/200/300?random=671,https://picsum.photos/200/300?random=409,https://picsum.photos/200/300?random=158}	{https://res.cloudinary.com/dkrxzalni/image/upload/v1743174432/compressed_images/compressed-1743174430847.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174435/compressed_images/compressed-1743174434232.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174438/compressed_images/compressed-1743174437371.jpg,https://res.cloudinary.com/dkrxzalni/image/upload/v1743174442/compressed_images/compressed-1743174440912.jpg}
\.


--
-- Data for Name: requests; Type: TABLE DATA; Schema: public; Owner: amosmurmu
--

COPY public.requests (id, status, created_at, file_hash, file_path) FROM stdin;
f3551e37-a4ff-4677-97c6-5376ca926f87	PROCESSED	2025-03-28 19:06:19.24649	45b407262a85849976256cd0381bf0818aa043fe38014d54e976ac67987c7acb	uploads/2347b6eccf2fed687aded1a4a5b46269
a57eb123-a589-47a5-b20d-05599b44ea2a	PROCESSED	2025-03-28 20:32:39.671949	ed127816ad976fc8ff87eab107e4f856cde74fd4f5e4a6e92beb74e71affc35a	uploads/d846c94e14daf43264ed916ee36eb640
\.


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: amosmurmu
--

SELECT pg_catalog.setval('public.products_id_seq', 40, true);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: amosmurmu
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: requests requests_file_hash_key; Type: CONSTRAINT; Schema: public; Owner: amosmurmu
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_file_hash_key UNIQUE (file_hash);


--
-- Name: requests requests_pkey; Type: CONSTRAINT; Schema: public; Owner: amosmurmu
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);


--
-- Name: products products_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: amosmurmu
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_request_id_fkey FOREIGN KEY (request_id) REFERENCES public.requests(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

