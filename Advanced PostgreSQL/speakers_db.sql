--
-- PostgreSQL database dump
--

--
-- Name: cc_user; Type: SCHEMA; Schema: -; Owner: -
--


DROP SCHEMA IF EXISTS cc_user CASCADE;
CREATE SCHEMA cc_user;
SET search_path = cc_user;

--
-- Name: speakers; Type: TABLE; Schema: cc_user; Owner: -
--

CREATE TABLE cc_user.speakers (
    id integer,
    email character varying,
    name character varying,
    organization character varying,
    title character varying,
    years_in_role integer
);


\copy cc_user.speakers FROM 'speakers.csv' delimiter ',' NULL AS 'NULL' csv header
