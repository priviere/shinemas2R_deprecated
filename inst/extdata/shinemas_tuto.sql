--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: actors_location; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE actors_location (
    id integer NOT NULL,
    location_name character varying(100),
    location_type character varying(100),
    address character varying(200),
    post_code character varying(200),
    country character varying(100),
    longitude character varying(50),
    latitude character varying(50),
    altitude character varying(50)
);


ALTER TABLE actors_location OWNER TO bioinfo;

--
-- Name: actors_location_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE actors_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE actors_location_id_seq OWNER TO bioinfo;

--
-- Name: actors_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE actors_location_id_seq OWNED BY actors_location.id;


--
-- Name: actors_person; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE actors_person (
    id integer NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    short_name character varying(50) NOT NULL,
    gender character varying(20),
    email character varying(75),
    phone1 character varying(200),
    phone2 character varying(200),
    fax character varying(200),
    location_id integer,
    birth_date date
);


ALTER TABLE actors_person OWNER TO bioinfo;

--
-- Name: actors_person_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE actors_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE actors_person_id_seq OWNER TO bioinfo;

--
-- Name: actors_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE actors_person_id_seq OWNED BY actors_person.id;


--
-- Name: actors_project; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE actors_project (
    id integer NOT NULL,
    project_name character varying(50) NOT NULL,
    start_date date NOT NULL,
    end_date date
);


ALTER TABLE actors_project OWNER TO bioinfo;

--
-- Name: actors_project_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE actors_project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE actors_project_id_seq OWNER TO bioinfo;

--
-- Name: actors_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE actors_project_id_seq OWNED BY actors_project.id;


--
-- Name: actors_project_person; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE actors_project_person (
    id integer NOT NULL,
    project_id integer NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE actors_project_person OWNER TO bioinfo;

--
-- Name: actors_project_person_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE actors_project_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE actors_project_person_id_seq OWNER TO bioinfo;

--
-- Name: actors_project_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE actors_project_person_id_seq OWNED BY actors_project_person.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO bioinfo;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO bioinfo;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO bioinfo;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO bioinfo;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO bioinfo;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO bioinfo;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE auth_user OWNER TO bioinfo;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE auth_user_groups OWNER TO bioinfo;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_groups_id_seq OWNER TO bioinfo;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_id_seq OWNER TO bioinfo;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_user_user_permissions OWNER TO bioinfo;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_user_permissions_id_seq OWNER TO bioinfo;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO bioinfo;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO bioinfo;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO bioinfo;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO bioinfo;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO bioinfo;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO bioinfo;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO bioinfo;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE django_site OWNER TO bioinfo;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_site_id_seq OWNER TO bioinfo;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: entities_germplasm; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE entities_germplasm (
    id integer NOT NULL,
    germplasm_name character varying(100) NOT NULL,
    germplasm_type_id integer,
    person_id integer,
    species_id integer
);


ALTER TABLE entities_germplasm OWNER TO bioinfo;

--
-- Name: entities_germplasm_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE entities_germplasm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entities_germplasm_id_seq OWNER TO bioinfo;

--
-- Name: entities_germplasm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE entities_germplasm_id_seq OWNED BY entities_germplasm.id;


--
-- Name: entities_germplasm_type; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE entities_germplasm_type (
    id integer NOT NULL,
    germplasm_type character varying(200),
    description character varying(200)
);


ALTER TABLE entities_germplasm_type OWNER TO bioinfo;

--
-- Name: entities_germplasm_type_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE entities_germplasm_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entities_germplasm_type_id_seq OWNER TO bioinfo;

--
-- Name: entities_germplasm_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE entities_germplasm_type_id_seq OWNED BY entities_germplasm_type.id;


--
-- Name: entities_seed_lot; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE entities_seed_lot (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    quantity_ini character varying(100),
    date integer,
    germplasm_id integer NOT NULL,
    person_id integer NOT NULL,
    comments text,
    confidence boolean NOT NULL,
    generation integer NOT NULL,
    onfarm_confidence boolean NOT NULL,
    onfarm_generation integer NOT NULL
);


ALTER TABLE entities_seed_lot OWNER TO bioinfo;

--
-- Name: entities_seed_lot_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE entities_seed_lot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entities_seed_lot_id_seq OWNER TO bioinfo;

--
-- Name: entities_seed_lot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE entities_seed_lot_id_seq OWNED BY entities_seed_lot.id;


--
-- Name: entities_species; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE entities_species (
    id integer NOT NULL,
    species character varying(100) NOT NULL,
    latin_name character varying(100),
    description text
);


ALTER TABLE entities_species OWNER TO bioinfo;

--
-- Name: entities_species_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE entities_species_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entities_species_id_seq OWNER TO bioinfo;

--
-- Name: entities_species_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE entities_species_id_seq OWNED BY entities_species.id;


--
-- Name: eppdata_classe; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE eppdata_classe (
    id integer NOT NULL,
    classe_name character varying(100),
    modality_nb character varying(100),
    classe_description character varying(100)
);


ALTER TABLE eppdata_classe OWNER TO bioinfo;

--
-- Name: eppdata_classe_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE eppdata_classe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eppdata_classe_id_seq OWNER TO bioinfo;

--
-- Name: eppdata_classe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE eppdata_classe_id_seq OWNED BY eppdata_classe.id;


--
-- Name: eppdata_method; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE eppdata_method (
    id integer NOT NULL,
    method_description text,
    method_name character varying(100),
    unit character varying(100),
    quali_quanti_notes character varying(100),
    ind_global character varying(100),
    classe_id integer,
    person_id integer
);


ALTER TABLE eppdata_method OWNER TO bioinfo;

--
-- Name: eppdata_env_pra_phe_method_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE eppdata_env_pra_phe_method_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eppdata_env_pra_phe_method_id_seq OWNER TO bioinfo;

--
-- Name: eppdata_env_pra_phe_method_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE eppdata_env_pra_phe_method_id_seq OWNED BY eppdata_method.id;


--
-- Name: eppdata_raw_data; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE eppdata_raw_data (
    id integer NOT NULL,
    raw_data text,
    "group" character varying(100),
    description character varying(100),
    individual integer,
    method_id integer NOT NULL,
    variable_id integer NOT NULL,
    date date
);


ALTER TABLE eppdata_raw_data OWNER TO bioinfo;

--
-- Name: eppdata_env_pra_phe_raw_data_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE eppdata_env_pra_phe_raw_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eppdata_env_pra_phe_raw_data_id_seq OWNER TO bioinfo;

--
-- Name: eppdata_env_pra_phe_raw_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE eppdata_env_pra_phe_raw_data_id_seq OWNED BY eppdata_raw_data.id;


--
-- Name: eppdata_raw_data_relation; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE eppdata_raw_data_relation (
    id integer NOT NULL,
    raw_data_id integer NOT NULL,
    relation_id integer NOT NULL
);


ALTER TABLE eppdata_raw_data_relation OWNER TO bioinfo;

--
-- Name: eppdata_env_pra_phe_raw_data_relation_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE eppdata_env_pra_phe_raw_data_relation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eppdata_env_pra_phe_raw_data_relation_id_seq OWNER TO bioinfo;

--
-- Name: eppdata_env_pra_phe_raw_data_relation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE eppdata_env_pra_phe_raw_data_relation_id_seq OWNED BY eppdata_raw_data_relation.id;


--
-- Name: eppdata_raw_data_seed_lot; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE eppdata_raw_data_seed_lot (
    id integer NOT NULL,
    raw_data_id integer NOT NULL,
    seed_lot_id integer NOT NULL
);


ALTER TABLE eppdata_raw_data_seed_lot OWNER TO bioinfo;

--
-- Name: eppdata_env_pra_phe_raw_data_seed_lot_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE eppdata_env_pra_phe_raw_data_seed_lot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eppdata_env_pra_phe_raw_data_seed_lot_id_seq OWNER TO bioinfo;

--
-- Name: eppdata_env_pra_phe_raw_data_seed_lot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE eppdata_env_pra_phe_raw_data_seed_lot_id_seq OWNED BY eppdata_raw_data_seed_lot.id;


--
-- Name: eppdata_variable; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE eppdata_variable (
    id integer NOT NULL,
    name character varying(100),
    type character varying(10),
    season character varying(10)
);


ALTER TABLE eppdata_variable OWNER TO bioinfo;

--
-- Name: eppdata_env_pra_phe_variable_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE eppdata_env_pra_phe_variable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eppdata_env_pra_phe_variable_id_seq OWNER TO bioinfo;

--
-- Name: eppdata_env_pra_phe_variable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE eppdata_env_pra_phe_variable_id_seq OWNED BY eppdata_variable.id;


--
-- Name: network_diffusion; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE network_diffusion (
    id integer NOT NULL,
    date integer
);


ALTER TABLE network_diffusion OWNER TO bioinfo;

--
-- Name: network_diffusion_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE network_diffusion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE network_diffusion_id_seq OWNER TO bioinfo;

--
-- Name: network_diffusion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE network_diffusion_id_seq OWNED BY network_diffusion.id;


--
-- Name: network_mixture; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE network_mixture (
    id integer NOT NULL,
    date integer
);


ALTER TABLE network_mixture OWNER TO bioinfo;

--
-- Name: network_mixture_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE network_mixture_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE network_mixture_id_seq OWNER TO bioinfo;

--
-- Name: network_mixture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE network_mixture_id_seq OWNED BY network_mixture.id;


--
-- Name: network_relation; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE network_relation (
    id integer NOT NULL,
    quantity integer,
    is_male character varying(2),
    split character varying(1),
    block integer,
    "X" character varying(10),
    "Y" character varying(10),
    diffusion_id integer,
    mixture_id integer,
    reproduction_id integer,
    seed_lot_father_id integer NOT NULL,
    seed_lot_son_id integer,
    selection_id integer
);


ALTER TABLE network_relation OWNER TO bioinfo;

--
-- Name: network_relation_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE network_relation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE network_relation_id_seq OWNER TO bioinfo;

--
-- Name: network_relation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE network_relation_id_seq OWNED BY network_relation.id;


--
-- Name: network_relation_project; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE network_relation_project (
    id integer NOT NULL,
    relation_id integer NOT NULL,
    project_id integer NOT NULL
);


ALTER TABLE network_relation_project OWNER TO bioinfo;

--
-- Name: network_relation_project_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE network_relation_project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE network_relation_project_id_seq OWNER TO bioinfo;

--
-- Name: network_relation_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE network_relation_project_id_seq OWNED BY network_relation_project.id;


--
-- Name: network_reproduction; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE network_reproduction (
    id integer NOT NULL,
    kernel_number integer,
    cross_number integer,
    description character varying(200),
    realised character varying(2),
    reproduction_method_id integer,
    end_date integer,
    start_date integer
);


ALTER TABLE network_reproduction OWNER TO bioinfo;

--
-- Name: network_reproduction_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE network_reproduction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE network_reproduction_id_seq OWNER TO bioinfo;

--
-- Name: network_reproduction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE network_reproduction_id_seq OWNED BY network_reproduction.id;


--
-- Name: network_reproduction_method; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE network_reproduction_method (
    id integer NOT NULL,
    reproduction_methode_name character varying(100),
    description character varying(500)
);


ALTER TABLE network_reproduction_method OWNER TO bioinfo;

--
-- Name: network_reproduction_method_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE network_reproduction_method_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE network_reproduction_method_id_seq OWNER TO bioinfo;

--
-- Name: network_reproduction_method_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE network_reproduction_method_id_seq OWNED BY network_reproduction_method.id;


--
-- Name: network_selection; Type: TABLE; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE TABLE network_selection (
    id integer NOT NULL,
    selection_name character varying(100),
    date integer,
    person_id integer
);


ALTER TABLE network_selection OWNER TO bioinfo;

--
-- Name: network_selection_id_seq; Type: SEQUENCE; Schema: public; Owner: bioinfo
--

CREATE SEQUENCE network_selection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE network_selection_id_seq OWNER TO bioinfo;

--
-- Name: network_selection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bioinfo
--

ALTER SEQUENCE network_selection_id_seq OWNED BY network_selection.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY actors_location ALTER COLUMN id SET DEFAULT nextval('actors_location_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY actors_person ALTER COLUMN id SET DEFAULT nextval('actors_person_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY actors_project ALTER COLUMN id SET DEFAULT nextval('actors_project_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY actors_project_person ALTER COLUMN id SET DEFAULT nextval('actors_project_person_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY entities_germplasm ALTER COLUMN id SET DEFAULT nextval('entities_germplasm_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY entities_germplasm_type ALTER COLUMN id SET DEFAULT nextval('entities_germplasm_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY entities_seed_lot ALTER COLUMN id SET DEFAULT nextval('entities_seed_lot_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY entities_species ALTER COLUMN id SET DEFAULT nextval('entities_species_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY eppdata_classe ALTER COLUMN id SET DEFAULT nextval('eppdata_classe_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY eppdata_method ALTER COLUMN id SET DEFAULT nextval('eppdata_env_pra_phe_method_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY eppdata_raw_data ALTER COLUMN id SET DEFAULT nextval('eppdata_env_pra_phe_raw_data_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY eppdata_raw_data_relation ALTER COLUMN id SET DEFAULT nextval('eppdata_env_pra_phe_raw_data_relation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY eppdata_raw_data_seed_lot ALTER COLUMN id SET DEFAULT nextval('eppdata_env_pra_phe_raw_data_seed_lot_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY eppdata_variable ALTER COLUMN id SET DEFAULT nextval('eppdata_env_pra_phe_variable_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_diffusion ALTER COLUMN id SET DEFAULT nextval('network_diffusion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_mixture ALTER COLUMN id SET DEFAULT nextval('network_mixture_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_relation ALTER COLUMN id SET DEFAULT nextval('network_relation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_relation_project ALTER COLUMN id SET DEFAULT nextval('network_relation_project_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_reproduction ALTER COLUMN id SET DEFAULT nextval('network_reproduction_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_reproduction_method ALTER COLUMN id SET DEFAULT nextval('network_reproduction_method_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_selection ALTER COLUMN id SET DEFAULT nextval('network_selection_id_seq'::regclass);


--
-- Data for Name: actors_location; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY actors_location (id, location_name, location_type, address, post_code, country, longitude, latitude, altitude) FROM stdin;
1	MLN					2.352222	48.856614	
2	JFB					0.616363	44.203142	
3	OLR					4.835659	45.764043	
4	JSG					3.087025	45.777222	
\.


--
-- Name: actors_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('actors_location_id_seq', 4, true);


--
-- Data for Name: actors_person; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY actors_person (id, first_name, last_name, short_name, gender, email, phone1, phone2, fax, location_id, birth_date) FROM stdin;
1			JFB	M					2	\N
4			JSG	M					4	\N
3			MLN	M					1	\N
2			OLR	M					3	\N
\.


--
-- Name: actors_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('actors_person_id_seq', 4, true);


--
-- Data for Name: actors_project; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY actors_project (id, project_name, start_date, end_date) FROM stdin;
1	DEMO	2016-04-26	\N
\.


--
-- Name: actors_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('actors_project_id_seq', 1, true);


--
-- Data for Name: actors_project_person; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY actors_project_person (id, project_id, person_id) FROM stdin;
\.


--
-- Name: actors_project_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('actors_project_person_id_seq', 1, false);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add location	1	add_location
2	Can change location	1	change_location
3	Can delete location	1	delete_location
4	Can add person	2	add_person
5	Can change person	2	change_person
6	Can delete person	2	delete_person
7	Can add project	3	add_project
8	Can change project	3	change_project
9	Can delete project	3	delete_project
10	Can add species	4	add_species
11	Can change species	4	change_species
12	Can delete species	4	delete_species
13	Can add germplasm_type	5	add_germplasm_type
14	Can change germplasm_type	5	change_germplasm_type
15	Can delete germplasm_type	5	delete_germplasm_type
16	Can add germplasm	6	add_germplasm
17	Can change germplasm	6	change_germplasm
18	Can delete germplasm	6	delete_germplasm
19	Can add seed_lot	7	add_seed_lot
20	Can change seed_lot	7	change_seed_lot
21	Can delete seed_lot	7	delete_seed_lot
22	Can add diffusion	8	add_diffusion
23	Can change diffusion	8	change_diffusion
24	Can delete diffusion	8	delete_diffusion
25	Can add reproduction_method	9	add_reproduction_method
26	Can change reproduction_method	9	change_reproduction_method
27	Can delete reproduction_method	9	delete_reproduction_method
28	Can add reproduction	10	add_reproduction
29	Can change reproduction	10	change_reproduction
30	Can delete reproduction	10	delete_reproduction
31	Can add mixture	11	add_mixture
32	Can change mixture	11	change_mixture
33	Can delete mixture	11	delete_mixture
34	Can add selection	12	add_selection
35	Can change selection	12	change_selection
36	Can delete selection	12	delete_selection
37	Can add relation	13	add_relation
38	Can change relation	13	change_relation
39	Can delete relation	13	delete_relation
40	Can add classe	14	add_classe
41	Can change classe	14	change_classe
42	Can delete classe	14	delete_classe
43	Can add method	15	add_method
44	Can change method	15	change_method
45	Can delete method	15	delete_method
46	Can add variable	16	add_variable
47	Can change variable	16	change_variable
48	Can delete variable	16	delete_variable
49	Can add raw_data	17	add_raw_data
50	Can change raw_data	17	change_raw_data
51	Can delete raw_data	17	delete_raw_data
52	Can add analysis	18	add_analysis
53	Can change analysis	18	change_analysis
54	Can delete analysis	18	delete_analysis
55	Can add group_ analysis	19	add_group_analysis
56	Can change group_ analysis	19	change_group_analysis
57	Can delete group_ analysis	19	delete_group_analysis
58	Can add analysis_ file	20	add_analysis_file
59	Can change analysis_ file	20	change_analysis_file
60	Can delete analysis_ file	20	delete_analysis_file
61	Can add permission	21	add_permission
62	Can change permission	21	change_permission
63	Can delete permission	21	delete_permission
64	Can add group	22	add_group
65	Can change group	22	change_group
66	Can delete group	22	delete_group
67	Can add user	23	add_user
68	Can change user	23	change_user
69	Can delete user	23	delete_user
70	Can add content type	24	add_contenttype
71	Can change content type	24	change_contenttype
72	Can delete content type	24	delete_contenttype
73	Can add session	25	add_session
74	Can change session	25	change_session
75	Can delete session	25	delete_session
76	Can add site	26	add_site
77	Can change site	26	change_site
78	Can delete site	26	delete_site
79	Can add log entry	27	add_logentry
80	Can change log entry	27	change_logentry
81	Can delete log entry	27	delete_logentry
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('auth_permission_id_seq', 81, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$24000$riFcMQrKQhgT$5O16kyfec1a5qBM0Net5qZSb32Jj29BUIRiliuqjMjA=	2016-07-05 12:54:03.934601+02	t	yannick				t	t	2016-04-26 17:07:04.616896+02
2	pbkdf2_sha256$24000$zEokIMZSZnvJ$HwWbE3ayVavscpkRRKIhK/QwkPh0A1u3MzEPpTm7r/w=	2016-07-05 13:46:14.476455+02	t	pierre				t	t	2016-04-26 17:07:15.598119+02
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('auth_user_id_seq', 2, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2016-04-26 17:09:02.836544+02	1	blé-tendre	1	Ajout.	4	1
2	2016-04-26 17:09:42.121301+02	1	Variété de Pays	1	Ajout.	5	1
3	2016-04-26 17:09:51.978067+02	2	Variété Ancienne	1	Ajout.	5	1
4	2016-04-26 17:09:59.071301+02	3	Variété Moderne	1	Ajout.	5	1
5	2016-04-26 17:10:51.772896+02	1	notes	1	Ajout.	15	1
6	2016-04-26 17:10:58.314774+02	2	couleur_grains	1	Ajout.	15	1
7	2016-04-26 17:11:16.430009+02	3	densite_semis	1	Ajout.	15	1
8	2016-04-26 17:11:28.037454+02	4	type_semis	1	Ajout.	15	1
9	2016-04-26 17:11:36.60472+02	5	tallage	1	Ajout.	15	1
10	2016-04-26 17:11:47.117878+02	6	type_epiaison	1	Ajout.	15	1
11	2016-04-26 17:11:56.745788+02	7	hauteur_tige	1	Ajout.	15	1
12	2016-04-26 17:12:04.495824+02	8	pmg	1	Ajout.	15	1
13	2016-04-26 17:12:20.155836+02	1	JFB	1	Ajout.	2	1
14	2016-04-26 17:12:29.31776+02	2	OLR	1	Ajout.	2	1
15	2016-04-26 17:12:42.702122+02	3	MLN	1	Ajout.	2	1
16	2016-04-26 17:13:03.923549+02	1	reproduction classique	1	Ajout.	9	1
17	2016-04-26 17:13:09.905989+02	2	fecondation libre	1	Ajout.	9	1
18	2016-04-26 17:13:16.438375+02	3	croisement dirigé	1	Ajout.	9	1
19	2016-04-26 17:23:06.843581+02	1	blé-tendre	3		4	1
20	2016-04-26 17:23:19.240196+02	2	blé-tendre	1	Ajout.	4	1
21	2016-05-02 22:16:58.643499+02	9	couleur_epis	1	Ajout.	15	2
22	2016-05-02 22:17:10.322449+02	10	barbes	1	Ajout.	15	2
23	2016-05-02 22:17:21.694226+02	10	barbes	2	Aucun champ modifié.	15	2
24	2016-05-02 22:17:30.477797+02	11	poids_epis	1	Ajout.	15	2
25	2016-05-02 22:23:54.484051+02	12	confiance	1	Ajout.	15	2
26	2016-05-02 22:24:03.307315+02	12	confiance	2	Aucun champ modifié.	15	2
27	2016-05-02 22:24:08.487491+02	12	confiance	2	Aucun champ modifié.	15	2
28	2016-05-02 22:24:12.741366+02	13	qualite_info	1	Ajout.	15	2
29	2016-05-04 11:19:25.645302+02	26	C2_JFB_2011_0001 --> C2_JFB_2012_0001	2	Modification de split.	13	1
30	2016-05-04 11:22:55.262555+02	26	C2_JFB_2011_0001 --> C2_JFB_2012_0001	2	Modification de split.	13	1
31	2016-05-04 11:23:34.606699+02	26	C2_JFB_2011_0001 --> C2_JFB_2012_0001	2	Modification de split.	13	1
32	2016-05-04 11:25:16.440843+02	26	C2_JFB_2011_0001 --> C2_JFB_2012_0001	2	Modification de split.	13	1
33	2016-05-04 11:25:31.365798+02	26	C2_JFB_2011_0001 --> C2_JFB_2012_0001	2	Modification de split.	13	1
34	2016-05-04 11:25:45.922126+02	26	C2_JFB_2011_0001 --> C2_JFB_2012_0001	2	Modification de split.	13	1
35	2016-05-14 12:38:10.773764+02	2	blé-tendre	3		4	2
36	2016-05-17 14:17:59.604792+02	3	ble-tendre	1	Ajout.	4	2
37	2016-05-17 14:20:18.112597+02	14	type_recolte	1	Ajout.	15	2
38	2016-05-17 20:27:13.434341+02	15	selection_description	1	Ajout.	15	2
39	2016-05-17 20:36:08.649702+02	16	note_globale	1	Ajout.	15	2
40	2016-05-17 22:15:45.539045+02	3	ble-tendre	3		4	2
41	2016-05-17 22:16:10.53233+02	4	ble-tendre	1	Ajout.	4	2
42	2016-05-17 22:31:55.010776+02	4	ble-tendre	3		4	2
43	2016-05-17 22:32:09.544573+02	5	ble-tendre	1	Ajout.	4	2
44	2016-06-01 15:46:44.217315+02	5	ble-tendre	3		4	2
45	2016-06-02 11:15:29.505549+02	6	variete de pays	1	Ajout.	5	2
46	2016-06-02 11:19:56.36858+02	6	ble-tendre	1	Ajout.	4	2
47	2016-06-03 10:09:44.276684+02	59	Blé-du-Lot	3		6	2
48	2016-06-03 10:09:44.289728+02	60	C1	3		6	2
49	2016-06-03 10:09:44.290697+02	62	C2	3		6	2
50	2016-06-03 10:09:44.291638+02	63	C3	3		6	2
51	2016-06-03 10:09:44.292617+02	65	C4	3		6	2
52	2016-06-03 10:09:44.293568+02	66	C5	3		6	2
53	2016-06-03 10:09:44.294497+02	67	C6	3		6	2
54	2016-06-03 10:09:44.295378+02	68	C7	3		6	2
55	2016-06-03 10:09:44.296301+02	61	Cloche	3		6	2
56	2016-06-03 10:09:44.297265+02	58	Rouge-du-Roc	3		6	2
57	2016-06-03 10:09:44.298204+02	64	Touselle-Anone	3		6	2
58	2016-06-03 10:46:33.427806+02	22	etat_sanitaire	1	Ajout.	16	2
59	2016-06-03 10:48:57.952569+02	22	etat_sanitaire	2	Modification de season.	16	2
60	2016-06-03 10:50:04.192832+02	17	etat_sanitaire	1	Ajout.	15	2
61	2016-06-03 11:14:39.913241+02	22	etat_sanitaire	2	Modification de season.	16	2
62	2016-06-03 11:15:21.857681+02	22	etat_sanitaire	3		16	2
63	2016-06-06 08:32:57.468913+02	6	ble-tendre	3		4	2
64	2016-06-06 09:16:11.845143+02	7	variété de pays	1	Ajout.	5	2
65	2016-06-06 09:17:04.331559+02	6	variete de pays	2	Aucun champ modifié.	5	2
66	2016-06-06 12:10:29.979381+02	7	Blé	1	Ajout.	4	2
67	2016-06-06 13:16:31.592737+02	7	Blé-tendre	2	Modification de species.	4	2
68	2016-06-20 10:50:31.763127+02	7	Blé-tendre	3		4	2
69	2016-06-20 12:22:27.470476+02	1	MLN	1	Ajout.	1	2
70	2016-06-20 12:22:43.157584+02	3	MLN	2	Modification de location.	2	2
71	2016-06-20 12:24:56.604312+02	2	JFB	1	Ajout.	1	2
72	2016-06-20 12:25:14.219463+02	1	JFB	2	Modification de location.	2	2
73	2016-06-20 12:25:38.965868+02	3	OLR	1	Ajout.	1	2
74	2016-06-20 12:27:52.441908+02	8	ble-tendre	1	Ajout.	4	2
75	2016-06-20 12:29:22.493067+02	7	variété de pays	3		5	2
76	2016-06-20 12:29:22.494925+02	6	variete de pays	3		5	2
77	2016-06-20 12:30:14.723508+02	5	mixture	2	Modification de germplasm_type et description.	5	2
78	2016-06-20 12:30:22.139514+02	4	cross	2	Modification de germplasm_type et description.	5	2
79	2016-06-20 12:30:45.466688+02	2	variete_de_pays	2	Modification de germplasm_type.	5	2
80	2016-06-20 12:30:53.606138+02	3	Variété Moderne	3		5	2
81	2016-06-20 12:30:53.607666+02	1	Variété de Pays	3		5	2
82	2016-06-20 12:31:31.287382+02	8	ble-tendre	3		4	2
83	2016-06-20 12:31:40.244324+02	9	ble-tendre	1	Ajout.	4	2
84	2016-06-20 13:47:44.327824+02	3	croisement dirigé	3		9	2
85	2016-06-20 13:47:44.329752+02	1	reproduction classique	3		9	2
86	2016-06-20 13:47:54.091115+02	4	cross	3		9	2
87	2016-06-20 13:59:29.208805+02	4	JSG	1	Ajout.	2	2
88	2016-06-20 14:00:45.308136+02	4	JSG	1	Ajout.	1	2
89	2016-06-20 14:03:06.980388+02	18	date_semis	1	Ajout.	15	2
90	2016-06-20 14:03:21.393376+02	19	taille_micro_parcelle	1	Ajout.	15	2
91	2016-06-20 14:03:36.631757+02	19	date_epiaison	2	Modification de method_name.	15	2
92	2016-06-20 14:03:48.710968+02	20	date_recolte	1	Ajout.	15	2
93	2016-06-20 14:04:33.979267+02	21	taille_micro_parcelle	1	Ajout.	15	2
94	2016-06-24 10:28:09.63467+02	4	JSG	2	Modification de location.	2	2
95	2016-06-24 10:28:19.134952+02	3	MLN	2	Aucun champ modifié.	2	2
96	2016-06-24 10:28:28.548646+02	2	OLR	2	Modification de location.	2	2
97	2016-06-29 10:17:05.459511+02	9	ble-tendre	3		4	2
214	2016-06-30 11:16:03.196415+02	142	2012 []	3		8	2
98	2016-06-29 10:19:10.158888+02	10	ble-tendre	1	Ajout.	4	2
99	2016-06-29 10:25:17.560337+02	10	ble-tendre	3		4	2
100	2016-06-29 10:25:26.754154+02	11	ble-tendre	1	Ajout.	4	2
101	2016-06-29 10:35:46.88157+02	22	pmg-2	1	Ajout.	15	2
102	2016-06-29 10:45:13.746991+02	11	ble-tendre	3		4	2
103	2016-06-29 10:45:20.98007+02	12	ble-tendre	1	Ajout.	4	2
104	2016-06-29 10:46:23.905932+02	30	pmg%2	3		16	2
105	2016-06-29 10:46:23.907899+02	29	Pmg%2	3		16	2
106	2016-06-29 10:46:23.908965+02	28	taille_micro_parcelle	3		16	2
107	2016-06-29 10:46:23.910002+02	27	date_recolte	3		16	2
108	2016-06-29 10:46:23.911272+02	26	date_epiaison	3		16	2
109	2016-06-29 10:46:23.912614+02	25	date_semis	3		16	2
110	2016-06-29 10:46:23.913593+02	24	type_semis	3		16	2
111	2016-06-29 10:46:23.914562+02	23	etat_sanitaire	3		16	2
112	2016-06-29 10:46:23.9155+02	21	note_globale	3		16	2
113	2016-06-29 10:46:23.916478+02	20	selection_description	3		16	2
114	2016-06-29 10:46:23.917345+02	19	recolte	3		16	2
115	2016-06-29 10:46:23.918177+02	18	pmg	3		16	2
116	2016-06-29 10:46:23.918994+02	17	epiaison	3		16	2
117	2016-06-29 10:46:23.91984+02	16	tallage	3		16	2
118	2016-06-29 10:46:23.920647+02	15	qualite_info_var	3		16	2
119	2016-06-29 10:46:23.921525+02	14	confiance_var	3		16	2
120	2016-06-29 10:46:23.922365+02	13	notes_var	3		16	2
121	2016-06-29 10:46:23.923217+02	12	qualite_info	3		16	2
122	2016-06-29 10:46:23.924066+02	11	confiance	3		16	2
123	2016-06-29 10:46:23.924948+02	10	notes	3		16	2
124	2016-06-29 10:46:23.926091+02	9	poids_epis	3		16	2
125	2016-06-29 10:46:23.927304+02	8	barbes	3		16	2
126	2016-06-29 10:46:23.92826+02	7	couleur	3		16	2
127	2016-06-29 10:46:23.929152+02	6	hauteur	3		16	2
128	2016-06-29 10:46:23.930021+02	5	semis	3		16	2
129	2016-06-29 10:46:23.930871+02	4	densite_semis	3		16	2
130	2016-06-29 10:46:23.93174+02	3	croisement_notes	3		16	2
131	2016-06-29 10:46:23.932536+02	2	male_notes	3		16	2
132	2016-06-29 10:46:23.933371+02	1	female_notes	3		16	2
133	2016-06-29 10:52:18.026847+02	12	ble-tendre	3		4	2
134	2016-06-29 10:52:23.9214+02	13	ble-tendre	1	Ajout.	4	2
135	2016-06-30 11:15:17.780979+02	13	ble-tendre	3		4	2
136	2016-06-30 11:16:02.940787+02	220	2012 []	3		8	2
137	2016-06-30 11:16:02.944292+02	219	2012 []	3		8	2
138	2016-06-30 11:16:02.947215+02	218	2012 []	3		8	2
139	2016-06-30 11:16:02.950177+02	217	2012 []	3		8	2
140	2016-06-30 11:16:02.953231+02	216	2012 []	3		8	2
141	2016-06-30 11:16:02.956168+02	215	2012 []	3		8	2
142	2016-06-30 11:16:02.959219+02	214	2012 []	3		8	2
143	2016-06-30 11:16:02.962302+02	213	2012 []	3		8	2
144	2016-06-30 11:16:02.965569+02	212	2012 []	3		8	2
145	2016-06-30 11:16:02.969096+02	211	2012 []	3		8	2
146	2016-06-30 11:16:02.972089+02	210	2012 []	3		8	2
147	2016-06-30 11:16:02.975665+02	209	2012 []	3		8	2
148	2016-06-30 11:16:02.979175+02	208	2012 []	3		8	2
149	2016-06-30 11:16:02.982733+02	207	2012 []	3		8	2
150	2016-06-30 11:16:02.9857+02	206	2012 []	3		8	2
151	2016-06-30 11:16:02.989345+02	205	2012 []	3		8	2
152	2016-06-30 11:16:02.992474+02	204	2012 []	3		8	2
153	2016-06-30 11:16:02.99569+02	203	2012 []	3		8	2
154	2016-06-30 11:16:02.999413+02	202	2012 []	3		8	2
155	2016-06-30 11:16:03.002545+02	201	2012 []	3		8	2
156	2016-06-30 11:16:03.005515+02	200	2012 []	3		8	2
157	2016-06-30 11:16:03.008443+02	199	2012 []	3		8	2
158	2016-06-30 11:16:03.011448+02	198	2012 []	3		8	2
159	2016-06-30 11:16:03.014671+02	197	2012 []	3		8	2
160	2016-06-30 11:16:03.017919+02	196	2012 []	3		8	2
161	2016-06-30 11:16:03.021152+02	195	2012 []	3		8	2
162	2016-06-30 11:16:03.024207+02	194	2012 []	3		8	2
163	2016-06-30 11:16:03.027166+02	193	2012 []	3		8	2
164	2016-06-30 11:16:03.030238+02	192	2012 []	3		8	2
165	2016-06-30 11:16:03.033384+02	191	2012 []	3		8	2
166	2016-06-30 11:16:03.036499+02	190	2012 []	3		8	2
167	2016-06-30 11:16:03.039768+02	189	2012 []	3		8	2
168	2016-06-30 11:16:03.043014+02	188	2012 []	3		8	2
169	2016-06-30 11:16:03.046103+02	187	2012 []	3		8	2
170	2016-06-30 11:16:03.049273+02	186	2012 []	3		8	2
171	2016-06-30 11:16:03.052633+02	185	2012 []	3		8	2
172	2016-06-30 11:16:03.055916+02	184	2014 []	3		8	2
173	2016-06-30 11:16:03.058808+02	183	2014 []	3		8	2
174	2016-06-30 11:16:03.061789+02	182	2014 []	3		8	2
175	2016-06-30 11:16:03.06479+02	181	2014 []	3		8	2
176	2016-06-30 11:16:03.067879+02	180	2014 []	3		8	2
177	2016-06-30 11:16:03.070945+02	179	2014 []	3		8	2
178	2016-06-30 11:16:03.074116+02	178	2014 []	3		8	2
179	2016-06-30 11:16:03.077748+02	177	2014 []	3		8	2
180	2016-06-30 11:16:03.081293+02	176	2014 []	3		8	2
181	2016-06-30 11:16:03.084576+02	175	2014 []	3		8	2
182	2016-06-30 11:16:03.088126+02	174	2014 []	3		8	2
183	2016-06-30 11:16:03.091488+02	173	2014 []	3		8	2
184	2016-06-30 11:16:03.094981+02	172	2014 []	3		8	2
185	2016-06-30 11:16:03.097873+02	171	2014 []	3		8	2
186	2016-06-30 11:16:03.101671+02	170	2014 []	3		8	2
187	2016-06-30 11:16:03.104622+02	169	2012 []	3		8	2
188	2016-06-30 11:16:03.107867+02	168	2012 []	3		8	2
189	2016-06-30 11:16:03.110865+02	167	2012 []	3		8	2
190	2016-06-30 11:16:03.114053+02	166	2012 []	3		8	2
191	2016-06-30 11:16:03.117435+02	165	2012 []	3		8	2
192	2016-06-30 11:16:03.121024+02	164	2012 []	3		8	2
193	2016-06-30 11:16:03.123875+02	163	2012 []	3		8	2
194	2016-06-30 11:16:03.127198+02	162	2012 []	3		8	2
195	2016-06-30 11:16:03.13066+02	161	2012 []	3		8	2
196	2016-06-30 11:16:03.134113+02	160	2012 []	3		8	2
197	2016-06-30 11:16:03.137699+02	159	2012 []	3		8	2
198	2016-06-30 11:16:03.141191+02	158	2012 []	3		8	2
199	2016-06-30 11:16:03.144379+02	157	2012 []	3		8	2
200	2016-06-30 11:16:03.147551+02	156	2012 []	3		8	2
201	2016-06-30 11:16:03.150737+02	155	2012 []	3		8	2
202	2016-06-30 11:16:03.153873+02	154	2012 []	3		8	2
203	2016-06-30 11:16:03.156968+02	153	2012 []	3		8	2
204	2016-06-30 11:16:03.160084+02	152	2012 []	3		8	2
205	2016-06-30 11:16:03.163177+02	151	2012 []	3		8	2
206	2016-06-30 11:16:03.166181+02	150	2012 []	3		8	2
207	2016-06-30 11:16:03.16955+02	149	2012 []	3		8	2
208	2016-06-30 11:16:03.172803+02	148	2012 []	3		8	2
209	2016-06-30 11:16:03.176115+02	147	2012 []	3		8	2
210	2016-06-30 11:16:03.17976+02	146	2012 []	3		8	2
211	2016-06-30 11:16:03.183156+02	145	2012 []	3		8	2
212	2016-06-30 11:16:03.187576+02	144	2012 []	3		8	2
213	2016-06-30 11:16:03.192017+02	143	2012 []	3		8	2
215	2016-06-30 11:16:03.207698+02	141	2012 []	3		8	2
216	2016-06-30 11:16:03.212165+02	140	2012 []	3		8	2
217	2016-06-30 11:16:03.216382+02	139	2012 []	3		8	2
218	2016-06-30 11:16:03.219416+02	138	2012 []	3		8	2
219	2016-06-30 11:16:03.223007+02	137	2012 []	3		8	2
220	2016-06-30 11:16:03.226654+02	136	2012 []	3		8	2
221	2016-06-30 11:16:03.23021+02	135	2012 []	3		8	2
222	2016-06-30 11:16:03.233838+02	134	2012 []	3		8	2
223	2016-06-30 11:16:03.237341+02	133	2012 []	3		8	2
224	2016-06-30 11:16:03.240924+02	132	2012 []	3		8	2
225	2016-06-30 11:16:03.244366+02	131	2012 []	3		8	2
226	2016-06-30 11:16:03.247298+02	130	2012 []	3		8	2
227	2016-06-30 11:16:03.250219+02	129	2012 []	3		8	2
228	2016-06-30 11:16:03.253519+02	128	2012 []	3		8	2
229	2016-06-30 11:16:03.256853+02	127	2012 []	3		8	2
230	2016-06-30 11:16:03.259784+02	126	2012 []	3		8	2
231	2016-06-30 11:16:03.262833+02	125	2012 []	3		8	2
232	2016-06-30 11:16:03.265881+02	124	2012 []	3		8	2
233	2016-06-30 11:16:03.269083+02	123	2012 []	3		8	2
234	2016-06-30 11:16:03.272212+02	122	2012 []	3		8	2
235	2016-06-30 11:16:03.275297+02	121	2012 []	3		8	2
236	2016-06-30 11:16:03.278755+02	120	2012 []	3		8	2
237	2016-06-30 11:16:03.281956+02	119	2012 []	3		8	2
238	2016-06-30 11:16:03.285137+02	118	2012 []	3		8	2
239	2016-06-30 11:16:03.288149+02	117	2012 []	3		8	2
240	2016-06-30 11:16:03.291597+02	116	2012 []	3		8	2
241	2016-06-30 11:16:03.294723+02	115	2012 []	3		8	2
242	2016-06-30 11:16:03.297758+02	114	2012 []	3		8	2
243	2016-06-30 11:16:03.300818+02	113	2012 []	3		8	2
244	2016-06-30 11:16:03.303807+02	112	2012 []	3		8	2
245	2016-06-30 11:16:03.307154+02	111	2012 []	3		8	2
246	2016-06-30 11:16:03.310529+02	110	2012 []	3		8	2
247	2016-06-30 11:16:03.31357+02	109	2012 []	3		8	2
248	2016-06-30 11:16:03.317211+02	108	2012 []	3		8	2
249	2016-06-30 11:16:03.320431+02	107	2012 []	3		8	2
250	2016-06-30 11:16:03.323497+02	106	2012 []	3		8	2
251	2016-06-30 11:16:03.327434+02	105	2012 []	3		8	2
252	2016-06-30 11:16:03.330661+02	104	2012 []	3		8	2
253	2016-06-30 11:16:03.333869+02	103	2012 []	3		8	2
254	2016-06-30 11:16:03.337209+02	102	2012 []	3		8	2
255	2016-06-30 11:16:03.340353+02	101	2012 []	3		8	2
256	2016-06-30 11:16:03.343702+02	100	2012 []	3		8	2
257	2016-06-30 11:16:03.347388+02	99	2012 []	3		8	2
258	2016-06-30 11:16:03.350844+02	98	2012 []	3		8	2
259	2016-06-30 11:16:03.353922+02	97	2012 []	3		8	2
260	2016-06-30 11:16:03.357142+02	96	2012 []	3		8	2
261	2016-06-30 11:16:03.36125+02	95	2012 []	3		8	2
262	2016-06-30 11:16:03.364579+02	94	2012 []	3		8	2
263	2016-06-30 11:16:03.36781+02	93	2012 []	3		8	2
264	2016-06-30 11:16:03.370886+02	92	2012 []	3		8	2
265	2016-06-30 11:16:03.374962+02	91	2012 []	3		8	2
266	2016-06-30 11:16:03.378298+02	90	2012 []	3		8	2
267	2016-06-30 11:16:03.381492+02	89	2012 []	3		8	2
268	2016-06-30 11:16:03.385045+02	88	2012 []	3		8	2
269	2016-06-30 11:16:03.388091+02	87	2012 []	3		8	2
270	2016-06-30 11:16:03.391445+02	86	2012 []	3		8	2
271	2016-06-30 11:16:03.394627+02	85	2012 []	3		8	2
272	2016-06-30 11:16:03.397758+02	84	2012 []	3		8	2
273	2016-06-30 11:16:03.400904+02	83	2012 []	3		8	2
274	2016-06-30 11:16:03.404348+02	82	2012 []	3		8	2
275	2016-06-30 11:16:03.407859+02	81	2012 []	3		8	2
276	2016-06-30 11:16:03.4108+02	80	2012 []	3		8	2
277	2016-06-30 11:16:03.414086+02	79	2012 []	3		8	2
278	2016-06-30 11:16:03.417604+02	78	2012 []	3		8	2
279	2016-06-30 11:16:03.421244+02	77	2012 []	3		8	2
280	2016-06-30 11:16:03.424737+02	76	2012 []	3		8	2
281	2016-06-30 11:16:03.42827+02	75	2012 []	3		8	2
282	2016-06-30 11:16:03.431355+02	74	2012 []	3		8	2
283	2016-06-30 11:16:03.435378+02	40	2012 []	3		8	2
284	2016-06-30 11:16:03.439689+02	39	2012 []	3		8	2
285	2016-06-30 11:16:03.442725+02	38	2012 []	3		8	2
286	2016-06-30 11:16:03.446253+02	37	2012 []	3		8	2
287	2016-06-30 11:16:03.450852+02	36	2012 []	3		8	2
288	2016-06-30 11:16:03.454735+02	35	2012 []	3		8	2
289	2016-06-30 11:16:03.458516+02	34	2012 []	3		8	2
290	2016-06-30 11:16:03.461659+02	33	2012 []	3		8	2
291	2016-06-30 11:16:03.464661+02	32	2012 []	3		8	2
292	2016-06-30 11:16:03.467844+02	31	2012 []	3		8	2
293	2016-06-30 11:16:03.471288+02	30	2012 []	3		8	2
294	2016-06-30 11:16:03.475582+02	29	2012 []	3		8	2
295	2016-06-30 11:16:03.478752+02	28	2012 []	3		8	2
296	2016-06-30 11:16:03.481769+02	27	2012 []	3		8	2
297	2016-06-30 11:16:03.485404+02	26	2012 []	3		8	2
298	2016-06-30 11:16:03.488496+02	25	2012 []	3		8	2
299	2016-06-30 11:16:03.491472+02	24	2012 []	3		8	2
300	2016-06-30 11:16:03.494539+02	23	2012 []	3		8	2
301	2016-06-30 11:16:03.497719+02	22	2012 []	3		8	2
302	2016-06-30 11:16:03.500898+02	21	2012 []	3		8	2
303	2016-06-30 11:16:03.504346+02	20	2012 []	3		8	2
304	2016-06-30 11:16:03.507516+02	19	2012 []	3		8	2
305	2016-06-30 11:16:03.510538+02	18	2012 []	3		8	2
306	2016-06-30 11:16:03.513573+02	17	2012 []	3		8	2
307	2016-06-30 11:16:03.51667+02	16	2012 []	3		8	2
308	2016-06-30 11:16:03.519505+02	15	2012 []	3		8	2
309	2016-06-30 11:16:03.522648+02	14	2012 []	3		8	2
310	2016-06-30 11:16:03.525692+02	13	2012 []	3		8	2
311	2016-06-30 11:16:03.528756+02	12	2012 []	3		8	2
312	2016-06-30 11:16:03.531894+02	11	2012 []	3		8	2
313	2016-06-30 11:16:03.53614+02	10	2012 []	3		8	2
314	2016-06-30 11:16:03.540428+02	9	2012 []	3		8	2
315	2016-06-30 11:16:03.544389+02	8	2012 []	3		8	2
316	2016-06-30 11:16:03.548287+02	7	2012 []	3		8	2
317	2016-06-30 11:16:03.552165+02	6	2012 []	3		8	2
318	2016-06-30 11:16:03.556052+02	5	2012 []	3		8	2
319	2016-06-30 11:16:03.560056+02	4	2012 []	3		8	2
320	2016-06-30 11:16:03.563987+02	3	2011 []	3		8	2
321	2016-06-30 11:16:03.568043+02	2	2011 []	3		8	2
322	2016-06-30 11:16:03.572008+02	1	2011 []	3		8	2
323	2016-07-01 14:16:29.497573+02	14	ble-tendre	1	Ajout.	4	2
324	2016-07-01 15:25:08.010035+02	14	ble-tendre	3		4	2
325	2016-07-01 15:25:37.791004+02	229	2016 [	3		8	2
326	2016-07-01 15:25:37.794834+02	228	2011 [	3		8	2
327	2016-07-01 15:25:37.797908+02	227	2017 [	3		8	2
328	2016-07-01 15:25:37.800868+02	225	2011 [	3		8	2
329	2016-07-01 15:25:52.59798+02	15	ble-tendre	1	Ajout.	4	2
330	2016-07-04 13:21:59.657954+02	15	ble-tendre	3		4	2
331	2016-07-04 13:22:09.236021+02	16	ble-tendre	1	Ajout.	4	2
332	2016-07-05 12:08:57.046654+02	16	ble-tendre	3		4	2
333	2016-07-05 12:09:14.963006+02	247	2012 []	3		8	2
334	2016-07-05 12:09:14.966731+02	246	2012 []	3		8	2
335	2016-07-05 12:09:14.970217+02	245	2012 []	3		8	2
336	2016-07-05 12:09:14.973707+02	244	2012 []	3		8	2
337	2016-07-05 12:09:14.978168+02	243	2012 []	3		8	2
338	2016-07-05 12:09:14.982712+02	242	2012 []	3		8	2
339	2016-07-05 12:09:14.987186+02	241	2012 []	3		8	2
340	2016-07-05 12:09:14.990498+02	240	2012 []	3		8	2
341	2016-07-05 12:09:14.993803+02	239	2012 []	3		8	2
342	2016-07-05 12:09:14.997037+02	238	2012 []	3		8	2
343	2016-07-05 12:09:15.000346+02	237	2012 []	3		8	2
344	2016-07-05 12:09:15.003466+02	236	2012 []	3		8	2
345	2016-07-05 12:09:15.00697+02	233	2016 []	3		8	2
346	2016-07-05 12:09:15.010539+02	232	2016 []	3		8	2
347	2016-07-05 13:47:21.659901+02	17	ble-tendre	1	Ajout.	4	2
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 347, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	actors	location
2	actors	person
3	actors	project
4	entities	species
5	entities	germplasm_type
6	entities	germplasm
7	entities	seed_lot
8	network	diffusion
9	network	reproduction_method
10	network	reproduction
11	network	mixture
12	network	selection
13	network	relation
14	eppdata	classe
15	eppdata	method
16	eppdata	variable
17	eppdata	raw_data
18	analysis	analysis
19	analysis	group_analysis
20	analysis	analysis_file
21	auth	permission
22	auth	group
23	auth	user
24	contenttypes	contenttype
25	sessions	session
26	sites	site
27	admin	logentry
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('django_content_type_id_seq', 27, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	actors	0001_initial	2016-04-26 17:06:51.38648+02
2	actors	0002_auto_20160426_1039	2016-04-26 17:06:51.549014+02
3	contenttypes	0001_initial	2016-04-26 17:06:51.562792+02
4	auth	0001_initial	2016-04-26 17:06:51.635342+02
5	admin	0001_initial	2016-04-26 17:06:51.658197+02
6	admin	0002_logentry_remove_auto_add	2016-04-26 17:06:51.671526+02
7	contenttypes	0002_remove_content_type_name	2016-04-26 17:06:51.697897+02
8	auth	0002_alter_permission_name_max_length	2016-04-26 17:06:51.709749+02
9	auth	0003_alter_user_email_max_length	2016-04-26 17:06:51.720945+02
10	auth	0004_alter_user_username_opts	2016-04-26 17:06:51.731127+02
11	auth	0005_alter_user_last_login_null	2016-04-26 17:06:51.742517+02
12	auth	0006_require_contenttypes_0002	2016-04-26 17:06:51.745114+02
13	auth	0007_alter_validators_add_error_messages	2016-04-26 17:06:51.75486+02
14	entities	0001_initial	2016-04-26 17:06:51.831015+02
15	network	0001_initial	2016-04-26 17:06:51.966666+02
16	network	0002_auto_20160426_1645	2016-04-26 17:06:52.185804+02
17	entities	0002_auto_20160426_1047	2016-04-26 17:06:52.342371+02
18	eppdata	0001_initial	2016-04-26 17:06:52.506462+02
19	eppdata	0002_auto_20160426_1649	2016-04-26 17:06:52.900179+02
20	eppdata	0003_auto_20160426_1658	2016-04-26 17:06:53.0325+02
21	myuser	0001_initial	2016-04-26 17:06:53.063481+02
22	myuser	0002_auto_20160426_1047	2016-04-26 17:06:53.112066+02
23	sessions	0001_initial	2016-04-26 17:06:53.135338+02
24	sites	0001_initial	2016-04-26 17:06:53.147543+02
25	sites	0002_alter_domain_unique	2016-04-26 17:06:53.16038+02
26	actors	0003_auto_20160504_1140	2016-05-13 17:10:14.847843+02
27	network	0003_auto_20160504_1140	2016-05-13 17:10:16.123973+02
28	network	0004_auto_20160509_1226	2016-05-13 17:10:16.891498+02
29	entities	0003_auto_20160517_1657	2016-07-01 11:50:41.166893+02
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('django_migrations_id_seq', 29, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
9monip36epws36bkt0dfiyyubc6ieguc	ZDc4MjE1YmRmYWVlYTczMjUyNjM2M2VhY2Q0MDk2YWJiMDljZTlkNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImRlZTcyYjIwNWVjNmZmNjlmM2UzNzEwOTA0ZTA5ZTUxZGVhNzRiMWMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2016-06-24 15:54:32.160633+02
0pziumowb41nxu429o3p2z00yds3uv6h	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-07-04 10:49:29.846465+02
8rgck16nbngo4x10sffz97e0sa341hg2	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-07-04 12:18:34.663523+02
nyapvmjp55ybbc8rsnjb73smcfmc6hny	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-16 13:54:49.629975+02
cit9j9wm6q5xah23qfc0ysr454ypsgbi	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-07-06 14:40:36.062299+02
8mnkep7ir1o6j7d7q43wldlljzh4wop2	ZDc4MjE1YmRmYWVlYTczMjUyNjM2M2VhY2Q0MDk2YWJiMDljZTlkNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImRlZTcyYjIwNWVjNmZmNjlmM2UzNzEwOTA0ZTA5ZTUxZGVhNzRiMWMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2016-06-17 09:49:53.069948+02
l8pnyapa1932aujs2gn15zahbbqf5t9l	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-07-07 15:07:14.241681+02
2psqq5sn6b99xi2gm2cuv3z736bt5in5	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-21 12:20:34.775586+02
i83ldvn1l0pvygzcchedmv73lbkk1zo4	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-21 20:00:06.885671+02
zjgl0fivgf187gj77kof61fj4zqygd8r	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-22 11:48:17.668748+02
1v71wpepojecduo6s4ahuw1ycauezniz	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-22 12:23:15.341184+02
razp52oopswu28iudlwho8o77i0xgqkq	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-22 21:22:24.046842+02
kiqmx1fqjfety4k9xxcrnioo4io1xr9y	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-23 19:58:57.063033+02
54fekqqcfqkrbfei6zp1l2j06ik60hy1	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-07-08 10:27:43.731637+02
n0tqs3fj093lga84ya3out73f2v07sg8	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-07-13 09:00:47.656751+02
7l48rmgvqicwgb4oarzelrbecrtifzpx	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-07-14 11:12:56.735969+02
00qo0rtuphe8tt6roj9j0he1fyz3k3i6	ZDc4MjE1YmRmYWVlYTczMjUyNjM2M2VhY2Q0MDk2YWJiMDljZTlkNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImRlZTcyYjIwNWVjNmZmNjlmM2UzNzEwOTA0ZTA5ZTUxZGVhNzRiMWMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2016-07-14 15:03:16.702019+02
lj9fmik24096bvevfowmv3p1sarrktof	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-07-15 13:52:48.437805+02
rzzxz72x747w8c68715q6p61jmkcaunx	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-07-18 13:21:08.200878+02
9b4bhmucxiv4ap8i9enqm5wg1agia5zy	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-07-18 13:49:36.328411+02
63ac6xzqrhzzrk0zlh1zqwv1haza3bu1	ZDc4MjE1YmRmYWVlYTczMjUyNjM2M2VhY2Q0MDk2YWJiMDljZTlkNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImRlZTcyYjIwNWVjNmZmNjlmM2UzNzEwOTA0ZTA5ZTUxZGVhNzRiMWMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2016-07-19 10:31:14.113596+02
ld5gkceflq1klb01luknegnk7kq30zn9	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-07-19 11:44:51.209218+02
3ut2oy32vzo8uhlwgy2ii7ijuktd5tjb	ZDc4MjE1YmRmYWVlYTczMjUyNjM2M2VhY2Q0MDk2YWJiMDljZTlkNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImRlZTcyYjIwNWVjNmZmNjlmM2UzNzEwOTA0ZTA5ZTUxZGVhNzRiMWMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2016-07-19 12:54:03.965187+02
i0pkafxqem2mvt5nk7tpspubgxgmujot	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-07-19 13:46:14.50409+02
1n5v9jm8r47tsuslf9bm78fb4arqgkcy	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-16 14:21:54.691294+02
pfherka1ayzykpq87wxlk1f396ie6siu	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-19 20:08:53.217761+02
9uio39677mlrahc4bi5m2vqm30z2v45u	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-20 08:44:04.72055+02
ezhv3866p5zg0fee6goneu87cp6c52rz	NzYzOTRmOWIyOGNiMjA3NmE1ZGYwNjllZWMxYmZhYWJkMTkyYmY5ZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZGVlNzJiMjA1ZWM2ZmY2OWYzZTM3MTA5MDRlMDllNTFkZWE3NGIxYyIsIl9hdXRoX3VzZXJfaWQiOiIxIiwiX21lc3NhZ2VzIjoiW1tcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIkwnb2JqZXQgc3BlY2llcyBcXHUwMGFiXFx1MDBhMGJsZS10ZW5kcmVcXHUwMGEwXFx1MDBiYiBhIFxcdTAwZTl0XFx1MDBlOSBham91dFxcdTAwZTkgYXZlYyBzdWNjXFx1MDBlOHMuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIkwnb2JqZXQgc3BlY2llcyBcXHUwMGFiXFx1MDBhMGJsXFx1MDBlOS10ZW5kcmVcXHUwMGEwXFx1MDBiYiBhIFxcdTAwZTl0XFx1MDBlOSBham91dFxcdTAwZTkgYXZlYyBzdWNjXFx1MDBlOHMuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIkwnb2JqZXQgZ2VybXBsYXNtX3R5cGUgXFx1MDBhYlxcdTAwYTBWYXJpXFx1MDBlOXRcXHUwMGU5IGRlIFBheXNcXHUwMGEwXFx1MDBiYiBhIFxcdTAwZTl0XFx1MDBlOSBham91dFxcdTAwZTkgYXZlYyBzdWNjXFx1MDBlOHMuIFZvdXMgcG91dmV6IGFqb3V0ZXIgdW4gYXV0cmUgb2JqZXQgXFx1MDBhYlxcdTAwYTBnZXJtcGxhc21fdHlwZVxcdTAwYTBcXHUwMGJiIGNpLWRlc3NvdXMuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIkwnb2JqZXQgZ2VybXBsYXNtX3R5cGUgXFx1MDBhYlxcdTAwYTBWYXJpXFx1MDBlOXRcXHUwMGU5IEFuY2llbm5lXFx1MDBhMFxcdTAwYmIgYSBcXHUwMGU5dFxcdTAwZTkgYWpvdXRcXHUwMGU5IGF2ZWMgc3VjY1xcdTAwZThzLiBWb3VzIHBvdXZleiBham91dGVyIHVuIGF1dHJlIG9iamV0IFxcdTAwYWJcXHUwMGEwZ2VybXBsYXNtX3R5cGVcXHUwMGEwXFx1MDBiYiBjaS1kZXNzb3VzLlwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDAsMjUsXCJMJ29iamV0IGdlcm1wbGFzbV90eXBlIFxcdTAwYWJcXHUwMGEwVmFyaVxcdTAwZTl0XFx1MDBlOSBNb2Rlcm5lXFx1MDBhMFxcdTAwYmIgYSBcXHUwMGU5dFxcdTAwZTkgYWpvdXRcXHUwMGU5IGF2ZWMgc3VjY1xcdTAwZThzLiBWb3VzIHBvdXZleiBham91dGVyIHVuIGF1dHJlIG9iamV0IFxcdTAwYWJcXHUwMGEwZ2VybXBsYXNtX3R5cGVcXHUwMGEwXFx1MDBiYiBjaS1kZXNzb3VzLlwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDAsMjUsXCJMJ29iamV0IG1ldGhvZCBcXHUwMGFiXFx1MDBhMG5vdGVzXFx1MDBhMFxcdTAwYmIgYSBcXHUwMGU5dFxcdTAwZTkgYWpvdXRcXHUwMGU5IGF2ZWMgc3VjY1xcdTAwZThzLiBWb3VzIHBvdXZleiBham91dGVyIHVuIGF1dHJlIG9iamV0IFxcdTAwYWJcXHUwMGEwbWV0aG9kXFx1MDBhMFxcdTAwYmIgY2ktZGVzc291cy5cIl0sW1wiX19qc29uX21lc3NhZ2VcIiwwLDI1LFwiTCdvYmpldCBtZXRob2QgXFx1MDBhYlxcdTAwYTBjb3VsZXVyX2dyYWluc1xcdTAwYTBcXHUwMGJiIGEgXFx1MDBlOXRcXHUwMGU5IGFqb3V0XFx1MDBlOSBhdmVjIHN1Y2NcXHUwMGU4cy4gVm91cyBwb3V2ZXogYWpvdXRlciB1biBhdXRyZSBvYmpldCBcXHUwMGFiXFx1MDBhMG1ldGhvZFxcdTAwYTBcXHUwMGJiIGNpLWRlc3NvdXMuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIkwnb2JqZXQgbWV0aG9kIFxcdTAwYWJcXHUwMGEwZGVuc2l0ZV9zZW1pc1xcdTAwYTBcXHUwMGJiIGEgXFx1MDBlOXRcXHUwMGU5IGFqb3V0XFx1MDBlOSBhdmVjIHN1Y2NcXHUwMGU4cy4gVm91cyBwb3V2ZXogYWpvdXRlciB1biBhdXRyZSBvYmpldCBcXHUwMGFiXFx1MDBhMG1ldGhvZFxcdTAwYTBcXHUwMGJiIGNpLWRlc3NvdXMuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIkwnb2JqZXQgbWV0aG9kIFxcdTAwYWJcXHUwMGEwdHlwZV9zZW1pc1xcdTAwYTBcXHUwMGJiIGEgXFx1MDBlOXRcXHUwMGU5IGFqb3V0XFx1MDBlOSBhdmVjIHN1Y2NcXHUwMGU4cy4gVm91cyBwb3V2ZXogYWpvdXRlciB1biBhdXRyZSBvYmpldCBcXHUwMGFiXFx1MDBhMG1ldGhvZFxcdTAwYTBcXHUwMGJiIGNpLWRlc3NvdXMuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIkwnb2JqZXQgbWV0aG9kIFxcdTAwYWJcXHUwMGEwdGFsbGFnZVxcdTAwYTBcXHUwMGJiIGEgXFx1MDBlOXRcXHUwMGU5IGFqb3V0XFx1MDBlOSBhdmVjIHN1Y2NcXHUwMGU4cy4gVm91cyBwb3V2ZXogYWpvdXRlciB1biBhdXRyZSBvYmpldCBcXHUwMGFiXFx1MDBhMG1ldGhvZFxcdTAwYTBcXHUwMGJiIGNpLWRlc3NvdXMuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIkwnb2JqZXQgbWV0aG9kIFxcdTAwYWJcXHUwMGEwdHlwZV9lcGlhaXNvblxcdTAwYTBcXHUwMGJiIGEgXFx1MDBlOXRcXHUwMGU5IGFqb3V0XFx1MDBlOSBhdmVjIHN1Y2NcXHUwMGU4cy4gVm91cyBwb3V2ZXogYWpvdXRlciB1biBhdXRyZSBvYmpldCBcXHUwMGFiXFx1MDBhMG1ldGhvZFxcdTAwYTBcXHUwMGJiIGNpLWRlc3NvdXMuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIkwnb2JqZXQgbWV0aG9kIFxcdTAwYWJcXHUwMGEwaGF1dGV1cl90aWdlXFx1MDBhMFxcdTAwYmIgYSBcXHUwMGU5dFxcdTAwZTkgYWpvdXRcXHUwMGU5IGF2ZWMgc3VjY1xcdTAwZThzLiBWb3VzIHBvdXZleiBham91dGVyIHVuIGF1dHJlIG9iamV0IFxcdTAwYWJcXHUwMGEwbWV0aG9kXFx1MDBhMFxcdTAwYmIgY2ktZGVzc291cy5cIl0sW1wiX19qc29uX21lc3NhZ2VcIiwwLDI1LFwiTCdvYmpldCBtZXRob2QgXFx1MDBhYlxcdTAwYTBwbWdcXHUwMGEwXFx1MDBiYiBhIFxcdTAwZTl0XFx1MDBlOSBham91dFxcdTAwZTkgYXZlYyBzdWNjXFx1MDBlOHMuIFZvdXMgcG91dmV6IGFqb3V0ZXIgdW4gYXV0cmUgb2JqZXQgXFx1MDBhYlxcdTAwYTBtZXRob2RcXHUwMGEwXFx1MDBiYiBjaS1kZXNzb3VzLlwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDAsMjUsXCJMJ29iamV0IHBlcnNvbiBcXHUwMGFiXFx1MDBhMEpGQlxcdTAwYTBcXHUwMGJiIGEgXFx1MDBlOXRcXHUwMGU5IGFqb3V0XFx1MDBlOSBhdmVjIHN1Y2NcXHUwMGU4cy4gVm91cyBwb3V2ZXogYWpvdXRlciB1biBhdXRyZSBvYmpldCBcXHUwMGFiXFx1MDBhMHBlcnNvblxcdTAwYTBcXHUwMGJiIGNpLWRlc3NvdXMuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIkwnb2JqZXQgcGVyc29uIFxcdTAwYWJcXHUwMGEwT0xSXFx1MDBhMFxcdTAwYmIgYSBcXHUwMGU5dFxcdTAwZTkgYWpvdXRcXHUwMGU5IGF2ZWMgc3VjY1xcdTAwZThzLiBWb3VzIHBvdXZleiBham91dGVyIHVuIGF1dHJlIG9iamV0IFxcdTAwYWJcXHUwMGEwcGVyc29uXFx1MDBhMFxcdTAwYmIgY2ktZGVzc291cy5cIl0sW1wiX19qc29uX21lc3NhZ2VcIiwwLDI1LFwiTCdvYmpldCBwZXJzb24gXFx1MDBhYlxcdTAwYTBNTE5cXHUwMGEwXFx1MDBiYiBhIFxcdTAwZTl0XFx1MDBlOSBham91dFxcdTAwZTkgYXZlYyBzdWNjXFx1MDBlOHMuIFZvdXMgcG91dmV6IGFqb3V0ZXIgdW4gYXV0cmUgb2JqZXQgXFx1MDBhYlxcdTAwYTBwZXJzb25cXHUwMGEwXFx1MDBiYiBjaS1kZXNzb3VzLlwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDAsMjUsXCJMJ29iamV0IHJlcHJvZHVjdGlvbl9tZXRob2QgXFx1MDBhYlxcdTAwYTByZXByb2R1Y3Rpb24gY2xhc3NpcXVlXFx1MDBhMFxcdTAwYmIgYSBcXHUwMGU5dFxcdTAwZTkgYWpvdXRcXHUwMGU5IGF2ZWMgc3VjY1xcdTAwZThzLiBWb3VzIHBvdXZleiBham91dGVyIHVuIGF1dHJlIG9iamV0IFxcdTAwYWJcXHUwMGEwcmVwcm9kdWN0aW9uX21ldGhvZFxcdTAwYTBcXHUwMGJiIGNpLWRlc3NvdXMuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIkwnb2JqZXQgcmVwcm9kdWN0aW9uX21ldGhvZCBcXHUwMGFiXFx1MDBhMGZlY29uZGF0aW9uIGxpYnJlXFx1MDBhMFxcdTAwYmIgYSBcXHUwMGU5dFxcdTAwZTkgYWpvdXRcXHUwMGU5IGF2ZWMgc3VjY1xcdTAwZThzLiBWb3VzIHBvdXZleiBham91dGVyIHVuIGF1dHJlIG9iamV0IFxcdTAwYWJcXHUwMGEwcmVwcm9kdWN0aW9uX21ldGhvZFxcdTAwYTBcXHUwMGJiIGNpLWRlc3NvdXMuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIkwnb2JqZXQgcmVwcm9kdWN0aW9uX21ldGhvZCBcXHUwMGFiXFx1MDBhMGNyb2lzZW1lbnQgZGlyaWdcXHUwMGU5XFx1MDBhMFxcdTAwYmIgYSBcXHUwMGU5dFxcdTAwZTkgYWpvdXRcXHUwMGU5IGF2ZWMgc3VjY1xcdTAwZThzLiBWb3VzIHBvdXZleiBham91dGVyIHVuIGF1dHJlIG9iamV0IFxcdTAwYWJcXHUwMGEwcmVwcm9kdWN0aW9uX21ldGhvZFxcdTAwYTBcXHUwMGJiIGNpLWRlc3NvdXMuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIkwnb2JqZXQgc3BlY2llcyBcXHUwMGFiXFx1MDBhMGJsXFx1MDBlOS10ZW5kcmVcXHUwMGEwXFx1MDBiYiBhIFxcdTAwZTl0XFx1MDBlOSBzdXBwcmltXFx1MDBlOSBhdmVjIHN1Y2NcXHUwMGU4cy5cIl0sW1wiX19qc29uX21lc3NhZ2VcIiwwLDI1LFwiTCdvYmpldCBzcGVjaWVzIFxcdTAwYWJcXHUwMGEwYmxcXHUwMGU5LXRlbmRyZVxcdTAwYTBcXHUwMGJiIGEgXFx1MDBlOXRcXHUwMGU5IGFqb3V0XFx1MDBlOSBhdmVjIHN1Y2NcXHUwMGU4cy5cIl1dIn0=	2016-05-10 17:23:19.250095+02
cokih8jgll86b40tefk9f9zya0ddj3qb	ZDc4MjE1YmRmYWVlYTczMjUyNjM2M2VhY2Q0MDk2YWJiMDljZTlkNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImRlZTcyYjIwNWVjNmZmNjlmM2UzNzEwOTA0ZTA5ZTUxZGVhNzRiMWMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2016-05-11 09:04:37.628741+02
gide0ahgnr6zp66j05wfksn90vk0q27h	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-05-16 22:15:24.072842+02
cem6txvdf8zjkh0jk77h8h2ymji9zbd4	ZDc4MjE1YmRmYWVlYTczMjUyNjM2M2VhY2Q0MDk2YWJiMDljZTlkNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImRlZTcyYjIwNWVjNmZmNjlmM2UzNzEwOTA0ZTA5ZTUxZGVhNzRiMWMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2016-05-18 10:26:11.261849+02
zetfmscrh6vcxl9mpyity9w5u8lrjcxg	ZDc4MjE1YmRmYWVlYTczMjUyNjM2M2VhY2Q0MDk2YWJiMDljZTlkNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImRlZTcyYjIwNWVjNmZmNjlmM2UzNzEwOTA0ZTA5ZTUxZGVhNzRiMWMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2016-05-18 10:36:03.221812+02
yldmbwmv2zp84qmrkchbhsusw0wicq1s	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-05-24 11:18:12.666997+02
0h45cqww7gk91j0fq3ij01c2lj59yjci	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-05-25 12:06:18.476076+02
7b7700il5glyv9eueyzp79y6rseplae0	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-05-28 08:32:23.036244+02
9hnh86rwwvdo5ij74272g5s0a8xm4jep	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-05-28 11:40:25.216273+02
dd4qn6kxwm7xflcw0f60y5pkohgdg548	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-05-31 13:44:40.31347+02
1j9fen52gzelni3p6uljgasxw0fdo5jm	ZWUxYTczMTg4MjRmNGRiMGQ1Njk4ZjBjMjk2MjMzODFhZmRhYTYxOTp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2016-05-31 22:12:45.031943+02
adkdfyjsd9ed8p2u1766a3n6jal22kgi	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-15 15:43:31.684625+02
onamachvecb0zpz2l72r3248v88riev9	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-16 10:44:20.708363+02
f7jllwcxpyii61gw8yaiy7ve6o8z9iy4	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-16 12:03:44.597837+02
oljhur2qwiu4um2qg8abdpn8egkl64n0	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-16 12:05:38.780406+02
7iqk1aj7eabgwxk42ue55vkcpl91p5h0	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-16 12:34:49.667285+02
fz8pqsvyb38jn2q1ygsluvmaowc5xbvv	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-16 12:43:03.165321+02
3yqqha8uk607as28l6lymmr4l45vowy2	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-16 13:32:30.696042+02
0azdis2b6xjngsxvnxdj6hq2zd32i00t	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-16 16:02:25.915355+02
e42o2ytb6hnvskoq7m3borwh4tp8tvme	YmNmNzU0MmQ0YjNmODU5M2VkZjYzMTc3NTNmNzEzZjJhYjg1MjAwZDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijg0YWE3NGJhYjRkNjM1MThiODMwZWEyMWVmOTk3ZDIyZTgzOTA5MWYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-06-17 08:40:52.763188+02
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Data for Name: entities_germplasm; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY entities_germplasm (id, germplasm_name, germplasm_type_id, person_id, species_id) FROM stdin;
194	Rouge-du-Roc	\N	1	17
195	Blé-du-Lot	\N	1	17
196	C1	\N	1	17
197	Cloche	\N	1	17
198	C2	\N	1	17
199	C3	\N	1	17
200	Touselle-Anone	\N	1	17
201	C4	\N	1	17
202	C5	\N	1	17
203	C6	\N	1	17
204	C7	\N	1	17
205	M1	\N	3	17
206	M2	\N	2	17
207	M4	\N	4	17
208	M3	\N	4	17
209	M42	\N	1	17
\.


--
-- Name: entities_germplasm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('entities_germplasm_id_seq', 209, true);


--
-- Data for Name: entities_germplasm_type; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY entities_germplasm_type (id, germplasm_type, description) FROM stdin;
5	mixture	mixture
4	cross	cross
2	variete_de_pays	
8	Cross	Cross
9	Mixture	Mixture
\.


--
-- Name: entities_germplasm_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('entities_germplasm_type_id_seq', 9, true);


--
-- Data for Name: entities_seed_lot; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY entities_seed_lot (id, name, quantity_ini, date, germplasm_id, person_id, comments, confidence, generation, onfarm_confidence, onfarm_generation) FROM stdin;
1333	Rouge-du-Roc_JFB_2010_0001	\N	2010	194	1	\N	f	0	f	0
1334	Blé-du-Lot_JFB_2010_0001	\N	2010	195	1	\N	f	0	f	0
1335	C1_JFB_2011_0001	300	2011	196	1	\N	t	0	t	0
1336	Cloche_JFB_2010_0001	\N	2010	197	1	\N	f	0	f	0
1416	C4#c_OLR_2014_0001		2014	201	2	\N	t	3	t	2
1337	C2_JFB_2011_0001	100	2011	198	1	\N	t	0	t	0
1338	Blé-du-Lot_JFB_2010_0002	\N	2010	195	1	\N	f	0	f	0
1339	C3_JFB_2011_0001	200	2011	199	1	\N	t	0	t	0
1340	Touselle-Anone_JFB_2010_0001	\N	2010	200	1	\N	f	0	f	0
1417	C1#c_JFB_2014_0001		2014	196	1	\N	t	3	t	3
1341	C4_JFB_2011_0001	100	2011	201	1	\N	t	0	t	0
1342	Touselle-Anone_JFB_2010_0002	\N	2010	200	1	\N	f	0	f	0
1343	C5_JFB_2011_0001	300	2011	202	1	\N	t	0	t	0
1419	C1_JFB_2014_0003		2014	196	1	\N	t	3	t	0
1344	C6_JFB_2011_0001	250	2011	203	1	\N	t	0	t	0
1345	C1_JFB_2012_0001		2012	196	1	\N	t	1	t	1
1346	C2_JFB_2012_0001		2012	198	1	\N	t	1	t	1
1347	C3_JFB_2012_0001		2012	199	1	\N	t	1	t	1
1348	C4_JFB_2012_0001		2012	201	1	\N	t	1	t	1
1349	C5_JFB_2012_0001		2012	202	1	\N	t	1	t	1
1350	C6_JFB_2012_0001		2012	203	1	\N	t	1	t	1
1351	C7_JFB_2011_0001	68	2011	204	1	\N	f	0	f	0
1352	C7_JFB_2012_0001		2012	204	1	\N	f	1	f	1
1353	C1_MLN_2012_0001	50	2012	196	3	\N	t	1	t	0
1354	C2_MLN_2012_0001	47	2012	198	3	\N	t	1	t	0
1355	C3_MLN_2012_0001	48	2012	199	3	\N	t	1	t	0
1356	C4_MLN_2012_0001	50	2012	201	3	\N	t	1	t	0
1357	C5_MLN_2012_0001	52	2012	202	3	\N	t	1	t	0
1358	C6_MLN_2012_0001	55	2012	203	3	\N	t	1	t	0
1359	C1_OLR_2012_0001	51	2012	196	2	\N	t	1	t	0
1360	C2_OLR_2012_0001	50	2012	198	2	\N	t	1	t	0
1361	C3_OLR_2012_0001	49	2012	199	2	\N	t	1	t	0
1362	C4_OLR_2012_0001	48	2012	201	2	\N	t	1	t	0
1363	C5_OLR_2012_0001	47	2012	202	2	\N	t	1	t	0
1364	C6_OLR_2012_0001	55	2012	203	2	\N	t	1	t	0
1365	C1_JFB_2013_0001		2013	196	1	\N	t	2	t	2
1366	C2_JFB_2013_0001		2013	198	1	\N	t	2	t	2
1367	C3_JFB_2013_0001		2013	199	1	\N	t	2	t	2
1368	C4_JFB_2013_0001		2013	201	1	\N	t	2	t	2
1369	C5_JFB_2013_0001		2013	202	1	\N	t	2	t	2
1370	C6_JFB_2013_0001		2013	203	1	\N	t	2	t	2
1371	C1_MLN_2013_0001		2013	196	3	\N	t	2	t	1
1372	C2_MLN_2013_0001		2013	198	3	\N	t	2	t	1
1373	C3_MLN_2013_0001		2013	199	3	\N	t	2	t	1
1374	C4_MLN_2013_0001		2013	201	3	\N	t	2	t	1
1375	C1_OLR_2013_0001		2013	196	2	\N	t	2	t	1
1376	C2_OLR_2013_0001		2013	198	2	\N	t	2	t	1
1420	M2_JFB_2014_0001		2014	206	1	\N	t	0	t	0
1421	M4_JSG_2014_0001		2014	207	4	\N	f	0	f	0
1422	M4_JFB_2014_0001		2014	207	1	\N	f	0	t	0
1423	C1_JSG_2014_0001		2014	196	4	\N	t	3	t	0
1424	C3_JSG_2014_0001		2014	199	4	\N	t	3	t	0
1425	C4_JSG_2014_0001		2014	201	4	\N	t	3	t	0
1426	C1#a_JSG_2014_0001		2014	196	4	\N	t	3	t	0
1427	C1_JSG_2014_0002		2014	196	4	\N	t	2	t	0
1428	M1_OLR_2014_0001		2014	205	2	\N	t	0	t	0
1429	M3_JSG_2014_0001		2014	208	4	\N	f	0	f	0
1430	M3_OLR_2014_0001		2014	208	2	\N	f	0	t	0
1432	C1_MLN_2014_0003	0	2014	196	3	\N	t	0	t	0
1377	C3_OLR_2013_0001		2013	199	2	\N	t	2	t	1
1378	C4_OLR_2013_0001		2013	201	2	\N	t	2	t	1
1379	C5_OLR_2013_0001		2013	202	2	\N	t	2	t	1
1380	C6_OLR_2013_0001		2013	203	2	\N	t	2	t	1
1381	C1#a_JFB_2013_0001	51	2013	196	1	\N	t	2	t	2
1382	C3#a_JFB_2013_0001	50	2013	199	1	\N	t	2	t	2
1383	C4#a_JFB_2013_0001	51	2013	201	1	\N	t	2	t	2
1384	C6#a_JFB_2013_0001	50	2013	203	1	\N	t	2	t	2
1385	C3#b_OLR_2013_0001	50	2013	199	2	\N	t	2	t	1
1386	C4#b_OLR_2013_0001	49	2013	201	2	\N	t	2	t	1
1387	C5#a_OLR_2013_0001	50	2013	202	2	\N	t	2	t	1
1388	M1_MLN_2013_0001	25	2013	205	3	\N	t	0	t	0
1389	C1_JFB_2014_0001		2014	196	1	\N	t	3	t	3
1390	C1#a_JFB_2014_0001		2014	196	1	\N	t	3	t	3
1391	C2_JFB_2014_0001		2014	198	1	\N	t	2	t	2
1392	C3#a_JFB_2014_0001		2014	199	1	\N	t	3	t	3
1393	C3_JFB_2014_0001		2014	199	1	\N	t	3	t	3
1394	C5_JFB_2014_0001		2014	202	1	\N	t	3	t	3
1395	C1_JFB_2014_0002		2014	196	1	\N	t	3	t	3
1396	C4_JFB_2014_0001		2014	201	1	\N	t	3	t	3
1397	C4#a_JFB_2014_0001		2014	201	1	\N	t	3	t	3
1398	C2_JFB_2014_0002		2014	198	1	\N	t	2	t	2
1399	C6#a_JFB_2014_0001		2014	203	1	\N	t	3	t	3
1400	C6_JFB_2014_0001		2014	203	1	\N	t	3	t	3
1401	C1_MLN_2014_0001		2014	196	3	\N	t	3	t	2
1402	C2_MLN_2014_0001		2014	198	3	\N	t	3	t	2
1403	C3_MLN_2014_0001		2014	199	3	\N	t	3	t	2
1404	C4_MLN_2014_0001		2014	201	3	\N	t	3	t	2
1405	C1_MLN_2014_0002		2014	196	3	\N	t	3	t	2
1406	C1_OLR_2014_0001		2014	196	2	\N	t	3	t	2
1407	C2_OLR_2014_0001		2014	198	2	\N	t	3	t	2
1408	C3_OLR_2014_0001		2014	199	2	\N	t	3	t	2
1409	C4_OLR_2014_0001		2014	201	2	\N	t	3	t	2
1410	C5_OLR_2014_0001		2014	202	2	\N	t	3	t	2
1411	C6_OLR_2014_0001		2014	203	2	\N	t	3	t	2
1412	C3#b_OLR_2014_0001		2014	199	2	\N	t	3	t	2
1413	C4#b_OLR_2014_0001		2014	201	2	\N	t	3	t	2
1414	C5#a_OLR_2014_0001		2014	202	2	\N	t	3	t	2
1415	C2_OLR_2014_0002		2014	198	2	\N	t	3	t	2
1418	M2_OLR_2014_0001	25	2014	206	2	\N	t	0	t	0
1431	C1_JFB_2014_0004	0	2014	196	1	\N	t	0	t	0
1433	C2_OLR_2014_0003	0	2014	198	2	\N	t	0	t	0
\.


--
-- Name: entities_seed_lot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('entities_seed_lot_id_seq', 1433, true);


--
-- Data for Name: entities_species; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY entities_species (id, species, latin_name, description) FROM stdin;
17	ble-tendre		
\.


--
-- Name: entities_species_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('entities_species_id_seq', 17, true);


--
-- Data for Name: eppdata_classe; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY eppdata_classe (id, classe_name, modality_nb, classe_description) FROM stdin;
\.


--
-- Name: eppdata_classe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('eppdata_classe_id_seq', 1, false);


--
-- Name: eppdata_env_pra_phe_method_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('eppdata_env_pra_phe_method_id_seq', 22, true);


--
-- Name: eppdata_env_pra_phe_raw_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('eppdata_env_pra_phe_raw_data_id_seq', 8656, true);


--
-- Name: eppdata_env_pra_phe_raw_data_relation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('eppdata_env_pra_phe_raw_data_relation_id_seq', 4138, true);


--
-- Name: eppdata_env_pra_phe_raw_data_seed_lot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('eppdata_env_pra_phe_raw_data_seed_lot_id_seq', 4540, true);


--
-- Name: eppdata_env_pra_phe_variable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('eppdata_env_pra_phe_variable_id_seq', 53, true);


--
-- Data for Name: eppdata_method; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY eppdata_method (id, method_description, method_name, unit, quali_quanti_notes, ind_global, classe_id, person_id) FROM stdin;
1		notes				\N	\N
2		couleur_grains				\N	\N
3		densite_semis				\N	\N
4		type_semis				\N	\N
5		tallage				\N	\N
6		type_epiaison				\N	\N
7		hauteur_tige				\N	\N
8		pmg				\N	\N
9		couleur_epis				\N	\N
10		barbes				\N	\N
11		poids_epis				\N	\N
12		confiance				\N	\N
13		qualite_info				\N	\N
14		type_recolte				\N	\N
15		selection_description				\N	\N
16		note_globale				\N	\N
17		etat_sanitaire				\N	\N
18		date_semis				\N	\N
19		date_epiaison				\N	\N
20		date_recolte				\N	\N
21		taille_micro_parcelle				\N	\N
22		pmg-2				\N	\N
\.


--
-- Data for Name: eppdata_raw_data; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY eppdata_raw_data (id, raw_data, "group", description, individual, method_id, variable_id, date) FROM stdin;
6844	fait par Sophie	\N	\N	\N	1	37	\N
6845	Croisement Pierre	\N	\N	\N	1	37	\N
6849	problème de germination	\N	\N	\N	1	38	\N
6850	fait par Sophie	\N	\N	\N	1	39	\N
6851	Croisement Pierre	\N	\N	\N	1	39	\N
6852	problème de germination	\N	\N	\N	1	38	\N
6853	fait par Sophie	\N	\N	\N	1	39	\N
6854	Croisement Pierre	\N	\N	\N	1	39	\N
6855	problème de germination	\N	\N	\N	1	38	\N
6856	fait par Sophie	\N	\N	\N	1	39	\N
6857	Croisement Pierre	\N	\N	\N	1	39	\N
6858	volée	\N	\N	\N	4	41	2012-11-01
6859	200	\N	\N	\N	3	40	2012-11-01
6860	volée	\N	\N	\N	4	41	2012-11-01
6861	200	\N	\N	\N	3	40	2012-11-01
6862	volée	\N	\N	\N	4	41	2012-11-01
6863	200	\N	\N	\N	3	40	2012-11-01
6864	volée	\N	\N	\N	4	41	2012-11-01
6865	200	\N	\N	\N	3	40	2012-11-01
6866	volée	\N	\N	\N	4	41	2012-11-01
6867	200	\N	\N	\N	3	40	2012-11-01
6868	volée	\N	\N	\N	4	41	2012-11-01
6869	200	\N	\N	\N	3	40	2012-11-01
6870	volée	\N	\N	\N	4	41	2012-11-01
6871	200	\N	\N	\N	3	40	2012-11-01
7228	problème de germination	\N	\N	\N	1	38	\N
7229	fait par Sophie	\N	\N	\N	1	39	\N
7230	Croisement Pierre	\N	\N	\N	1	39	\N
7481	faible	\N	\N	\N	5	47	2013-02-15
7482	moyen	\N	\N	\N	5	47	2013-02-15
7483	fort	\N	\N	\N	5	47	2013-02-15
7484	fort	\N	\N	\N	5	47	2013-02-15
7485	faible	\N	\N	\N	5	47	2013-02-15
7486	faible	\N	\N	\N	5	47	2013-02-15
7487	faible	\N	\N	\N	5	47	2013-02-15
7488	moyen	\N	\N	\N	5	47	2013-02-15
7489	fort	\N	\N	\N	5	47	2013-02-15
7490	fort	\N	\N	\N	5	47	2013-02-15
7491	faible	\N	\N	\N	5	47	2013-02-15
7492	moyen	\N	\N	\N	5	47	2013-02-15
7493	fort	\N	\N	\N	5	47	2013-02-15
7494	fort	\N	\N	\N	5	47	2013-02-15
7495	faible	\N	\N	\N	5	47	2013-02-15
7496	faible	\N	\N	\N	5	47	2013-02-15
7947	volée	\N	\N	\N	4	41	2013-11-01
7948	200	\N	\N	\N	3	40	2013-11-01
7949	volée	\N	\N	\N	4	41	2013-11-01
7950	200	\N	\N	\N	3	40	2013-11-01
7951	volée	\N	\N	\N	4	41	2013-11-01
7952	200	\N	\N	\N	3	40	2013-11-01
7953	volée	\N	\N	\N	4	41	2013-11-01
7954	200	\N	\N	\N	3	40	2013-11-01
7955	volée	\N	\N	\N	4	41	2013-11-01
7956	200	\N	\N	\N	3	40	2013-11-01
7957	volée	\N	\N	\N	4	41	2013-11-01
7958	200	\N	\N	\N	3	40	2013-11-01
7959	volée	\N	\N	\N	4	41	2013-11-01
7960	200	\N	\N	\N	3	40	2013-11-01
7961	volée	\N	\N	\N	4	41	2013-11-01
7962	200	\N	\N	\N	3	40	2013-11-01
7963	volée	\N	\N	\N	4	41	2013-11-01
7964	200	\N	\N	\N	3	40	2013-11-01
7965	volée	\N	\N	\N	4	41	2013-11-01
7966	200	\N	\N	\N	3	40	2013-11-01
7967	volée	\N	\N	\N	4	41	2013-11-01
7968	200	\N	\N	\N	3	40	2013-11-01
7969	volée	\N	\N	\N	4	41	2013-11-01
7970	200	\N	\N	\N	3	40	2013-11-01
7971	semoir	\N	\N	\N	4	41	2013-11-01
7972	150	\N	\N	\N	3	40	2013-11-01
7973	semoir	\N	\N	\N	4	41	2013-11-01
7974	150	\N	\N	\N	3	40	2013-11-01
7975	semoir	\N	\N	\N	4	41	2013-11-01
7976	150	\N	\N	\N	3	40	2013-11-01
7977	semoir	\N	\N	\N	4	41	2013-11-01
7978	150	\N	\N	\N	3	40	2013-11-01
7979	semoir	\N	\N	\N	4	41	2013-11-01
7980	150	\N	\N	\N	3	40	2013-11-01
7981	semoir	\N	\N	\N	4	41	2013-11-01
7982	180	\N	\N	\N	3	40	2013-11-01
7983	semoir	\N	\N	\N	4	41	2013-11-01
7984	180	\N	\N	\N	3	40	2013-11-01
7985	semoir	\N	\N	\N	4	41	2013-11-01
7986	180	\N	\N	\N	3	40	2013-11-01
7987	semoir	\N	\N	\N	4	41	2013-11-01
7988	180	\N	\N	\N	3	40	2013-11-01
7989	semoir	\N	\N	\N	4	41	2013-11-01
7990	180	\N	\N	\N	3	40	2013-11-01
7991	semoir	\N	\N	\N	4	41	2013-11-01
7992	180	\N	\N	\N	3	40	2013-11-01
7993	semoir	\N	\N	\N	4	41	2013-11-01
7994	180	\N	\N	\N	3	40	2013-11-01
7995	semoir	\N	\N	\N	4	41	2013-11-01
7996	180	\N	\N	\N	3	40	2013-11-01
7997	semoir	\N	\N	\N	4	41	2013-11-01
7998	180	\N	\N	\N	3	40	2013-11-01
7999	semoir	\N	\N	\N	4	41	2013-11-01
8000	180	\N	\N	\N	3	40	2013-11-01
6846	problème de germination	\N	\N	\N	1	36	\N
6847	fait par Sophie	\N	\N	\N	1	37	\N
6848	Croisement Pierre	\N	\N	\N	1	37	\N
6872	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
6873	ok	\N	\N	\N	12	43	\N
6874	1	\N	\N	\N	13	44	\N
6875	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
6876	bof	\N	\N	\N	12	43	\N
6877	1	\N	\N	\N	13	44	\N
6878	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
6879	ok	\N	\N	\N	12	43	\N
6880	1	\N	\N	\N	13	44	\N
6881	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
6882	ok	\N	\N	\N	12	43	\N
6883	1	\N	\N	\N	13	44	\N
6884	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
6885	ok	\N	\N	\N	12	43	\N
6886	1	\N	\N	\N	13	44	\N
6887	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
6888	ok	\N	\N	\N	12	43	\N
6889	1	\N	\N	\N	13	44	\N
6890	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
6891	ok	\N	\N	\N	12	43	\N
6892	1	\N	\N	\N	13	44	\N
6893	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
6894	ok	\N	\N	\N	12	43	\N
6895	1	\N	\N	\N	13	44	\N
6896	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
6897	ok	\N	\N	\N	12	43	\N
6898	1	\N	\N	\N	13	44	\N
6899	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
6900	ok	\N	\N	\N	12	43	\N
6901	1	\N	\N	\N	13	44	\N
6902	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
6903	ok	\N	\N	\N	12	43	\N
6904	1	\N	\N	\N	13	44	\N
6905	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
6906	ok	\N	\N	\N	12	43	\N
6907	1	\N	\N	\N	13	44	\N
7231	volée	\N	\N	\N	4	41	2012-11-01
7232	200	\N	\N	\N	3	40	2012-11-01
7233	volée	\N	\N	\N	4	41	2012-11-01
7234	200	\N	\N	\N	3	40	2012-11-01
7235	volée	\N	\N	\N	4	41	2012-11-01
7236	200	\N	\N	\N	3	40	2012-11-01
7237	volée	\N	\N	\N	4	41	2012-11-01
7238	200	\N	\N	\N	3	40	2012-11-01
7239	volée	\N	\N	\N	4	41	2012-11-01
7240	200	\N	\N	\N	3	40	2012-11-01
7241	volée	\N	\N	\N	4	41	2012-11-01
7242	200	\N	\N	\N	3	40	2012-11-01
7243	volée	\N	\N	\N	4	41	2012-11-01
7244	200	\N	\N	\N	3	40	2012-11-01
7497	rapide	\N	\N	\N	6	48	2013-05-20
7498	rapide	\N	\N	\N	6	48	2013-05-21
7499	lente	\N	\N	\N	6	48	2013-05-25
7500	lente	\N	\N	\N	6	48	2013-05-20
7501	lente	\N	\N	\N	6	48	2013-05-21
7502	lente	\N	\N	\N	6	48	2013-05-20
7503	lente	\N	\N	\N	6	48	2013-05-20
7504	rapide	\N	\N	\N	6	48	2013-05-21
7505	rapide	\N	\N	\N	6	48	2013-05-25
7506	rapide	\N	\N	\N	6	48	2013-05-20
7507	rapide	\N	\N	\N	6	48	2013-05-20
7508	rapide	\N	\N	\N	6	48	2013-05-21
7509	rapide	\N	\N	\N	6	48	2013-05-25
7510	rapide	\N	\N	\N	6	48	2013-05-20
7511	rapide	\N	\N	\N	6	48	2013-05-21
7512	rapide	\N	\N	\N	6	48	2013-05-20
8001	lente	\N	\N	\N	6	48	2014-05-03
8002	4	\N	\N	\N	16	53	2014-05-03
8003	lente	\N	\N	\N	6	48	2014-05-06
8004	5	\N	\N	\N	16	53	2014-05-06
8005	rapide	\N	\N	\N	6	48	2014-05-10
8006	2	\N	\N	\N	16	53	2014-05-10
8007	rapide	\N	\N	\N	6	48	2014-05-08
8008	5	\N	\N	\N	16	53	2014-05-08
8009	rapide	\N	\N	\N	6	48	2014-05-07
8010	5	\N	\N	\N	16	53	2014-05-07
8011	lente	\N	\N	\N	6	48	2014-05-02
8012	2	\N	\N	\N	16	53	2014-05-02
8013	lente	\N	\N	\N	6	48	2014-05-03
8014	3	\N	\N	\N	16	53	2014-05-03
8015	rapide	\N	\N	\N	6	48	2014-05-06
8016	3	\N	\N	\N	16	53	2014-05-06
8017	rapide	\N	\N	\N	6	48	2014-05-03
8018	2	\N	\N	\N	16	53	2014-05-03
8019	rapide	\N	\N	\N	6	48	2014-05-06
8020	1	\N	\N	\N	16	53	2014-05-06
8021	lente	\N	\N	\N	6	48	2014-05-10
8022	4	\N	\N	\N	16	53	2014-05-10
8023	lente	\N	\N	\N	6	48	2014-05-03
8024	5	\N	\N	\N	16	53	2014-05-03
8025	rapide	\N	\N	\N	6	48	2014-05-06
8026	2	\N	\N	\N	16	53	2014-05-06
8027	rapide	\N	\N	\N	6	48	2014-05-03
8028	5	\N	\N	\N	16	53	2014-05-03
8029	rapide	\N	\N	\N	6	48	2014-05-03
8030	2	\N	\N	\N	16	53	2014-05-03
8031	lente	\N	\N	\N	6	48	2014-05-06
8032	3	\N	\N	\N	16	53	2014-05-06
8033	lente	\N	\N	\N	6	48	2014-05-10
8034	1	\N	\N	\N	16	53	2014-05-10
8035	rapide	\N	\N	\N	6	48	2014-05-08
8036	2	\N	\N	\N	16	53	2014-05-08
8037	rapide	\N	\N	\N	6	48	2014-05-07
8038	2	\N	\N	\N	16	53	2014-05-07
8039	rapide	\N	\N	\N	6	48	2014-05-02
8040	5	\N	\N	\N	16	53	2014-05-02
8041	lente	\N	\N	\N	6	48	2014-05-06
8042	3	\N	\N	\N	16	53	2014-05-06
8043	lente	\N	\N	\N	6	48	2014-05-10
8044	2	\N	\N	\N	16	53	2014-05-10
8045	rapide	\N	\N	\N	6	48	2014-05-08
8046	5	\N	\N	\N	16	53	2014-05-08
8047	rapide	\N	\N	\N	6	48	2014-05-07
8048	4	\N	\N	\N	16	53	2014-05-07
8049	rapide	\N	\N	\N	6	48	2014-05-02
8050	4	\N	\N	\N	16	53	2014-05-02
8051	lente	\N	\N	\N	6	48	2014-05-08
8052	1	\N	\N	\N	16	53	2014-05-08
8053	lente	\N	\N	\N	6	48	2014-05-07
8054	5	\N	\N	\N	16	53	2014-05-07
6908	volée	\N	\N	\N	4	41	2013-11-01
6909	200	\N	\N	\N	3	40	\N
6910	volée	\N	\N	\N	4	41	2013-11-01
6911	200	\N	\N	\N	3	40	\N
6912	volée	\N	\N	\N	4	41	2013-11-01
6913	200	\N	\N	\N	3	40	\N
6914	volée	\N	\N	\N	4	41	2013-11-01
6915	200	\N	\N	\N	3	40	\N
6916	volée	\N	\N	\N	4	41	2013-11-01
6917	200	\N	\N	\N	3	40	\N
6918	volée	\N	\N	\N	4	41	2013-11-01
6919	200	\N	\N	\N	3	40	\N
6920	semoir	\N	\N	\N	4	41	2013-10-25
6921	150	\N	\N	\N	3	40	\N
6922	semoir	\N	\N	\N	4	41	2013-10-25
6923	150	\N	\N	\N	3	40	\N
6924	semoir	\N	\N	\N	4	41	2013-10-25
6925	150	\N	\N	\N	3	40	\N
6926	semoir	\N	\N	\N	4	41	2013-10-25
6927	150	\N	\N	\N	3	40	\N
6928	semoir	\N	\N	\N	4	41	2013-11-05
6929	180	\N	\N	\N	3	40	\N
6930	semoir	\N	\N	\N	4	41	2013-11-05
6931	180	\N	\N	\N	3	40	\N
6932	semoir	\N	\N	\N	4	41	2013-11-05
6933	180	\N	\N	\N	3	40	\N
6934	semoir	\N	\N	\N	4	41	2013-11-05
6935	180	\N	\N	\N	3	40	\N
6936	semoir	\N	\N	\N	4	41	2013-11-05
6937	180	\N	\N	\N	3	40	\N
6938	semoir	\N	\N	\N	4	41	2013-11-05
6939	180	\N	\N	\N	3	40	\N
7245	faible	\N	\N	\N	5	47	2012-02-15
7246	moyen	\N	\N	\N	5	47	2012-02-15
7247	fort	\N	\N	\N	5	47	2012-02-15
7248	fort	\N	\N	\N	5	47	2012-02-15
7249	faible	\N	\N	\N	5	47	2012-02-15
7250	faible	\N	\N	\N	5	47	2012-02-15
7251	faible	\N	\N	\N	5	47	2012-02-15
7513	manuelle	\N	\N	\N	14	31	2013-07-14
7514	53	\N	\N	\N	8	33	2013-07-04
7515	manuelle	\N	\N	\N	14	31	2013-07-14
7516	48	\N	\N	\N	8	33	2013-07-04
7517	manuelle	\N	\N	\N	14	31	2013-07-14
7518	47	\N	\N	\N	8	33	2013-07-04
7519	manuelle	\N	\N	\N	14	31	2013-07-14
7520	50	\N	\N	\N	8	33	2013-07-04
7521	manuelle	\N	\N	\N	14	31	2013-07-14
7522	41	\N	\N	\N	8	33	2013-07-04
7523	manuelle	\N	\N	\N	14	31	2013-07-14
7524	50	\N	\N	\N	8	33	2013-07-04
7525	manuelle	\N	\N	\N	14	31	2013-07-07
7526	46	\N	\N	\N	8	33	2013-07-04
7527	manuelle	\N	\N	\N	14	31	2013-07-07
7528	53	\N	\N	\N	8	33	2013-07-04
7529	manuelle	\N	\N	\N	14	31	2013-07-07
7530	48	\N	\N	\N	8	33	2013-07-04
7531	manuelle	\N	\N	\N	14	31	2013-07-07
7532	47	\N	\N	\N	8	33	2013-07-04
7533	manuelle	\N	\N	\N	14	31	2013-07-24
7534	41	\N	\N	\N	8	33	2013-07-04
7535	manuelle	\N	\N	\N	14	31	2013-07-24
7536	50	\N	\N	\N	8	33	2013-07-04
7537	manuelle	\N	\N	\N	14	31	2013-07-24
7538	53	\N	\N	\N	8	33	2013-07-04
7539	manuelle	\N	\N	\N	14	31	2013-07-24
7540	48	\N	\N	\N	8	33	2013-07-04
7541	manuelle	\N	\N	\N	14	31	2013-07-24
7542	47	\N	\N	\N	8	33	2013-07-04
7543	manuelle	\N	\N	\N	14	31	2013-07-24
7544	50	\N	\N	\N	8	33	2013-07-04
8055	58.99	\N	\N	\N	22	34	2014-08-20
8056	manuelle	\N	\N	\N	14	31	2014-07-01
8057	1	\N	\N	\N	17	32	2014-07-01
6940	blé droit légerement courbé	\N	\N	\N	15	45	\N
6941	56	\N	\N	\N	8	46	2013-07-15
6942	épi barbu (et qql non barbus) blé droit (un peu de verse mais peu)	\N	\N	\N	15	45	\N
6943	54	\N	\N	\N	8	46	2013-07-15
6944	épis bien courbés	\N	\N	\N	15	45	\N
6945	58	\N	\N	\N	8	46	2013-07-15
6946	blablabla	\N	\N	\N	15	45	\N
6947	55	\N	\N	\N	8	46	2013-07-15
6948	blablabla	\N	\N	\N	15	45	\N
6949	60	\N	\N	\N	8	46	2013-07-19
6950	blablabla	\N	\N	\N	15	45	\N
6951	59	\N	\N	\N	8	46	2013-07-19
6952	blablabla	\N	\N	\N	15	45	\N
6953	53	\N	\N	\N	8	46	2013-07-19
7252	lente	\N	\N	\N	6	48	2012-05-20
7253	lente	\N	\N	\N	6	48	2012-05-21
7254	lente	\N	\N	\N	6	48	2012-05-25
7255	rapide	\N	\N	\N	6	48	2012-05-20
7256	rapide	\N	\N	\N	6	48	2012-05-21
7257	rapide	\N	\N	\N	6	48	2012-05-20
7258	lente	\N	\N	\N	6	48	2012-05-20
7545	blé droit légerement courbé	\N	\N	\N	15	45	\N
7546	56	\N	\N	\N	8	46	2013-07-15
7547	épi barbu (et qql non barbus) blé droit (un peu de verse mais peu)	\N	\N	\N	15	45	\N
7548	54	\N	\N	\N	8	46	2013-07-15
7549	épis bien courbés	\N	\N	\N	15	45	\N
7550	58	\N	\N	\N	8	46	2013-07-15
7551	blablabla	\N	\N	\N	15	45	\N
7552	55	\N	\N	\N	8	46	2013-07-15
7553	blablabla	\N	\N	\N	15	45	\N
7554	60	\N	\N	\N	8	46	2013-07-19
7555	blablabla	\N	\N	\N	15	45	\N
7556	59	\N	\N	\N	8	46	2013-07-19
7557	blablabla	\N	\N	\N	15	45	\N
7558	53	\N	\N	\N	8	46	2013-07-19
8058	58.99	\N	\N	\N	22	34	2014-08-20
8059	manuelle	\N	\N	\N	14	31	2014-07-01
8060	1	\N	\N	\N	17	32	2014-07-01
6954	volée	\N	\N	\N	4	41	2013-11-01
6955	200	\N	\N	\N	3	40	2013-11-01
6956	volée	\N	\N	\N	4	41	2013-11-01
6957	200	\N	\N	\N	3	40	2013-11-01
6958	volée	\N	\N	\N	4	41	2013-11-01
6959	200	\N	\N	\N	3	40	2013-11-01
6960	volée	\N	\N	\N	4	41	2013-11-01
6961	200	\N	\N	\N	3	40	2013-11-01
6962	volée	\N	\N	\N	4	41	2013-11-01
6963	200	\N	\N	\N	3	40	2013-11-01
6964	volée	\N	\N	\N	4	41	2013-11-01
6965	200	\N	\N	\N	3	40	2013-11-01
6966	volée	\N	\N	\N	4	41	2013-11-01
6967	200	\N	\N	\N	3	40	2013-11-01
6968	volée	\N	\N	\N	4	41	2013-11-01
6969	200	\N	\N	\N	3	40	2013-11-01
6970	volée	\N	\N	\N	4	41	2013-11-01
6971	200	\N	\N	\N	3	40	2013-11-01
6972	volée	\N	\N	\N	4	41	2013-11-01
6973	200	\N	\N	\N	3	40	2013-11-01
6974	volée	\N	\N	\N	4	41	2013-11-01
6975	200	\N	\N	\N	3	40	2013-11-01
6976	volée	\N	\N	\N	4	41	2013-11-01
6977	200	\N	\N	\N	3	40	2013-11-01
6978	semoir	\N	\N	\N	4	41	2013-11-01
6979	150	\N	\N	\N	3	40	2013-11-01
6980	semoir	\N	\N	\N	4	41	2013-11-01
6981	150	\N	\N	\N	3	40	2013-11-01
6982	semoir	\N	\N	\N	4	41	2013-11-01
6983	150	\N	\N	\N	3	40	2013-11-01
6984	semoir	\N	\N	\N	4	41	2013-11-01
6985	150	\N	\N	\N	3	40	2013-11-01
6986	semoir	\N	\N	\N	4	41	2013-11-01
6987	150	\N	\N	\N	3	40	2013-11-01
6988	semoir	\N	\N	\N	4	41	2013-11-01
6989	180	\N	\N	\N	3	40	2013-11-01
6990	semoir	\N	\N	\N	4	41	2013-11-01
6991	180	\N	\N	\N	3	40	2013-11-01
6992	semoir	\N	\N	\N	4	41	2013-11-01
6993	180	\N	\N	\N	3	40	2013-11-01
6994	semoir	\N	\N	\N	4	41	2013-11-01
6995	180	\N	\N	\N	3	40	2013-11-01
6996	semoir	\N	\N	\N	4	41	2013-11-01
6997	180	\N	\N	\N	3	40	2013-11-01
6998	semoir	\N	\N	\N	4	41	2013-11-01
6999	180	\N	\N	\N	3	40	2013-11-01
7000	semoir	\N	\N	\N	4	41	2013-11-01
7001	180	\N	\N	\N	3	40	2013-11-01
7002	semoir	\N	\N	\N	4	41	2013-11-01
7003	180	\N	\N	\N	3	40	2013-11-01
7004	semoir	\N	\N	\N	4	41	2013-11-01
7005	180	\N	\N	\N	3	40	2013-11-01
7006	semoir	\N	\N	\N	4	41	2013-11-01
7007	180	\N	\N	\N	3	40	2013-11-01
7259	manuelle	\N	\N	\N	14	31	2012-07-14
7260	53	\N	\N	\N	8	33	2012-07-04
7261	manuelle	\N	\N	\N	14	31	2012-07-14
7262	48	\N	\N	\N	8	33	2012-07-04
7263	manuelle	\N	\N	\N	14	31	2012-07-14
7264	47	\N	\N	\N	8	33	2012-07-04
7265	manuelle	\N	\N	\N	14	31	2012-07-14
7266	50	\N	\N	\N	8	33	2012-07-04
7267	manuelle	\N	\N	\N	14	31	2012-07-14
7268	41	\N	\N	\N	8	33	2012-07-04
7269	manuelle	\N	\N	\N	14	31	2012-07-14
7270	50	\N	\N	\N	8	33	2012-07-04
7271	manuelle	\N	\N	\N	14	31	2012-07-14
7272	46	\N	\N	\N	8	33	2012-07-04
7559	2	A_2013	\N	1	9	50	2013-07-04
7560	2.61	B_2013	\N	1	11	52	2013-07-23
7561	171.1	A_2013	\N	1	7	49	2013-07-04
7562	0	B_2013	\N	1	10	51	2013-07-23
7563	2	A_2013	\N	2	9	50	2013-07-04
7564	2.96	B_2013	\N	2	11	52	2013-07-23
7565	154.7	A_2013	\N	2	7	49	2013-07-04
7566	0	B_2013	\N	2	10	51	2013-07-23
7567	2	A_2013	\N	3	9	50	2013-07-04
7568	3.39	B_2013	\N	3	11	52	2013-07-23
7569	123.8	A_2013	\N	3	7	49	2013-07-04
7570	0	B_2013	\N	3	10	51	2013-07-23
7571	2	A_2013	\N	4	9	50	2013-07-04
7572	4.40	B_2013	\N	4	11	52	2013-07-23
7573	125.0	A_2013	\N	4	7	49	2013-07-04
7574	0	B_2013	\N	4	10	51	2013-07-23
7575	2	A_2013	\N	5	9	50	2013-07-04
7576	3.37	B_2013	\N	5	11	52	2013-07-23
7577	133.1	A_2013	\N	5	7	49	2013-07-04
7578	0	B_2013	\N	5	10	51	2013-07-23
7579	0	A_2013	\N	1	9	50	2013-07-04
7580	4.75	B_2013	\N	1	11	52	2013-07-23
7581	153.0	A_2013	\N	1	7	49	2013-07-04
7582	1	B_2013	\N	1	10	51	2013-07-23
7583	0	A_2013	\N	2	9	50	2013-07-04
7584	1.51	B_2013	\N	2	11	52	2013-07-23
7585	160.4	A_2013	\N	2	7	49	2013-07-04
7586	1	B_2013	\N	2	10	51	2013-07-23
7587	0	A_2013	\N	3	9	50	2013-07-04
7588	1.71	B_2013	\N	3	11	52	2013-07-23
7589	160.8	A_2013	\N	3	7	49	2013-07-04
7590	1	B_2013	\N	3	10	51	2013-07-23
7591	0	A_2013	\N	4	9	50	2013-07-04
7592	2.81	B_2013	\N	4	11	52	2013-07-23
7593	153.3	A_2013	\N	4	7	49	2013-07-04
7594	1	B_2013	\N	4	10	51	2013-07-23
8061	58.99	\N	\N	\N	22	33	2014-08-20
8062	manuelle	\N	\N	\N	14	31	2014-07-01
8063	1	\N	\N	\N	17	32	2014-07-01
7008	volée	\N	\N	\N	4	41	2013-11-01
7009	200	\N	\N	\N	3	40	2013-11-01
7010	volée	\N	\N	\N	4	41	2013-11-01
7011	200	\N	\N	\N	3	40	2013-11-01
7012	volée	\N	\N	\N	4	41	2013-11-01
7013	200	\N	\N	\N	3	40	2013-11-01
7014	volée	\N	\N	\N	4	41	2013-11-01
7015	200	\N	\N	\N	3	40	2013-11-01
7016	volée	\N	\N	\N	4	41	2013-11-01
7017	200	\N	\N	\N	3	40	2013-11-01
7018	volée	\N	\N	\N	4	41	2013-11-01
7019	200	\N	\N	\N	3	40	2013-11-01
7020	volée	\N	\N	\N	4	41	2013-11-01
7021	200	\N	\N	\N	3	40	2013-11-01
7022	volée	\N	\N	\N	4	41	2013-11-01
7023	200	\N	\N	\N	3	40	2013-11-01
7024	volée	\N	\N	\N	4	41	2013-11-01
7025	200	\N	\N	\N	3	40	2013-11-01
7026	volée	\N	\N	\N	4	41	2013-11-01
7027	200	\N	\N	\N	3	40	2013-11-01
7028	volée	\N	\N	\N	4	41	2013-11-01
7029	200	\N	\N	\N	3	40	2013-11-01
7030	volée	\N	\N	\N	4	41	2013-11-01
7031	200	\N	\N	\N	3	40	2013-11-01
7032	semoir	\N	\N	\N	4	41	2013-11-01
7033	150	\N	\N	\N	3	40	2013-11-01
7034	semoir	\N	\N	\N	4	41	2013-11-01
7035	150	\N	\N	\N	3	40	2013-11-01
7036	semoir	\N	\N	\N	4	41	2013-11-01
7037	150	\N	\N	\N	3	40	2013-11-01
7038	semoir	\N	\N	\N	4	41	2013-11-01
7039	150	\N	\N	\N	3	40	2013-11-01
7040	semoir	\N	\N	\N	4	41	2013-11-01
7041	150	\N	\N	\N	3	40	2013-11-01
7042	semoir	\N	\N	\N	4	41	2013-11-01
7043	180	\N	\N	\N	3	40	2013-11-01
7044	semoir	\N	\N	\N	4	41	2013-11-01
7045	180	\N	\N	\N	3	40	2013-11-01
7046	semoir	\N	\N	\N	4	41	2013-11-01
7047	180	\N	\N	\N	3	40	2013-11-01
7048	semoir	\N	\N	\N	4	41	2013-11-01
7049	180	\N	\N	\N	3	40	2013-11-01
7050	semoir	\N	\N	\N	4	41	2013-11-01
7051	180	\N	\N	\N	3	40	2013-11-01
7052	semoir	\N	\N	\N	4	41	2013-11-01
7053	180	\N	\N	\N	3	40	2013-11-01
7054	semoir	\N	\N	\N	4	41	2013-11-01
7055	180	\N	\N	\N	3	40	2013-11-01
7056	semoir	\N	\N	\N	4	41	2013-11-01
7057	180	\N	\N	\N	3	40	2013-11-01
7058	semoir	\N	\N	\N	4	41	2013-11-01
7059	180	\N	\N	\N	3	40	2013-11-01
7060	semoir	\N	\N	\N	4	41	2013-11-01
7061	180	\N	\N	\N	3	40	2013-11-01
7273	2	A_2013	\N	1	9	50	2012-07-04
7274	3.45	B_2013	\N	1	11	52	2012-08-02
7275	156.1	A_2013	\N	1	7	49	2012-07-04
7276	0	B_2013	\N	1	10	51	2012-08-02
7277	2	A_2013	\N	2	9	50	2012-07-04
7278	2.13	B_2013	\N	2	11	52	2012-08-02
7279	178.1	A_2013	\N	2	7	49	2012-07-04
7280	0	B_2013	\N	2	10	51	2012-08-02
7281	2	A_2013	\N	3	9	50	2012-07-04
7282	4.54	B_2013	\N	3	11	52	2012-08-02
7283	147.0	A_2013	\N	3	7	49	2012-07-04
7284	0	B_2013	\N	3	10	51	2012-08-02
7285	2	A_2013	\N	4	9	50	2012-07-04
7286	4.59	B_2013	\N	4	11	52	2012-08-02
7287	133.9	A_2013	\N	4	7	49	2012-07-04
7288	0	B_2013	\N	4	10	51	2012-08-02
7289	2	A_2013	\N	5	9	50	2012-07-04
7290	4.64	B_2013	\N	5	11	52	2012-08-02
7291	148.7	A_2013	\N	5	7	49	2012-07-04
7292	0	B_2013	\N	5	10	51	2012-08-02
7293	0	A_2013	\N	1	9	50	2012-07-04
7294	2.65	B_2013	\N	1	11	52	2012-08-02
7295	138.8	A_2013	\N	1	7	49	2012-07-04
7296	1	B_2013	\N	1	10	51	2012-08-02
7297	0	A_2013	\N	2	9	50	2012-07-04
7298	3.11	B_2013	\N	2	11	52	2012-08-02
7299	151.0	A_2013	\N	2	7	49	2012-07-04
7300	1	B_2013	\N	2	10	51	2012-08-02
7301	0	A_2013	\N	3	9	50	2012-07-04
7302	1.85	B_2013	\N	3	11	52	2012-08-02
7303	130.6	A_2013	\N	3	7	49	2012-07-04
7304	1	B_2013	\N	3	10	51	2012-08-02
7305	0	A_2013	\N	4	9	50	2012-07-04
7306	1.64	B_2013	\N	4	11	52	2012-08-02
7307	132.6	A_2013	\N	4	7	49	2012-07-04
7308	1	B_2013	\N	4	10	51	2012-08-02
7309	0	A_2013	\N	5	9	50	2012-07-04
7310	2.19	B_2013	\N	5	11	52	2012-08-02
7311	136.2	A_2013	\N	5	7	49	2012-07-04
7312	1	B_2013	\N	5	10	51	2012-08-02
7313	0	A_2013	\N	1	9	50	2012-07-04
7314	1.64	B_2013	\N	1	11	52	2012-08-02
7315	133.2	A_2013	\N	1	7	49	2012-07-04
7595	0	A_2013	\N	5	9	50	2013-07-04
7596	4.34	B_2013	\N	5	11	52	2013-07-23
7597	130.7	A_2013	\N	5	7	49	2013-07-04
7598	1	B_2013	\N	5	10	51	2013-07-23
7599	0	A_2013	\N	1	9	50	2013-07-04
7600	1.68	B_2013	\N	1	11	52	2013-07-23
7601	168.7	A_2013	\N	1	7	49	2013-07-04
7602	2	B_2013	\N	1	10	51	2013-07-23
7603	1	A_2013	\N	2	9	50	2013-07-04
7604	2.49	B_2013	\N	2	11	52	2013-07-23
7605	157.5	A_2013	\N	2	7	49	2013-07-04
7606	2	B_2013	\N	2	10	51	2013-07-23
7607	1	A_2013	\N	3	9	50	2013-07-04
7608	2.72	B_2013	\N	3	11	52	2013-07-23
7609	178.6	A_2013	\N	3	7	49	2013-07-04
7610	2	B_2013	\N	3	10	51	2013-07-23
7611	0	A_2013	\N	4	9	50	2013-07-04
7612	2.15	B_2013	\N	4	11	52	2013-07-23
7613	152.7	A_2013	\N	4	7	49	2013-07-04
7614	2	B_2013	\N	4	10	51	2013-07-23
8064	58.99	\N	\N	\N	22	33	2014-08-20
8065	manuelle	\N	\N	\N	14	31	2014-07-01
8066	1	\N	\N	\N	17	32	2014-07-01
7062	volée	\N	\N	\N	4	41	2013-11-01
7063	200	\N	\N	\N	3	40	2013-11-01
7064	volée	\N	\N	\N	4	41	2013-11-01
7065	200	\N	\N	\N	3	40	2013-11-01
7066	volée	\N	\N	\N	4	41	2013-11-01
7067	200	\N	\N	\N	3	40	2013-11-01
7068	volée	\N	\N	\N	4	41	2013-11-01
7069	200	\N	\N	\N	3	40	2013-11-01
7070	volée	\N	\N	\N	4	41	2013-11-01
7071	200	\N	\N	\N	3	40	2013-11-01
7072	volée	\N	\N	\N	4	41	2013-11-01
7073	200	\N	\N	\N	3	40	2013-11-01
7074	volée	\N	\N	\N	4	41	2013-11-01
7075	200	\N	\N	\N	3	40	2013-11-01
7076	volée	\N	\N	\N	4	41	2013-11-01
7077	200	\N	\N	\N	3	40	2013-11-01
7078	volée	\N	\N	\N	4	41	2013-11-01
7079	200	\N	\N	\N	3	40	2013-11-01
7080	volée	\N	\N	\N	4	41	2013-11-01
7081	200	\N	\N	\N	3	40	2013-11-01
7082	volée	\N	\N	\N	4	41	2013-11-01
7083	200	\N	\N	\N	3	40	2013-11-01
7084	volée	\N	\N	\N	4	41	2013-11-01
7085	200	\N	\N	\N	3	40	2013-11-01
7086	semoir	\N	\N	\N	4	41	2013-11-01
7087	150	\N	\N	\N	3	40	2013-11-01
7088	semoir	\N	\N	\N	4	41	2013-11-01
7089	150	\N	\N	\N	3	40	2013-11-01
7090	semoir	\N	\N	\N	4	41	2013-11-01
7091	150	\N	\N	\N	3	40	2013-11-01
7092	semoir	\N	\N	\N	4	41	2013-11-01
7093	150	\N	\N	\N	3	40	2013-11-01
7094	semoir	\N	\N	\N	4	41	2013-11-01
7095	150	\N	\N	\N	3	40	2013-11-01
7096	semoir	\N	\N	\N	4	41	2013-11-01
7097	180	\N	\N	\N	3	40	2013-11-01
7098	semoir	\N	\N	\N	4	41	2013-11-01
7099	180	\N	\N	\N	3	40	2013-11-01
7100	semoir	\N	\N	\N	4	41	2013-11-01
7101	180	\N	\N	\N	3	40	2013-11-01
7102	semoir	\N	\N	\N	4	41	2013-11-01
7103	180	\N	\N	\N	3	40	2013-11-01
7104	semoir	\N	\N	\N	4	41	2013-11-01
7105	180	\N	\N	\N	3	40	2013-11-01
7106	semoir	\N	\N	\N	4	41	2013-11-01
7107	180	\N	\N	\N	3	40	2013-11-01
7108	semoir	\N	\N	\N	4	41	2013-11-01
7109	180	\N	\N	\N	3	40	2013-11-01
7110	semoir	\N	\N	\N	4	41	2013-11-01
7111	180	\N	\N	\N	3	40	2013-11-01
7112	semoir	\N	\N	\N	4	41	2013-11-01
7113	180	\N	\N	\N	3	40	2013-11-01
7114	semoir	\N	\N	\N	4	41	2013-11-01
7115	180	\N	\N	\N	3	40	2013-11-01
7316	2	B_2013	\N	1	10	51	2012-08-02
7317	1	A_2013	\N	2	9	50	2012-07-04
7318	2.95	B_2013	\N	2	11	52	2012-08-02
7319	124.7	A_2013	\N	2	7	49	2012-07-04
7320	2	B_2013	\N	2	10	51	2012-08-02
7321	1	A_2013	\N	3	9	50	2012-07-04
7322	2.82	B_2013	\N	3	11	52	2012-08-02
7323	128.4	A_2013	\N	3	7	49	2012-07-04
7324	2	B_2013	\N	3	10	51	2012-08-02
7325	0	A_2013	\N	4	9	50	2012-07-04
7326	1.98	B_2013	\N	4	11	52	2012-08-02
7327	129.5	A_2013	\N	4	7	49	2012-07-04
7328	2	B_2013	\N	4	10	51	2012-08-02
7329	1	A_2013	\N	5	9	50	2012-07-04
7330	2.94	B_2013	\N	5	11	52	2012-08-02
7331	139.4	A_2013	\N	5	7	49	2012-07-04
7332	2	B_2013	\N	5	10	51	2012-08-02
7333	2	A_2013	\N	1	9	50	2012-07-04
7334	4.78	B_2013	\N	1	11	52	2012-08-02
7335	142.4	A_2013	\N	1	7	49	2012-07-04
7336	1	B_2013	\N	1	10	51	2012-08-02
7337	1	A_2013	\N	2	9	50	2012-07-04
7338	1.62	B_2013	\N	2	11	52	2012-08-02
7339	170.6	A_2013	\N	2	7	49	2012-07-04
7340	2	B_2013	\N	2	10	51	2012-08-02
7341	2	A_2013	\N	3	9	50	2012-07-04
7342	3.53	B_2013	\N	3	11	52	2012-08-02
7343	179.0	A_2013	\N	3	7	49	2012-07-04
7344	2	B_2013	\N	3	10	51	2012-08-02
7345	2	A_2013	\N	4	9	50	2012-07-04
7346	4.23	B_2013	\N	4	11	52	2012-08-02
7347	136.2	A_2013	\N	4	7	49	2012-07-04
7348	1	B_2013	\N	4	10	51	2012-08-02
7349	1	A_2013	\N	5	9	50	2012-07-04
7350	4.15	B_2013	\N	5	11	52	2012-08-02
7351	153.1	A_2013	\N	5	7	49	2012-07-04
7352	2	B_2013	\N	5	10	51	2012-08-02
7353	0	A_2013	\N	1	9	50	2012-07-04
7354	4.54	B_2013	\N	1	11	52	2012-08-02
7355	157.4	A_2013	\N	1	7	49	2012-07-04
7356	2	B_2013	\N	1	10	51	2012-08-02
7357	0	A_2013	\N	2	9	50	2012-07-04
7358	4.81	B_2013	\N	2	11	52	2012-08-02
7359	139.0	A_2013	\N	2	7	49	2012-07-04
7360	2	B_2013	\N	2	10	51	2012-08-02
7615	1	A_2013	\N	5	9	50	2013-07-04
7616	1.94	B_2013	\N	5	11	52	2013-07-23
7617	161.5	A_2013	\N	5	7	49	2013-07-04
7618	2	B_2013	\N	5	10	51	2013-07-23
7619	2	A_2013	\N	1	9	50	2013-07-04
7620	2.36	B_2013	\N	1	11	52	2013-07-23
7621	149.7	A_2013	\N	1	7	49	2013-07-04
7622	1	B_2013	\N	1	10	51	2013-07-23
7623	1	A_2013	\N	2	9	50	2013-07-04
7624	3.61	B_2013	\N	2	11	52	2013-07-23
7625	171.1	A_2013	\N	2	7	49	2013-07-04
7626	2	B_2013	\N	2	10	51	2013-07-23
7627	2	A_2013	\N	3	9	50	2013-07-04
7628	2.88	B_2013	\N	3	11	52	2013-07-23
7629	167.2	A_2013	\N	3	7	49	2013-07-04
7630	2	B_2013	\N	3	10	51	2013-07-23
7631	2	A_2013	\N	4	9	50	2013-07-04
7632	2.14	B_2013	\N	4	11	52	2013-07-23
7633	138.5	A_2013	\N	4	7	49	2013-07-04
7634	1	B_2013	\N	4	10	51	2013-07-23
8067	manuelle	\N	\N	\N	14	31	2014-07-01
8068	1	\N	\N	\N	17	32	2014-07-01
7116	volée	\N	\N	\N	4	41	2013-11-01
7117	200	\N	\N	\N	3	40	2013-11-01
7118	volée	\N	\N	\N	4	41	2013-11-01
7119	200	\N	\N	\N	3	40	2013-11-01
7120	volée	\N	\N	\N	4	41	2013-11-01
7121	200	\N	\N	\N	3	40	2013-11-01
7122	volée	\N	\N	\N	4	41	2013-11-01
7123	200	\N	\N	\N	3	40	2013-11-01
7124	volée	\N	\N	\N	4	41	2013-11-01
7125	200	\N	\N	\N	3	40	2013-11-01
7126	volée	\N	\N	\N	4	41	2013-11-01
7127	200	\N	\N	\N	3	40	2013-11-01
7128	volée	\N	\N	\N	4	41	2013-11-01
7129	200	\N	\N	\N	3	40	2013-11-01
7130	volée	\N	\N	\N	4	41	2013-11-01
7131	200	\N	\N	\N	3	40	2013-11-01
7132	volée	\N	\N	\N	4	41	2013-11-01
7133	200	\N	\N	\N	3	40	2013-11-01
7134	volée	\N	\N	\N	4	41	2013-11-01
7135	200	\N	\N	\N	3	40	2013-11-01
7136	volée	\N	\N	\N	4	41	2013-11-01
7137	200	\N	\N	\N	3	40	2013-11-01
7138	volée	\N	\N	\N	4	41	2013-11-01
7139	200	\N	\N	\N	3	40	2013-11-01
7140	volée	\N	\N	\N	4	41	2013-11-01
7141	200	\N	\N	\N	3	40	2013-11-01
7142	volée	\N	\N	\N	4	41	2013-11-01
7143	200	\N	\N	\N	3	40	2013-11-01
7144	semoir	\N	\N	\N	4	41	2013-11-01
7145	150	\N	\N	\N	3	40	2013-11-01
7146	semoir	\N	\N	\N	4	41	2013-11-01
7147	150	\N	\N	\N	3	40	2013-11-01
7148	semoir	\N	\N	\N	4	41	2013-11-01
7149	150	\N	\N	\N	3	40	2013-11-01
7150	semoir	\N	\N	\N	4	41	2013-11-01
7151	150	\N	\N	\N	3	40	2013-11-01
7152	semoir	\N	\N	\N	4	41	2013-11-01
7153	150	\N	\N	\N	3	40	2013-11-01
7154	semoir	\N	\N	\N	4	41	2013-11-01
7155	180	\N	\N	\N	3	40	2013-11-01
7156	semoir	\N	\N	\N	4	41	2013-11-01
7157	180	\N	\N	\N	3	40	2013-11-01
7158	semoir	\N	\N	\N	4	41	2013-11-01
7159	180	\N	\N	\N	3	40	2013-11-01
7160	semoir	\N	\N	\N	4	41	2013-11-01
7161	180	\N	\N	\N	3	40	2013-11-01
7162	semoir	\N	\N	\N	4	41	2013-11-01
7163	180	\N	\N	\N	3	40	2013-11-01
7164	semoir	\N	\N	\N	4	41	2013-11-01
7165	180	\N	\N	\N	3	40	2013-11-01
7166	semoir	\N	\N	\N	4	41	2013-11-01
7167	180	\N	\N	\N	3	40	2013-11-01
7168	semoir	\N	\N	\N	4	41	2013-11-01
7169	180	\N	\N	\N	3	40	2013-11-01
7170	semoir	\N	\N	\N	4	41	2013-11-01
7171	180	\N	\N	\N	3	40	2013-11-01
7172	semoir	\N	\N	\N	4	41	2013-11-01
7173	180	\N	\N	\N	3	40	2013-11-01
7361	0	A_2013	\N	3	9	50	2012-07-04
7362	1.54	B_2013	\N	3	11	52	2012-08-02
7363	130.6	A_2013	\N	3	7	49	2012-07-04
7364	2	B_2013	\N	3	10	51	2012-08-02
7365	0	A_2013	\N	4	9	50	2012-07-04
7366	1.55	B_2013	\N	4	11	52	2012-08-02
7367	136.2	A_2013	\N	4	7	49	2012-07-04
7368	2	B_2013	\N	4	10	51	2012-08-02
7369	0	A_2013	\N	5	9	50	2012-07-04
7370	3.83	B_2013	\N	5	11	52	2012-08-02
7371	164.6	A_2013	\N	5	7	49	2012-07-04
7372	0	B_2013	\N	5	10	51	2012-08-02
7373	1	A_2013	\N	1	9	50	2012-07-04
7374	2.63	B_2013	\N	1	11	52	2012-08-02
7375	123.3	A_2013	\N	1	7	49	2012-07-04
7376	1	B_2013	\N	1	10	51	2012-08-02
7377	1	A_2013	\N	2	9	50	2012-07-04
7378	4.57	B_2013	\N	2	11	52	2012-08-02
7379	120.5	A_2013	\N	2	7	49	2012-07-04
7380	1	B_2013	\N	2	10	51	2012-08-02
7381	1	A_2013	\N	3	9	50	2012-07-04
7382	2.02	B_2013	\N	3	11	52	2012-08-02
7383	126.1	A_2013	\N	3	7	49	2012-07-04
7384	2	B_2013	\N	3	10	51	2012-08-02
7385	1	A_2013	\N	4	9	50	2012-07-04
7386	2.18	B_2013	\N	4	11	52	2012-08-02
7387	178.3	A_2013	\N	4	7	49	2012-07-04
7388	2	B_2013	\N	4	10	51	2012-08-02
7389	1	A_2013	\N	5	9	50	2012-07-04
7390	4.47	B_2013	\N	5	11	52	2012-08-02
7391	147.6	A_2013	\N	5	7	49	2012-07-04
7392	2	B_2013	\N	5	10	51	2012-08-02
7393	2	A_2013	\N	1	9	50	2012-07-04
7394	3.78	B_2013	\N	1	11	52	2012-08-02
7395	153.0	A_2013	\N	1	7	49	2012-07-04
7396	0	B_2013	\N	1	10	51	2012-08-02
7397	2	A_2013	\N	2	9	50	2012-07-04
7398	2.56	B_2013	\N	2	11	52	2012-08-02
7399	162.4	A_2013	\N	2	7	49	2012-07-04
7400	2	B_2013	\N	2	10	51	2012-08-02
7401	2	A_2013	\N	3	9	50	2012-07-04
7402	3.63	B_2013	\N	3	11	52	2012-08-02
7403	174.4	A_2013	\N	3	7	49	2012-07-04
7635	1	A_2013	\N	5	9	50	2013-07-04
7636	3.30	B_2013	\N	5	11	52	2013-07-23
7637	172.6	A_2013	\N	5	7	49	2013-07-04
7638	2	B_2013	\N	5	10	51	2013-07-23
7639	0	A_2013	\N	1	9	50	2013-07-04
7640	2.92	B_2013	\N	1	11	52	2013-07-23
7641	127.4	A_2013	\N	1	7	49	2013-07-04
7642	2	B_2013	\N	1	10	51	2013-07-23
7643	0	A_2013	\N	2	9	50	2013-07-04
7644	2.15	B_2013	\N	2	11	52	2013-07-23
7645	151.4	A_2013	\N	2	7	49	2013-07-04
7646	2	B_2013	\N	2	10	51	2013-07-23
7647	0	A_2013	\N	3	9	50	2013-07-04
7648	4.84	B_2013	\N	3	11	52	2013-07-23
7649	129.4	A_2013	\N	3	7	49	2013-07-04
7650	2	B_2013	\N	3	10	51	2013-07-23
7651	0	A_2013	\N	4	9	50	2013-07-04
7652	4.72	B_2013	\N	4	11	52	2013-07-23
7653	170.1	A_2013	\N	4	7	49	2013-07-04
8069	manuelle	\N	\N	\N	14	31	2014-07-01
8070	1	\N	\N	\N	17	32	2014-07-01
7174	volée	\N	\N	\N	4	41	2013-11-01
7175	200	\N	\N	\N	3	40	2013-11-01
7176	volée	\N	\N	\N	4	41	2013-11-01
7177	200	\N	\N	\N	3	40	2013-11-01
7178	volée	\N	\N	\N	4	41	2013-11-01
7179	200	\N	\N	\N	3	40	2013-11-01
7180	volée	\N	\N	\N	4	41	2013-11-01
7181	200	\N	\N	\N	3	40	2013-11-01
7182	volée	\N	\N	\N	4	41	2013-11-01
7183	200	\N	\N	\N	3	40	2013-11-01
7184	volée	\N	\N	\N	4	41	2013-11-01
7185	200	\N	\N	\N	3	40	2013-11-01
7186	volée	\N	\N	\N	4	41	2013-11-01
7187	200	\N	\N	\N	3	40	2013-11-01
7188	volée	\N	\N	\N	4	41	2013-11-01
7189	200	\N	\N	\N	3	40	2013-11-01
7190	volée	\N	\N	\N	4	41	2013-11-01
7191	200	\N	\N	\N	3	40	2013-11-01
7192	volée	\N	\N	\N	4	41	2013-11-01
7193	200	\N	\N	\N	3	40	2013-11-01
7194	volée	\N	\N	\N	4	41	2013-11-01
7195	200	\N	\N	\N	3	40	2013-11-01
7196	volée	\N	\N	\N	4	41	2013-11-01
7197	200	\N	\N	\N	3	40	2013-11-01
7198	semoir	\N	\N	\N	4	41	2013-11-01
7199	150	\N	\N	\N	3	40	2013-11-01
7200	semoir	\N	\N	\N	4	41	2013-11-01
7201	150	\N	\N	\N	3	40	2013-11-01
7202	semoir	\N	\N	\N	4	41	2013-11-01
7203	150	\N	\N	\N	3	40	2013-11-01
7204	semoir	\N	\N	\N	4	41	2013-11-01
7205	150	\N	\N	\N	3	40	2013-11-01
7206	semoir	\N	\N	\N	4	41	2013-11-01
7207	150	\N	\N	\N	3	40	2013-11-01
7208	semoir	\N	\N	\N	4	41	2013-11-01
7209	180	\N	\N	\N	3	40	2013-11-01
7210	semoir	\N	\N	\N	4	41	2013-11-01
7211	180	\N	\N	\N	3	40	2013-11-01
7212	semoir	\N	\N	\N	4	41	2013-11-01
7213	180	\N	\N	\N	3	40	2013-11-01
7214	semoir	\N	\N	\N	4	41	2013-11-01
7215	180	\N	\N	\N	3	40	2013-11-01
7216	semoir	\N	\N	\N	4	41	2013-11-01
7217	180	\N	\N	\N	3	40	2013-11-01
7218	semoir	\N	\N	\N	4	41	2013-11-01
7219	180	\N	\N	\N	3	40	2013-11-01
7220	semoir	\N	\N	\N	4	41	2013-11-01
7221	180	\N	\N	\N	3	40	2013-11-01
7222	semoir	\N	\N	\N	4	41	2013-11-01
7223	180	\N	\N	\N	3	40	2013-11-01
7224	semoir	\N	\N	\N	4	41	2013-11-01
7225	180	\N	\N	\N	3	40	2013-11-01
7226	semoir	\N	\N	\N	4	41	2013-11-01
7227	180	\N	\N	\N	3	40	2013-11-01
7404	1	B_2013	\N	3	10	51	2012-08-02
7405	2	A_2013	\N	4	9	50	2012-07-04
7406	2.45	B_2013	\N	4	11	52	2012-08-02
7407	136.4	A_2013	\N	4	7	49	2012-07-04
7408	2	B_2013	\N	4	10	51	2012-08-02
7409	0	A_2013	\N	5	9	50	2012-07-04
7410	2.71	B_2013	\N	5	11	52	2012-08-02
7411	133.5	A_2013	\N	5	7	49	2012-07-04
7412	1	B_2013	\N	5	10	51	2012-08-02
7654	2	B_2013	\N	4	10	51	2013-07-23
7655	0	A_2013	\N	5	9	50	2013-07-04
7656	3.29	B_2013	\N	5	11	52	2013-07-23
7657	164.1	A_2013	\N	5	7	49	2013-07-04
7658	0	B_2013	\N	5	10	51	2013-07-23
7659	1	A_2013	\N	1	9	50	2013-07-04
7660	3.63	B_2013	\N	1	11	52	2013-07-23
7661	167.5	A_2013	\N	1	7	49	2013-07-04
7662	1	B_2013	\N	1	10	51	2013-07-23
7663	1	A_2013	\N	2	9	50	2013-07-04
7664	4.53	B_2013	\N	2	11	52	2013-07-23
7665	153.9	A_2013	\N	2	7	49	2013-07-04
7666	1	B_2013	\N	2	10	51	2013-07-23
7667	1	A_2013	\N	3	9	50	2013-07-04
7668	2.67	B_2013	\N	3	11	52	2013-07-23
7669	164.9	A_2013	\N	3	7	49	2013-07-04
7670	2	B_2013	\N	3	10	51	2013-07-23
7671	1	A_2013	\N	4	9	50	2013-07-04
7672	2.39	B_2013	\N	4	11	52	2013-07-23
7673	170.8	A_2013	\N	4	7	49	2013-07-04
7674	2	B_2013	\N	4	10	51	2013-07-23
7675	1	A_2013	\N	5	9	50	2013-07-04
7676	4.96	B_2013	\N	5	11	52	2013-07-23
7677	172.8	A_2013	\N	5	7	49	2013-07-04
7678	2	B_2013	\N	5	10	51	2013-07-23
7679	2	C_2013	\N	1	9	50	2013-07-04
7680	2.42	C_2013	\N	1	11	52	2013-07-23
7681	164.8	C_2013	\N	1	7	49	2013-07-04
7682	0	C_2013	\N	1	10	51	2013-07-23
7683	2	C_2013	\N	2	9	50	2013-07-04
7684	4.82	C_2013	\N	2	11	52	2013-07-23
7685	140.0	C_2013	\N	2	7	49	2013-07-04
7686	2	C_2013	\N	2	10	51	2013-07-23
7687	2	C_2013	\N	3	9	50	2013-07-04
7688	4.05	C_2013	\N	3	11	52	2013-07-23
7689	177.1	C_2013	\N	3	7	49	2013-07-04
7690	1	C_2013	\N	3	10	51	2013-07-23
7691	2	C_2013	\N	4	9	50	2013-07-04
7692	2.23	C_2013	\N	4	11	52	2013-07-23
7693	137.4	C_2013	\N	4	7	49	2013-07-04
8071	manuelle	\N	\N	\N	14	31	2014-07-01
8072	1	\N	\N	\N	17	32	2014-07-01
7413	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
7414	ok	\N	\N	\N	12	43	\N
7415	1	\N	\N	\N	13	44	\N
7416	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
7417	bof	\N	\N	\N	12	43	\N
7418	1	\N	\N	\N	13	44	\N
7419	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
7420	ok	\N	\N	\N	12	43	\N
7421	1	\N	\N	\N	13	44	\N
7422	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
7423	ok	\N	\N	\N	12	43	\N
7424	1	\N	\N	\N	13	44	\N
7425	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
7426	ok	\N	\N	\N	12	43	\N
7427	1	\N	\N	\N	13	44	\N
7428	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
7429	ok	\N	\N	\N	12	43	\N
7430	1	\N	\N	\N	13	44	\N
7431	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
7432	ok	\N	\N	\N	12	43	\N
7433	1	\N	\N	\N	13	44	\N
7434	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
7435	ok	\N	\N	\N	12	43	\N
7436	1	\N	\N	\N	13	44	\N
7437	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
7438	ok	\N	\N	\N	12	43	\N
7439	1	\N	\N	\N	13	44	\N
7440	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
7441	ok	\N	\N	\N	12	43	\N
7442	1	\N	\N	\N	13	44	\N
7443	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
7444	ok	\N	\N	\N	12	43	\N
7445	1	\N	\N	\N	13	44	\N
7446	JFB a choisi selon son expertise	\N	\N	\N	1	42	2012-05-05
7447	ok	\N	\N	\N	12	43	\N
7448	1	\N	\N	\N	13	44	\N
7694	2	C_2013	\N	4	10	51	2013-07-23
7695	0	C_2013	\N	5	9	50	2013-07-04
7696	2.33	C_2013	\N	5	11	52	2013-07-23
7697	153.0	C_2013	\N	5	7	49	2013-07-04
7698	1	C_2013	\N	5	10	51	2013-07-23
7699	2	C_2013	\N	1	9	50	2013-07-04
7700	3.09	C_2013	\N	1	11	52	2013-07-23
7701	179.0	C_2013	\N	1	7	49	2013-07-04
7702	0	C_2013	\N	1	10	51	2013-07-23
7703	2	C_2013	\N	2	9	50	2013-07-04
7704	1.63	C_2013	\N	2	11	52	2013-07-23
7705	139.5	C_2013	\N	2	7	49	2013-07-04
7706	0	C_2013	\N	2	10	51	2013-07-23
7707	2	C_2013	\N	3	9	50	2013-07-04
7708	1.85	C_2013	\N	3	11	52	2013-07-23
7709	122.2	C_2013	\N	3	7	49	2013-07-04
7710	0	C_2013	\N	3	10	51	2013-07-23
7711	2	C_2013	\N	4	9	50	2013-07-04
7712	3.03	C_2013	\N	4	11	52	2013-07-23
7713	124.8	C_2013	\N	4	7	49	2013-07-04
7714	0	C_2013	\N	4	10	51	2013-07-23
7715	2	C_2013	\N	5	9	50	2013-07-04
7716	4.12	C_2013	\N	5	11	52	2013-07-23
7717	120.4	C_2013	\N	5	7	49	2013-07-04
7718	0	C_2013	\N	5	10	51	2013-07-23
7719	0	C_2013	\N	1	9	50	2013-07-04
7720	4.40	C_2013	\N	1	11	52	2013-07-23
7721	140.7	C_2013	\N	1	7	49	2013-07-04
7722	1	C_2013	\N	1	10	51	2013-07-23
7723	0	C_2013	\N	2	9	50	2013-07-04
7724	3.45	C_2013	\N	2	11	52	2013-07-23
7725	158.5	C_2013	\N	2	7	49	2013-07-04
7726	1	C_2013	\N	2	10	51	2013-07-23
7727	0	C_2013	\N	3	9	50	2013-07-04
7728	3.58	C_2013	\N	3	11	52	2013-07-23
7729	168.4	C_2013	\N	3	7	49	2013-07-04
7730	1	C_2013	\N	3	10	51	2013-07-23
7731	0	C_2013	\N	4	9	50	2013-07-04
7732	3.08	C_2013	\N	4	11	52	2013-07-23
7733	175.6	C_2013	\N	4	7	49	2013-07-04
7734	1	C_2013	\N	4	10	51	2013-07-23
7735	0	C_2013	\N	5	9	50	2013-07-04
7736	1.51	C_2013	\N	5	11	52	2013-07-23
7737	163.1	C_2013	\N	5	7	49	2013-07-04
7738	1	C_2013	\N	5	10	51	2013-07-23
7739	0	C_2013	\N	1	9	50	2013-07-04
7740	4.30	C_2013	\N	1	11	52	2013-07-23
7741	148.0	C_2013	\N	1	7	49	2013-07-04
7742	2	C_2013	\N	1	10	51	2013-07-23
7743	1	C_2013	\N	2	9	50	2013-07-04
8073	blablabla	\N	\N	\N	15	45	\N
8074	55.24	\N	\N	\N	8	46	2014-08-20
8075	blablabla	\N	\N	\N	15	45	\N
8076	59	\N	\N	\N	8	46	2014-08-20
7449	volée	\N	\N	\N	4	41	2013-11-01
7450	200	\N	\N	\N	3	40	\N
7451	volée	\N	\N	\N	4	41	2013-11-01
7452	200	\N	\N	\N	3	40	\N
7453	volée	\N	\N	\N	4	41	2013-11-01
7454	200	\N	\N	\N	3	40	\N
7455	volée	\N	\N	\N	4	41	2013-11-01
7456	200	\N	\N	\N	3	40	\N
7457	volée	\N	\N	\N	4	41	2013-11-01
7458	200	\N	\N	\N	3	40	\N
7459	volée	\N	\N	\N	4	41	2013-11-01
7460	200	\N	\N	\N	3	40	\N
7461	semoir	\N	\N	\N	4	41	2013-10-25
7462	150	\N	\N	\N	3	40	\N
7463	semoir	\N	\N	\N	4	41	2013-10-25
7464	150	\N	\N	\N	3	40	\N
7465	semoir	\N	\N	\N	4	41	2013-10-25
7466	150	\N	\N	\N	3	40	\N
7467	semoir	\N	\N	\N	4	41	2013-10-25
7468	150	\N	\N	\N	3	40	\N
7469	semoir	\N	\N	\N	4	41	2013-11-05
7470	180	\N	\N	\N	3	40	\N
7471	semoir	\N	\N	\N	4	41	2013-11-05
7472	180	\N	\N	\N	3	40	\N
7473	semoir	\N	\N	\N	4	41	2013-11-05
7474	180	\N	\N	\N	3	40	\N
7475	semoir	\N	\N	\N	4	41	2013-11-05
7476	180	\N	\N	\N	3	40	\N
7477	semoir	\N	\N	\N	4	41	2013-11-05
7478	180	\N	\N	\N	3	40	\N
7479	semoir	\N	\N	\N	4	41	2013-11-05
7480	180	\N	\N	\N	3	40	\N
7744	4.61	C_2013	\N	2	11	52	2013-07-23
7745	157.0	C_2013	\N	2	7	49	2013-07-04
7746	2	C_2013	\N	2	10	51	2013-07-23
7747	1	C_2013	\N	3	9	50	2013-07-04
7748	4.76	C_2013	\N	3	11	52	2013-07-23
7749	128.7	C_2013	\N	3	7	49	2013-07-04
7750	2	C_2013	\N	3	10	51	2013-07-23
7751	0	C_2013	\N	4	9	50	2013-07-04
7752	3.91	C_2013	\N	4	11	52	2013-07-23
7753	160.7	C_2013	\N	4	7	49	2013-07-04
7754	2	C_2013	\N	4	10	51	2013-07-23
7755	1	C_2013	\N	5	9	50	2013-07-04
7756	2.82	C_2013	\N	5	11	52	2013-07-23
7757	150.7	C_2013	\N	5	7	49	2013-07-04
7758	2	C_2013	\N	5	10	51	2013-07-23
7759	2	A_2013	\N	1	9	50	2013-07-04
7760	1.53	B_2013	\N	1	11	52	2013-07-23
7761	177.2	A_2013	\N	1	7	49	2013-07-04
7762	1	B_2013	\N	1	10	51	2013-07-23
7763	1	A_2013	\N	2	9	50	2013-07-04
7764	2.32	B_2013	\N	2	11	52	2013-07-23
7765	146.1	A_2013	\N	2	7	49	2013-07-04
7766	2	B_2013	\N	2	10	51	2013-07-23
7767	2	A_2013	\N	3	9	50	2013-07-04
7768	2.12	B_2013	\N	3	11	52	2013-07-23
7769	142.7	A_2013	\N	3	7	49	2013-07-04
7770	2	B_2013	\N	3	10	51	2013-07-23
7771	2	A_2013	\N	4	9	50	2013-07-04
7772	3.73	B_2013	\N	4	11	52	2013-07-23
7773	123.4	A_2013	\N	4	7	49	2013-07-04
7774	1	B_2013	\N	4	10	51	2013-07-23
7775	1	A_2013	\N	5	9	50	2013-07-04
7776	3.95	B_2013	\N	5	11	52	2013-07-23
7777	147.4	A_2013	\N	5	7	49	2013-07-04
7778	2	B_2013	\N	5	10	51	2013-07-23
7779	0	A_2013	\N	1	9	50	2013-07-04
7780	3.79	B_2013	\N	1	11	52	2013-07-23
7781	143.2	A_2013	\N	1	7	49	2013-07-04
7782	2	B_2013	\N	1	10	51	2013-07-23
7783	0	A_2013	\N	2	9	50	2013-07-04
7784	3.40	B_2013	\N	2	11	52	2013-07-23
7785	162.5	A_2013	\N	2	7	49	2013-07-04
7786	2	B_2013	\N	2	10	51	2013-07-23
7787	0	A_2013	\N	3	9	50	2013-07-04
7788	2.34	B_2013	\N	3	11	52	2013-07-23
7789	172.0	A_2013	\N	3	7	49	2013-07-04
7790	2	B_2013	\N	3	10	51	2013-07-23
7791	0	A_2013	\N	4	9	50	2013-07-04
7792	2.87	B_2013	\N	4	11	52	2013-07-23
7793	144.0	A_2013	\N	4	7	49	2013-07-04
7794	2	B_2013	\N	4	10	51	2013-07-23
7795	0	A_2013	\N	5	9	50	2013-07-04
7796	4.61	B_2013	\N	5	11	52	2013-07-23
7797	166.7	A_2013	\N	5	7	49	2013-07-04
8077	2	A_2014	\N	1	9	50	2014-07-29
8078	2.70	B_2014	\N	1	11	52	2014-07-31
8079	147.0	A_2014	\N	1	7	49	2014-07-29
8080	0	B_2014	\N	1	10	51	2014-07-31
8081	2	A_2014	\N	2	9	50	2014-07-29
8082	3.07	B_2014	\N	2	11	52	2014-07-31
8083	133.9	A_2014	\N	2	7	49	2014-07-29
8084	0	B_2014	\N	2	10	51	2014-07-31
8085	2	A_2014	\N	3	9	50	2014-07-29
8086	3.78	B_2014	\N	3	11	52	2014-07-31
8087	148.7	A_2014	\N	3	7	49	2014-07-29
8088	0	B_2014	\N	3	10	51	2014-07-31
8089	2	A_2014	\N	4	9	50	2014-07-29
8090	2.62	B_2014	\N	4	11	52	2014-07-31
8091	138.8	A_2014	\N	4	7	49	2014-07-29
8092	0	B_2014	\N	4	10	51	2014-07-31
8093	2	A_2014	\N	5	9	50	2014-07-29
8094	1.57	B_2014	\N	5	11	52	2014-07-31
8095	151.0	A_2014	\N	5	7	49	2014-07-29
8096	0	B_2014	\N	5	10	51	2014-07-31
8097	0	A_2014	\N	1	9	50	2014-07-29
8098	2.61	B_2014	\N	1	11	52	2014-07-31
8099	130.6	A_2014	\N	1	7	49	2014-07-29
8100	1	B_2014	\N	1	10	51	2014-07-31
7798	0	B_2013	\N	5	10	51	2013-07-23
7799	1	A_2013	\N	1	9	50	2013-07-04
7800	2.17	B_2013	\N	1	11	52	2013-07-23
7801	140.2	A_2013	\N	1	7	49	2013-07-04
7802	1	B_2013	\N	1	10	51	2013-07-23
7803	1	A_2013	\N	2	9	50	2013-07-04
7804	1.59	B_2013	\N	2	11	52	2013-07-23
7805	160.0	A_2013	\N	2	7	49	2013-07-04
7806	1	B_2013	\N	2	10	51	2013-07-23
7807	1	A_2013	\N	3	9	50	2013-07-04
7808	1.79	B_2013	\N	3	11	52	2013-07-23
7809	129.4	A_2013	\N	3	7	49	2013-07-04
7810	2	B_2013	\N	3	10	51	2013-07-23
7811	1	A_2013	\N	4	9	50	2013-07-04
7812	4.05	B_2013	\N	4	11	52	2013-07-23
7813	140.5	A_2013	\N	4	7	49	2013-07-04
7814	2	B_2013	\N	4	10	51	2013-07-23
7815	1	A_2013	\N	5	9	50	2013-07-04
7816	4.12	B_2013	\N	5	11	52	2013-07-23
7817	125.6	A_2013	\N	5	7	49	2013-07-04
7818	2	B_2013	\N	5	10	51	2013-07-23
7819	2	A_2013	\N	1	9	50	2013-07-04
7820	2.77	B_2013	\N	1	11	52	2013-07-23
7821	121.0	A_2013	\N	1	7	49	2013-07-04
7822	0	B_2013	\N	1	10	51	2013-07-23
7823	2	A_2013	\N	2	9	50	2013-07-04
7824	4.19	B_2013	\N	2	11	52	2013-07-23
7825	150.0	A_2013	\N	2	7	49	2013-07-04
7826	2	B_2013	\N	2	10	51	2013-07-23
7827	2	A_2013	\N	3	9	50	2013-07-04
7828	2.45	B_2013	\N	3	11	52	2013-07-23
7829	125.3	A_2013	\N	3	7	49	2013-07-04
7830	1	B_2013	\N	3	10	51	2013-07-23
7831	2	A_2013	\N	4	9	50	2013-07-04
7832	1.77	B_2013	\N	4	11	52	2013-07-23
7833	164.9	A_2013	\N	4	7	49	2013-07-04
7834	2	B_2013	\N	4	10	51	2013-07-23
7835	0	A_2013	\N	5	9	50	2013-07-04
7836	4.89	B_2013	\N	5	11	52	2013-07-23
7837	129.2	A_2013	\N	5	7	49	2013-07-04
7838	1	B_2013	\N	5	10	51	2013-07-23
7839	2	A_2013	\N	1	9	50	2013-07-04
7840	3.75	B_2013	\N	1	11	52	2013-07-23
7841	124.8	A_2013	\N	1	7	49	2013-07-04
7842	0	B_2013	\N	1	10	51	2013-07-23
7843	2	A_2013	\N	2	9	50	2013-07-04
7844	4.25	B_2013	\N	2	11	52	2013-07-23
7845	133.8	A_2013	\N	2	7	49	2013-07-04
7846	0	B_2013	\N	2	10	51	2013-07-23
7847	2	A_2013	\N	3	9	50	2013-07-04
7848	2.14	B_2013	\N	3	11	52	2013-07-23
7849	175.1	A_2013	\N	3	7	49	2013-07-04
7850	0	B_2013	\N	3	10	51	2013-07-23
7851	2	A_2013	\N	4	9	50	2013-07-04
7852	2.98	B_2013	\N	4	11	52	2013-07-23
7853	128.5	A_2013	\N	4	7	49	2013-07-04
7854	0	B_2013	\N	4	10	51	2013-07-23
7855	2	A_2013	\N	5	9	50	2013-07-04
7856	2.52	B_2013	\N	5	11	52	2013-07-23
7857	139.3	A_2013	\N	5	7	49	2013-07-04
7858	0	B_2013	\N	5	10	51	2013-07-23
7859	0	A_2013	\N	1	9	50	2013-07-04
7860	4.42	B_2013	\N	1	11	52	2013-07-23
7861	166.6	A_2013	\N	1	7	49	2013-07-04
7862	1	B_2013	\N	1	10	51	2013-07-23
7863	0	A_2013	\N	2	9	50	2013-07-04
7864	2.61	B_2013	\N	2	11	52	2013-07-23
7865	177.5	A_2013	\N	2	7	49	2013-07-04
8101	0	A_2014	\N	2	9	50	2014-07-29
8102	2.49	B_2014	\N	2	11	52	2014-07-31
8103	132.6	A_2014	\N	2	7	49	2014-07-29
8104	1	B_2014	\N	2	10	51	2014-07-31
8105	0	A_2014	\N	3	9	50	2014-07-29
8106	3.29	B_2014	\N	3	11	52	2014-07-31
8107	136.2	A_2014	\N	3	7	49	2014-07-29
8108	1	B_2014	\N	3	10	51	2014-07-31
8109	0	A_2014	\N	4	9	50	2014-07-29
8110	4.61	B_2014	\N	4	11	52	2014-07-31
8111	133.2	A_2014	\N	4	7	49	2014-07-29
8112	1	B_2014	\N	4	10	51	2014-07-31
8113	0	A_2014	\N	5	9	50	2014-07-29
8114	4.54	B_2014	\N	5	11	52	2014-07-31
8115	124.7	A_2014	\N	5	7	49	2014-07-29
8116	1	B_2014	\N	5	10	51	2014-07-31
8117	0	A_2014	\N	1	9	50	2014-07-29
8118	2.94	B_2014	\N	1	11	52	2014-07-31
8119	128.4	A_2014	\N	1	7	49	2014-07-29
8120	2	B_2014	\N	1	10	51	2014-07-31
8121	1	A_2014	\N	2	9	50	2014-07-29
8122	2.31	B_2014	\N	2	11	52	2014-07-31
8123	129.5	A_2014	\N	2	7	49	2014-07-29
8124	2	B_2014	\N	2	10	51	2014-07-31
8125	1	A_2014	\N	3	9	50	2014-07-29
8126	3.91	B_2014	\N	3	11	52	2014-07-31
8127	139.4	A_2014	\N	3	7	49	2014-07-29
8128	2	B_2014	\N	3	10	51	2014-07-31
8129	0	A_2014	\N	4	9	50	2014-07-29
8130	2.07	B_2014	\N	4	11	52	2014-07-31
7866	1	B_2013	\N	2	10	51	2013-07-23
7867	0	A_2013	\N	3	9	50	2013-07-04
7868	4.43	B_2013	\N	3	11	52	2013-07-23
7869	159.2	A_2013	\N	3	7	49	2013-07-04
7870	1	B_2013	\N	3	10	51	2013-07-23
7871	0	A_2013	\N	4	9	50	2013-07-04
7872	3.23	B_2013	\N	4	11	52	2013-07-23
7873	169.7	A_2013	\N	4	7	49	2013-07-04
7874	1	B_2013	\N	4	10	51	2013-07-23
7875	0	A_2013	\N	5	9	50	2013-07-04
7876	2.55	B_2013	\N	5	11	52	2013-07-23
7877	127.2	A_2013	\N	5	7	49	2013-07-04
7878	1	B_2013	\N	5	10	51	2013-07-23
7879	3.85	B_2013	\N	1	11	52	2013-07-23
7880	178.9	A_2013	\N	1	7	49	2013-07-04
7881	4.43	B_2013	\N	2	11	52	2013-07-23
7882	128.2	A_2013	\N	2	7	49	2013-07-04
7883	4.19	B_2013	\N	3	11	52	2013-07-23
7884	121.5	A_2013	\N	3	7	49	2013-07-04
7885	1.89	B_2013	\N	4	11	52	2013-07-23
7886	133.7	A_2013	\N	4	7	49	2013-07-04
7887	4.08	B_2013	\N	5	11	52	2013-07-23
7888	146.6	A_2013	\N	5	7	49	2013-07-04
7889	3.29	B_2013	\N	1	11	52	2013-07-23
7890	161.5	A_2013	\N	1	7	49	2013-07-04
7891	3.12	B_2013	\N	2	11	52	2013-07-23
7892	140.8	A_2013	\N	2	7	49	2013-07-04
7893	3.12	B_2013	\N	3	11	52	2013-07-23
7894	155.4	A_2013	\N	3	7	49	2013-07-04
7895	4.72	B_2013	\N	4	11	52	2013-07-23
7896	148.9	A_2013	\N	4	7	49	2013-07-04
7897	2.18	B_2013	\N	5	11	52	2013-07-23
7898	143.1	A_2013	\N	5	7	49	2013-07-04
7899	3.54	B_2013	\N	1	11	52	2013-07-23
7900	130.9	A_2013	\N	1	7	49	2013-07-04
7901	2.14	B_2013	\N	2	11	52	2013-07-23
7902	146.0	A_2013	\N	2	7	49	2013-07-04
7903	2.18	B_2013	\N	3	11	52	2013-07-23
7904	138.5	A_2013	\N	3	7	49	2013-07-04
7905	2.05	B_2013	\N	4	11	52	2013-07-23
7906	162.7	A_2013	\N	4	7	49	2013-07-04
7907	4.40	B_2013	\N	5	11	52	2013-07-23
7908	161.3	A_2013	\N	5	7	49	2013-07-04
7909	2.80	B_2013	\N	1	11	52	2013-07-23
7910	161.9	A_2013	\N	1	7	49	2013-07-04
7911	1.72	B_2013	\N	2	11	52	2013-07-23
7912	162.0	A_2013	\N	2	7	49	2013-07-04
7913	3.63	B_2013	\N	3	11	52	2013-07-23
7914	167.9	A_2013	\N	3	7	49	2013-07-04
7915	4.59	B_2013	\N	4	11	52	2013-07-23
7916	179.5	A_2013	\N	4	7	49	2013-07-04
7917	4.14	B_2013	\N	5	11	52	2013-07-23
7918	161.5	A_2013	\N	5	7	49	2013-07-04
7919	2.14	B_2013	\N	1	11	52	2013-07-23
7920	166.3	A_2013	\N	1	7	49	2013-07-04
7921	3.31	B_2013	\N	2	11	52	2013-07-23
7922	156.9	A_2013	\N	2	7	49	2013-07-04
7923	2.75	B_2013	\N	3	11	52	2013-07-23
7924	123.9	A_2013	\N	3	7	49	2013-07-04
7925	4.94	B_2013	\N	4	11	52	2013-07-23
7926	164.9	A_2013	\N	4	7	49	2013-07-04
7927	4.12	B_2013	\N	5	11	52	2013-07-23
7928	145.2	A_2013	\N	5	7	49	2013-07-04
7929	3.06	B_2013	\N	1	11	52	2013-07-23
7930	162.8	A_2013	\N	1	7	49	2013-07-04
7931	2.94	B_2013	\N	2	11	52	2013-07-23
8131	142.4	A_2014	\N	4	7	49	2014-07-29
8132	2	B_2014	\N	4	10	51	2014-07-31
8133	1	A_2014	\N	5	9	50	2014-07-29
8134	4.10	B_2014	\N	5	11	52	2014-07-31
8135	170.6	A_2014	\N	5	7	49	2014-07-29
8136	2	B_2014	\N	5	10	51	2014-07-31
8137	2	A_2014	\N	1	9	50	2014-07-29
8138	2.01	B_2014	\N	1	11	52	2014-07-31
8139	179.0	A_2014	\N	1	7	49	2014-07-29
8140	1	B_2014	\N	1	10	51	2014-07-31
8141	1	A_2014	\N	2	9	50	2014-07-29
8142	2.58	B_2014	\N	2	11	52	2014-07-31
8143	136.2	A_2014	\N	2	7	49	2014-07-29
8144	2	B_2014	\N	2	10	51	2014-07-31
8145	2	A_2014	\N	3	9	50	2014-07-29
8146	2.86	B_2014	\N	3	11	52	2014-07-31
8147	153.1	A_2014	\N	3	7	49	2014-07-29
8148	2	B_2014	\N	3	10	51	2014-07-31
8149	2	A_2014	\N	4	9	50	2014-07-29
8150	1.93	B_2014	\N	4	11	52	2014-07-31
8151	157.4	A_2014	\N	4	7	49	2014-07-29
8152	1	B_2014	\N	4	10	51	2014-07-31
8153	1	A_2014	\N	5	9	50	2014-07-29
8154	3.64	B_2014	\N	5	11	52	2014-07-31
8155	139.0	A_2014	\N	5	7	49	2014-07-29
8156	2	B_2014	\N	5	10	51	2014-07-31
8157	0	A_2014	\N	1	9	50	2014-07-29
8158	3.85	B_2014	\N	1	11	52	2014-07-31
8159	130.6	A_2014	\N	1	7	49	2014-07-29
8160	2	B_2014	\N	1	10	51	2014-07-31
8161	0	A_2014	\N	2	9	50	2014-07-29
7932	177.1	A_2013	\N	2	7	49	2013-07-04
7933	3.82	B_2013	\N	3	11	52	2013-07-23
7934	137.6	A_2013	\N	3	7	49	2013-07-04
7935	2.59	B_2013	\N	4	11	52	2013-07-23
7936	121.3	A_2013	\N	4	7	49	2013-07-04
7937	3.95	B_2013	\N	5	11	52	2013-07-23
7938	168.1	A_2013	\N	5	7	49	2013-07-04
7939	3.84	B_2013	\N	1	11	52	2013-07-23
7940	166.6	A_2013	\N	1	7	49	2013-07-04
7941	2.75	B_2013	\N	2	11	52	2013-07-23
7942	143.9	A_2013	\N	2	7	49	2013-07-04
7943	2.53	B_2013	\N	3	11	52	2013-07-23
7944	165.1	A_2013	\N	3	7	49	2013-07-04
7945	2.46	B_2013	\N	4	11	52	2013-07-23
7946	163.7	A_2013	\N	4	7	49	2013-07-04
8162	2.55	B_2014	\N	2	11	52	2014-07-31
8163	136.2	A_2014	\N	2	7	49	2014-07-29
8164	2	B_2014	\N	2	10	51	2014-07-31
8165	0	A_2014	\N	3	9	50	2014-07-29
8166	2.94	B_2014	\N	3	11	52	2014-07-31
8167	164.6	A_2014	\N	3	7	49	2014-07-29
8168	2	B_2014	\N	3	10	51	2014-07-31
8169	0	A_2014	\N	4	9	50	2014-07-29
8170	3.23	B_2014	\N	4	11	52	2014-07-31
8171	123.3	A_2014	\N	4	7	49	2014-07-29
8172	2	B_2014	\N	4	10	51	2014-07-31
8173	0	A_2014	\N	5	9	50	2014-07-29
8174	3.61	B_2014	\N	5	11	52	2014-07-31
8175	120.5	A_2014	\N	5	7	49	2014-07-29
8176	0	B_2014	\N	5	10	51	2014-07-31
8177	1	A_2014	\N	1	9	50	2014-07-29
8178	4.14	B_2014	\N	1	11	52	2014-07-31
8179	126.1	A_2014	\N	1	7	49	2014-07-29
8180	1	B_2014	\N	1	10	51	2014-07-31
8181	1	A_2014	\N	2	9	50	2014-07-29
8182	2.40	B_2014	\N	2	11	52	2014-07-31
8183	178.3	A_2014	\N	2	7	49	2014-07-29
8184	1	B_2014	\N	2	10	51	2014-07-31
8185	1	A_2014	\N	3	9	50	2014-07-29
8186	2.04	B_2014	\N	3	11	52	2014-07-31
8187	147.6	A_2014	\N	3	7	49	2014-07-29
8188	2	B_2014	\N	3	10	51	2014-07-31
8189	1	A_2014	\N	4	9	50	2014-07-29
8190	2.70	B_2014	\N	4	11	52	2014-07-31
8191	153.0	A_2014	\N	4	7	49	2014-07-29
8192	2	B_2014	\N	4	10	51	2014-07-31
8193	1	A_2014	\N	5	9	50	2014-07-29
8194	3.05	B_2014	\N	5	11	52	2014-07-31
8195	162.4	A_2014	\N	5	7	49	2014-07-29
8196	2	B_2014	\N	5	10	51	2014-07-31
8197	2	A_2014	\N	1	9	50	2014-07-29
8198	3.31	B_2014	\N	1	11	52	2014-07-31
8199	174.4	A_2014	\N	1	7	49	2014-07-29
8200	0	B_2014	\N	1	10	51	2014-07-31
8201	2	A_2014	\N	2	9	50	2014-07-29
8202	2.87	B_2014	\N	2	11	52	2014-07-31
8203	136.4	A_2014	\N	2	7	49	2014-07-29
8204	2	B_2014	\N	2	10	51	2014-07-31
8205	2	A_2014	\N	3	9	50	2014-07-29
8206	2.42	B_2014	\N	3	11	52	2014-07-31
8207	133.5	A_2014	\N	3	7	49	2014-07-29
8208	1	B_2014	\N	3	10	51	2014-07-31
8209	2	A_2014	\N	4	9	50	2014-07-29
8210	1.69	B_2014	\N	4	11	52	2014-07-31
8211	171.2	A_2014	\N	4	7	49	2014-07-29
8212	2	B_2014	\N	4	10	51	2014-07-31
8213	0	A_2014	\N	5	9	50	2014-07-29
8214	3.02	B_2014	\N	5	11	52	2014-07-31
8215	132.1	A_2014	\N	5	7	49	2014-07-29
8216	1	B_2014	\N	5	10	51	2014-07-31
8217	2	A_2014	\N	1	9	50	2014-07-29
8218	4.37	B_2014	\N	1	11	52	2014-07-31
8219	156.2	A_2014	\N	1	7	49	2014-07-29
8220	0	B_2014	\N	1	10	51	2014-07-31
8221	2	A_2014	\N	2	9	50	2014-07-29
8222	4.45	B_2014	\N	2	11	52	2014-07-31
8223	156.2	A_2014	\N	2	7	49	2014-07-29
8224	0	B_2014	\N	2	10	51	2014-07-31
8225	2	A_2014	\N	3	9	50	2014-07-29
8226	2.36	B_2014	\N	3	11	52	2014-07-31
8227	162.5	A_2014	\N	3	7	49	2014-07-29
8228	0	B_2014	\N	3	10	51	2014-07-31
8229	2	A_2014	\N	4	9	50	2014-07-29
8230	2.05	B_2014	\N	4	11	52	2014-07-31
8231	173.2	A_2014	\N	4	7	49	2014-07-29
8232	0	B_2014	\N	4	10	51	2014-07-31
8233	2	A_2014	\N	5	9	50	2014-07-29
8234	1.89	B_2014	\N	5	11	52	2014-07-31
8235	177.6	A_2014	\N	5	7	49	2014-07-29
8236	0	B_2014	\N	5	10	51	2014-07-31
8237	0	A_2014	\N	1	9	50	2014-07-29
8238	4.89	B_2014	\N	1	11	52	2014-07-31
8239	168.2	A_2014	\N	1	7	49	2014-07-29
8240	1	B_2014	\N	1	10	51	2014-07-31
8241	0	A_2014	\N	2	9	50	2014-07-29
8242	2.31	B_2014	\N	2	11	52	2014-07-31
8243	126.0	A_2014	\N	2	7	49	2014-07-29
8244	1	B_2014	\N	2	10	51	2014-07-31
8245	0	A_2014	\N	3	9	50	2014-07-29
8246	4.06	B_2014	\N	3	11	52	2014-07-31
8247	179.3	A_2014	\N	3	7	49	2014-07-29
8248	1	B_2014	\N	3	10	51	2014-07-31
8249	0	A_2014	\N	4	9	50	2014-07-29
8250	2.27	B_2014	\N	4	11	52	2014-07-31
8251	141.9	A_2014	\N	4	7	49	2014-07-29
8252	1	B_2014	\N	4	10	51	2014-07-31
8253	0	A_2014	\N	5	9	50	2014-07-29
8254	2.19	B_2014	\N	5	11	52	2014-07-31
8255	147.5	A_2014	\N	5	7	49	2014-07-29
8256	1	B_2014	\N	5	10	51	2014-07-31
8257	0	A_2014	\N	1	9	50	2014-07-29
8258	4.62	B_2014	\N	1	11	52	2014-07-31
8259	153.1	A_2014	\N	1	7	49	2014-07-29
8260	2	B_2014	\N	1	10	51	2014-07-31
8261	1	A_2014	\N	2	9	50	2014-07-29
8262	4.70	B_2014	\N	2	11	52	2014-07-31
8263	120.8	A_2014	\N	2	7	49	2014-07-29
8264	2	B_2014	\N	2	10	51	2014-07-31
8265	1	A_2014	\N	3	9	50	2014-07-29
8266	3.66	B_2014	\N	3	11	52	2014-07-31
8267	124.2	A_2014	\N	3	7	49	2014-07-29
8268	2	B_2014	\N	3	10	51	2014-07-31
8269	0	A_2014	\N	4	9	50	2014-07-29
8270	1.58	B_2014	\N	4	11	52	2014-07-31
8271	128.4	A_2014	\N	4	7	49	2014-07-29
8272	2	B_2014	\N	4	10	51	2014-07-31
8273	1	A_2014	\N	5	9	50	2014-07-29
8274	3.57	B_2014	\N	5	11	52	2014-07-31
8275	167.4	A_2014	\N	5	7	49	2014-07-29
8276	2	B_2014	\N	5	10	51	2014-07-31
8277	2	A_2014	\N	1	9	50	2014-07-29
8278	1.70	B_2014	\N	1	11	52	2014-07-31
8279	175.4	A_2014	\N	1	7	49	2014-07-29
8280	1	B_2014	\N	1	10	51	2014-07-31
8281	1	A_2014	\N	2	9	50	2014-07-29
8282	4.47	B_2014	\N	2	11	52	2014-07-31
8283	176.5	A_2014	\N	2	7	49	2014-07-29
8284	2	B_2014	\N	2	10	51	2014-07-31
8285	2	A_2014	\N	3	9	50	2014-07-29
8286	3.03	B_2014	\N	3	11	52	2014-07-31
8287	135.5	A_2014	\N	3	7	49	2014-07-29
8288	2	B_2014	\N	3	10	51	2014-07-31
8289	2	A_2014	\N	4	9	50	2014-07-29
8290	1.67	B_2014	\N	4	11	52	2014-07-31
8291	125.3	A_2014	\N	4	7	49	2014-07-29
8292	1	B_2014	\N	4	10	51	2014-07-31
8293	1	A_2014	\N	5	9	50	2014-07-29
8294	4.44	B_2014	\N	5	11	52	2014-07-31
8295	150.9	A_2014	\N	5	7	49	2014-07-29
8296	2	B_2014	\N	5	10	51	2014-07-31
8297	0	A_2014	\N	1	9	50	2014-07-29
8298	4.60	B_2014	\N	1	11	52	2014-07-31
8299	163.9	A_2014	\N	1	7	49	2014-07-29
8300	2	B_2014	\N	1	10	51	2014-07-31
8301	0	A_2014	\N	2	9	50	2014-07-29
8302	2.74	B_2014	\N	2	11	52	2014-07-31
8303	172.6	A_2014	\N	2	7	49	2014-07-29
8304	2	B_2014	\N	2	10	51	2014-07-31
8305	0	A_2014	\N	3	9	50	2014-07-29
8306	2.69	B_2014	\N	3	11	52	2014-07-31
8307	168.4	A_2014	\N	3	7	49	2014-07-29
8308	2	B_2014	\N	3	10	51	2014-07-31
8309	0	A_2014	\N	4	9	50	2014-07-29
8310	3.62	B_2014	\N	4	11	52	2014-07-31
8311	177.1	A_2014	\N	4	7	49	2014-07-29
8312	2	B_2014	\N	4	10	51	2014-07-31
8313	0	A_2014	\N	5	9	50	2014-07-29
8314	4.29	B_2014	\N	5	11	52	2014-07-31
8315	135.5	A_2014	\N	5	7	49	2014-07-29
8316	0	B_2014	\N	5	10	51	2014-07-31
8317	1	C_2014	\N	1	9	50	2014-07-29
8318	3.65	C_2014	\N	1	11	52	2014-07-04
8319	140.4	C_2014	\N	1	7	49	2014-07-29
8320	1	C_2014	\N	1	10	51	2014-07-29
8321	1	C_2014	\N	2	9	50	2014-07-29
8322	3.86	C_2014	\N	2	11	52	2014-07-04
8323	157.9	C_2014	\N	2	7	49	2014-07-29
8324	1	C_2014	\N	2	10	51	2014-07-29
8325	1	C_2014	\N	3	9	50	2014-07-29
8326	4.86	C_2014	\N	3	11	52	2014-07-04
8327	150.2	C_2014	\N	3	7	49	2014-07-29
8328	2	C_2014	\N	3	10	51	2014-07-29
8329	1	C_2014	\N	4	9	50	2014-07-29
8330	1.91	C_2014	\N	4	11	52	2014-07-04
8331	145.4	C_2014	\N	4	7	49	2014-07-29
8332	2	C_2014	\N	4	10	51	2014-07-29
8333	1	C_2014	\N	5	9	50	2014-07-29
8334	3.64	C_2014	\N	5	11	52	2014-07-04
8335	178.9	C_2014	\N	5	7	49	2014-07-29
8336	2	C_2014	\N	5	10	51	2014-07-29
8337	2	C_2014	\N	1	9	50	2014-07-29
8338	3.48	C_2014	\N	1	11	52	2014-07-04
8339	126.0	C_2014	\N	1	7	49	2014-07-29
8340	0	C_2014	\N	1	10	51	2014-07-29
8341	2	C_2014	\N	2	9	50	2014-07-29
8342	4.41	C_2014	\N	2	11	52	2014-07-04
8343	171.6	C_2014	\N	2	7	49	2014-07-29
8344	2	C_2014	\N	2	10	51	2014-07-29
8345	2	C_2014	\N	3	9	50	2014-07-29
8346	3.97	C_2014	\N	3	11	52	2014-07-04
8347	164.2	C_2014	\N	3	7	49	2014-07-29
8348	1	C_2014	\N	3	10	51	2014-07-29
8349	2	C_2014	\N	4	9	50	2014-07-29
8350	2.91	C_2014	\N	4	11	52	2014-07-04
8351	177.9	C_2014	\N	4	7	49	2014-07-29
8352	2	C_2014	\N	4	10	51	2014-07-29
8353	0	C_2014	\N	5	9	50	2014-07-29
8354	4.61	C_2014	\N	5	11	52	2014-07-04
8355	141.4	C_2014	\N	5	7	49	2014-07-29
8356	1	C_2014	\N	5	10	51	2014-07-29
8357	2	C_2014	\N	1	9	50	2014-07-29
8358	2.48	C_2014	\N	1	11	52	2014-07-04
8359	134.3	C_2014	\N	1	7	49	2014-07-29
8360	0	C_2014	\N	1	10	51	2014-07-29
8361	2	C_2014	\N	2	9	50	2014-07-29
8362	3.52	C_2014	\N	2	11	52	2014-07-04
8363	148.9	C_2014	\N	2	7	49	2014-07-29
8364	0	C_2014	\N	2	10	51	2014-07-29
8365	2	C_2014	\N	3	9	50	2014-07-29
8366	3.59	C_2014	\N	3	11	52	2014-07-04
8367	130.8	C_2014	\N	3	7	49	2014-07-29
8368	0	C_2014	\N	3	10	51	2014-07-29
8369	2	C_2014	\N	4	9	50	2014-07-29
8370	4.99	C_2014	\N	4	11	52	2014-07-04
8371	159.6	C_2014	\N	4	7	49	2014-07-29
8372	0	C_2014	\N	4	10	51	2014-07-29
8373	2	C_2014	\N	5	9	50	2014-07-29
8374	2.60	C_2014	\N	5	11	52	2014-07-04
8375	172.0	C_2014	\N	5	7	49	2014-07-29
8376	0	C_2014	\N	5	10	51	2014-07-29
8377	0	C_2014	\N	1	9	50	2014-07-29
8378	4.96	C_2014	\N	1	11	52	2014-07-04
8379	121.2	C_2014	\N	1	7	49	2014-07-29
8380	1	C_2014	\N	1	10	51	2014-07-29
8381	0	C_2014	\N	2	9	50	2014-07-29
8382	1.69	C_2014	\N	2	11	52	2014-07-04
8383	155.9	C_2014	\N	2	7	49	2014-07-29
8384	1	C_2014	\N	2	10	51	2014-07-29
8385	0	C_2014	\N	3	9	50	2014-07-29
8386	4.30	C_2014	\N	3	11	52	2014-07-04
8387	142.5	C_2014	\N	3	7	49	2014-07-29
8388	1	C_2014	\N	3	10	51	2014-07-29
8389	0	C_2014	\N	4	9	50	2014-07-29
8390	4.32	C_2014	\N	4	11	52	2014-07-04
8391	152.5	C_2014	\N	4	7	49	2014-07-29
8392	1	C_2014	\N	4	10	51	2014-07-29
8393	0	C_2014	\N	5	9	50	2014-07-29
8394	2.16	C_2014	\N	5	11	52	2014-07-04
8395	143.5	C_2014	\N	5	7	49	2014-07-29
8396	1	C_2014	\N	5	10	51	2014-07-29
8397	0	C_2014	\N	1	9	50	2014-07-29
8398	1.90	C_2014	\N	1	11	52	2014-07-04
8399	161.3	C_2014	\N	1	7	49	2014-07-29
8400	2	C_2014	\N	1	10	51	2014-07-29
8401	1	C_2014	\N	2	9	50	2014-07-29
8402	2.75	C_2014	\N	2	11	52	2014-07-04
8403	159.3	C_2014	\N	2	7	49	2014-07-29
8404	2	C_2014	\N	2	10	51	2014-07-29
8405	1	C_2014	\N	3	9	50	2014-07-29
8406	4.33	C_2014	\N	3	11	52	2014-07-04
8407	133.8	C_2014	\N	3	7	49	2014-07-29
8408	2	C_2014	\N	3	10	51	2014-07-29
8409	0	C_2014	\N	4	9	50	2014-07-29
8410	2.32	C_2014	\N	4	11	52	2014-07-04
8411	149.5	C_2014	\N	4	7	49	2014-07-29
8412	2	C_2014	\N	4	10	51	2014-07-29
8413	1	C_2014	\N	5	9	50	2014-07-29
8414	1.88	C_2014	\N	5	11	52	2014-07-04
8415	131.5	C_2014	\N	5	7	49	2014-07-29
8416	2	C_2014	\N	5	10	51	2014-07-29
8417	2	A_2014	\N	1	9	50	2014-07-29
8418	4.69	B_2014	\N	1	11	52	2014-07-31
8419	154.8	A_2014	\N	1	7	49	2014-07-29
8420	1	B_2014	\N	1	10	51	2014-07-31
8421	1	A_2014	\N	2	9	50	2014-07-29
8422	2.97	B_2014	\N	2	11	52	2014-07-31
8423	178.2	A_2014	\N	2	7	49	2014-07-29
8424	2	B_2014	\N	2	10	51	2014-07-31
8425	2	A_2014	\N	3	9	50	2014-07-29
8426	3.75	B_2014	\N	3	11	52	2014-07-31
8427	176.8	A_2014	\N	3	7	49	2014-07-29
8428	2	B_2014	\N	3	10	51	2014-07-31
8429	2	A_2014	\N	4	9	50	2014-07-29
8430	2.18	B_2014	\N	4	11	52	2014-07-31
8431	126.7	A_2014	\N	4	7	49	2014-07-29
8432	1	B_2014	\N	4	10	51	2014-07-31
8433	1	A_2014	\N	5	9	50	2014-07-29
8434	4.78	B_2014	\N	5	11	52	2014-07-31
8435	138.4	A_2014	\N	5	7	49	2014-07-29
8436	2	B_2014	\N	5	10	51	2014-07-31
8437	0	A_2014	\N	1	9	50	2014-07-29
8438	3.12	B_2014	\N	1	11	52	2014-07-31
8439	175.0	A_2014	\N	1	7	49	2014-07-29
8440	2	B_2014	\N	1	10	51	2014-07-31
8441	0	A_2014	\N	2	9	50	2014-07-29
8442	3.24	B_2014	\N	2	11	52	2014-07-31
8443	134.8	A_2014	\N	2	7	49	2014-07-29
8444	2	B_2014	\N	2	10	51	2014-07-31
8445	0	A_2014	\N	3	9	50	2014-07-29
8446	2.99	B_2014	\N	3	11	52	2014-07-31
8447	158.5	A_2014	\N	3	7	49	2014-07-29
8448	2	B_2014	\N	3	10	51	2014-07-31
8449	0	A_2014	\N	4	9	50	2014-07-29
8450	3.86	B_2014	\N	4	11	52	2014-07-31
8451	137.0	A_2014	\N	4	7	49	2014-07-29
8452	2	B_2014	\N	4	10	51	2014-07-31
8453	0	A_2014	\N	5	9	50	2014-07-29
8454	4.76	B_2014	\N	5	11	52	2014-07-31
8455	150.1	A_2014	\N	5	7	49	2014-07-29
8456	0	B_2014	\N	5	10	51	2014-07-31
8457	1	A_2014	\N	1	9	50	2014-07-29
8458	1.65	B_2014	\N	1	11	52	2014-07-31
8459	156.0	A_2014	\N	1	7	49	2014-07-29
8460	1	B_2014	\N	1	10	51	2014-07-31
8461	1	A_2014	\N	2	9	50	2014-07-29
8462	2.82	B_2014	\N	2	11	52	2014-07-31
8463	143.5	A_2014	\N	2	7	49	2014-07-29
8464	1	B_2014	\N	2	10	51	2014-07-31
8465	1	A_2014	\N	3	9	50	2014-07-29
8466	4.02	B_2014	\N	3	11	52	2014-07-31
8467	127.3	A_2014	\N	3	7	49	2014-07-29
8468	2	B_2014	\N	3	10	51	2014-07-31
8469	1	A_2014	\N	4	9	50	2014-07-29
8470	2.89	B_2014	\N	4	11	52	2014-07-31
8471	153.4	A_2014	\N	4	7	49	2014-07-29
8472	2	B_2014	\N	4	10	51	2014-07-31
8473	1	A_2014	\N	5	9	50	2014-07-29
8474	1.84	B_2014	\N	5	11	52	2014-07-31
8475	145.5	A_2014	\N	5	7	49	2014-07-29
8476	2	B_2014	\N	5	10	51	2014-07-31
8477	2	A_2014	\N	1	9	50	2014-07-29
8478	3.40	B_2014	\N	1	11	52	2014-07-31
8479	170.0	A_2014	\N	1	7	49	2014-07-29
8480	0	B_2014	\N	1	10	51	2014-07-31
8481	2	A_2014	\N	2	9	50	2014-07-29
8482	2.90	B_2014	\N	2	11	52	2014-07-31
8483	167.8	A_2014	\N	2	7	49	2014-07-29
8484	2	B_2014	\N	2	10	51	2014-07-31
8485	2	A_2014	\N	3	9	50	2014-07-29
8486	4.56	B_2014	\N	3	11	52	2014-07-31
8487	170.2	A_2014	\N	3	7	49	2014-07-29
8488	1	B_2014	\N	3	10	51	2014-07-31
8489	2	A_2014	\N	4	9	50	2014-07-29
8490	2.44	B_2014	\N	4	11	52	2014-07-31
8491	135.4	A_2014	\N	4	7	49	2014-07-29
8492	2	B_2014	\N	4	10	51	2014-07-31
8493	0	A_2014	\N	5	9	50	2014-07-29
8494	3.34	B_2014	\N	5	11	52	2014-07-31
8495	173.6	A_2014	\N	5	7	49	2014-07-29
8496	1	B_2014	\N	5	10	51	2014-07-31
8497	2	A_2014	\N	1	9	50	2014-07-29
8498	4.14	B_2014	\N	1	11	52	2014-07-31
8499	129.0	A_2014	\N	1	7	49	2014-07-29
8500	0	B_2014	\N	1	10	51	2014-07-31
8501	2	A_2014	\N	2	9	50	2014-07-29
8502	3.36	B_2014	\N	2	11	52	2014-07-31
8503	173.7	A_2014	\N	2	7	49	2014-07-29
8504	0	B_2014	\N	2	10	51	2014-07-31
8505	2	A_2014	\N	3	9	50	2014-07-29
8506	3.19	B_2014	\N	3	11	52	2014-07-31
8507	159.4	A_2014	\N	3	7	49	2014-07-29
8508	0	B_2014	\N	3	10	51	2014-07-31
8509	2	A_2014	\N	4	9	50	2014-07-29
8510	3.76	B_2014	\N	4	11	52	2014-07-31
8511	127.1	A_2014	\N	4	7	49	2014-07-29
8512	0	B_2014	\N	4	10	51	2014-07-31
8513	2	A_2014	\N	5	9	50	2014-07-29
8514	2.84	B_2014	\N	5	11	52	2014-07-31
8515	176.9	A_2014	\N	5	7	49	2014-07-29
8516	0	B_2014	\N	5	10	51	2014-07-31
8517	0	A_2014	\N	1	9	50	2014-07-29
8518	3.70	B_2014	\N	1	11	52	2014-07-31
8519	133.6	A_2014	\N	1	7	49	2014-07-29
8520	1	B_2014	\N	1	10	51	2014-07-31
8521	0	A_2014	\N	2	9	50	2014-07-29
8522	2.20	B_2014	\N	2	11	52	2014-07-31
8523	137.1	A_2014	\N	2	7	49	2014-07-29
8524	1	B_2014	\N	2	10	51	2014-07-31
8525	0	A_2014	\N	3	9	50	2014-07-29
8526	4.35	B_2014	\N	3	11	52	2014-07-31
8527	134.0	A_2014	\N	3	7	49	2014-07-29
8528	1	B_2014	\N	3	10	51	2014-07-31
8529	0	A_2014	\N	4	9	50	2014-07-29
8530	3.79	B_2014	\N	4	11	52	2014-07-31
8531	126.0	A_2014	\N	4	7	49	2014-07-29
8532	1	B_2014	\N	4	10	51	2014-07-31
8533	0	A_2014	\N	5	9	50	2014-07-29
8534	4.82	B_2014	\N	5	11	52	2014-07-31
8535	137.5	A_2014	\N	5	7	49	2014-07-29
8536	1	B_2014	\N	5	10	51	2014-07-31
8537	2	A_2014	\N	1	9	50	2014-07-29
8538	3.40	B_2014	\N	1	11	52	2014-07-31
8539	137.7	A_2014	\N	1	7	49	2014-07-29
8540	0	B_2014	\N	1	10	51	2014-07-31
8541	2	A_2014	\N	2	9	50	2014-07-29
8542	2.42	B_2014	\N	2	11	52	2014-07-31
8543	135.8	A_2014	\N	2	7	49	2014-07-29
8544	2	B_2014	\N	2	10	51	2014-07-31
8545	2	A_2014	\N	3	9	50	2014-07-29
8546	3.60	B_2014	\N	3	11	52	2014-07-31
8547	166.3	A_2014	\N	3	7	49	2014-07-29
8548	1	B_2014	\N	3	10	51	2014-07-31
8549	2	A_2014	\N	4	9	50	2014-07-29
8550	2.38	B_2014	\N	4	11	52	2014-07-31
8551	137.5	A_2014	\N	4	7	49	2014-07-29
8552	2	B_2014	\N	4	10	51	2014-07-31
8553	0	A_2014	\N	5	9	50	2014-07-29
8554	4.63	B_2014	\N	5	11	52	2014-07-31
8555	173.9	A_2014	\N	5	7	49	2014-07-29
8556	1	B_2014	\N	5	10	51	2014-07-31
8557	2	A_2014	\N	1	9	50	2014-07-29
8558	3.79	B_2014	\N	1	11	52	2014-07-31
8559	175.6	A_2014	\N	1	7	49	2014-07-29
8560	0	B_2014	\N	1	10	51	2014-07-31
8561	2	A_2014	\N	2	9	50	2014-07-29
8562	1.78	B_2014	\N	2	11	52	2014-07-31
8563	162.0	A_2014	\N	2	7	49	2014-07-29
8564	0	B_2014	\N	2	10	51	2014-07-31
8565	2	A_2014	\N	3	9	50	2014-07-29
8566	4.73	B_2014	\N	3	11	52	2014-07-31
8567	133.4	A_2014	\N	3	7	49	2014-07-29
8568	0	B_2014	\N	3	10	51	2014-07-31
8569	2	A_2014	\N	4	9	50	2014-07-29
8570	4.21	B_2014	\N	4	11	52	2014-07-31
8571	133.8	A_2014	\N	4	7	49	2014-07-29
8572	0	B_2014	\N	4	10	51	2014-07-31
8573	2	A_2014	\N	5	9	50	2014-07-29
8574	2.11	B_2014	\N	5	11	52	2014-07-31
8575	134.4	A_2014	\N	5	7	49	2014-07-29
8576	0	B_2014	\N	5	10	51	2014-07-31
8577	0	A_2014	\N	1	9	50	2014-07-29
8578	1.80	B_2014	\N	1	11	52	2014-07-31
8579	167.3	A_2014	\N	1	7	49	2014-07-29
8580	1	B_2014	\N	1	10	51	2014-07-31
8581	0	A_2014	\N	2	9	50	2014-07-29
8582	4.81	B_2014	\N	2	11	52	2014-07-31
8583	173.7	A_2014	\N	2	7	49	2014-07-29
8584	1	B_2014	\N	2	10	51	2014-07-31
8585	0	A_2014	\N	3	9	50	2014-07-29
8586	4.26	B_2014	\N	3	11	52	2014-07-31
8587	155.0	A_2014	\N	3	7	49	2014-07-29
8588	1	B_2014	\N	3	10	51	2014-07-31
8589	0	A_2014	\N	4	9	50	2014-07-29
8590	2.18	B_2014	\N	4	11	52	2014-07-31
8591	161.0	A_2014	\N	4	7	49	2014-07-29
8592	1	B_2014	\N	4	10	51	2014-07-31
8593	0	A_2014	\N	5	9	50	2014-07-29
8594	2.10	B_2014	\N	5	11	52	2014-07-31
8595	135.9	A_2014	\N	5	7	49	2014-07-29
8596	1	B_2014	\N	5	10	51	2014-07-31
8597	0	A_2014	\N	1	9	50	2014-07-29
8598	2.77	B_2014	\N	1	11	52	2014-07-31
8599	168.0	A_2014	\N	1	7	49	2014-07-29
8600	1	B_2014	\N	1	10	51	2014-07-31
8601	0	A_2014	\N	2	9	50	2014-07-29
8602	4.17	B_2014	\N	2	11	52	2014-07-31
8603	175.4	A_2014	\N	2	7	49	2014-07-29
8604	1	B_2014	\N	2	10	51	2014-07-31
8605	0	A_2014	\N	3	9	50	2014-07-29
8606	4.78	B_2014	\N	3	11	52	2014-07-31
8607	158.2	A_2014	\N	3	7	49	2014-07-29
8608	1	B_2014	\N	3	10	51	2014-07-31
8609	0	A_2014	\N	4	9	50	2014-07-29
8610	2.39	B_2014	\N	4	11	52	2014-07-31
8611	125.4	A_2014	\N	4	7	49	2014-07-29
8612	1	B_2014	\N	4	10	51	2014-07-31
8613	0	A_2014	\N	5	9	50	2014-07-29
8614	3.29	B_2014	\N	5	11	52	2014-07-31
8615	136.8	A_2014	\N	5	7	49	2014-07-29
8616	1	B_2014	\N	5	10	51	2014-07-31
8617	1	A_2014	\N	1	9	50	2014-07-29
8618	4.62	B_2014	\N	1	11	52	2014-07-31
8619	153.4	A_2014	\N	1	7	49	2014-07-29
8620	0	B_2014	\N	1	10	51	2014-07-31
8621	1	A_2014	\N	2	9	50	2014-07-29
8622	3.20	B_2014	\N	2	11	52	2014-07-31
8623	156.0	A_2014	\N	2	7	49	2014-07-29
8624	0	B_2014	\N	2	10	51	2014-07-31
8625	1	A_2014	\N	3	9	50	2014-07-29
8626	1.82	B_2014	\N	3	11	52	2014-07-31
8627	133.5	A_2014	\N	3	7	49	2014-07-29
8628	0	B_2014	\N	3	10	51	2014-07-31
8629	1	A_2014	\N	4	9	50	2014-07-29
8630	3.71	B_2014	\N	4	11	52	2014-07-31
8631	132.7	A_2014	\N	4	7	49	2014-07-29
8632	0	B_2014	\N	4	10	51	2014-07-31
8633	1	A_2014	\N	5	9	50	2014-07-29
8634	4.22	B_2014	\N	5	11	52	2014-07-31
8635	145.4	A_2014	\N	5	7	49	2014-07-29
8636	0	B_2014	\N	5	10	51	2014-07-31
8637	0	A_2014	\N	1	9	50	2014-07-29
8638	2.58	B_2014	\N	1	11	52	2014-07-31
8639	122.7	A_2014	\N	1	7	49	2014-07-29
8640	0	B_2014	\N	1	10	51	2014-07-31
8641	0	A_2014	\N	2	9	50	2014-07-29
8642	4.03	B_2014	\N	2	11	52	2014-07-31
8643	126.9	A_2014	\N	2	7	49	2014-07-29
8644	0	B_2014	\N	2	10	51	2014-07-31
8645	0	A_2014	\N	3	9	50	2014-07-29
8646	3.86	B_2014	\N	3	11	52	2014-07-31
8647	127.7	A_2014	\N	3	7	49	2014-07-29
8648	0	B_2014	\N	3	10	51	2014-07-31
8649	0	A_2014	\N	4	9	50	2014-07-29
8650	1.79	B_2014	\N	4	11	52	2014-07-31
8651	168.5	A_2014	\N	4	7	49	2014-07-29
8652	0	B_2014	\N	4	10	51	2014-07-31
8653	0	A_2014	\N	5	9	50	2014-07-29
8654	3.53	B_2014	\N	5	11	52	2014-07-31
8655	135.6	A_2014	\N	5	7	49	2014-07-29
8656	0	B_2014	\N	5	10	51	2014-07-31
6840	58.99	\N	\N	\N	22	34	2014-08-20
6841	manuelle	\N	\N	\N	14	31	2014-07-01
6842	1	\N	\N	\N	17	32	2014-07-01
6843	58.89	\N	\N	\N	8	33	2014-08-20
\.


--
-- Data for Name: eppdata_raw_data_relation; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY eppdata_raw_data_relation (id, raw_data_id, relation_id) FROM stdin;
2716	7229	882
2717	7229	881
2718	7230	886
2719	7230	885
2720	7231	887
2721	7232	887
2722	7233	888
2723	7234	888
2724	7235	889
2725	7236	889
2726	7237	890
2727	7238	890
2728	7239	891
2729	7240	891
2730	7241	892
2731	7242	892
2732	7243	893
2733	7244	893
2734	7245	887
2735	7246	888
2736	7247	889
2737	7248	890
2738	7249	891
2739	7250	892
2740	7251	893
2741	7252	887
2742	7253	888
2743	7254	889
2744	7255	890
2745	7256	891
2746	7257	892
2747	7258	893
2748	7259	887
2749	7260	887
2750	7261	888
2751	7262	888
2752	7263	889
2753	7264	889
2754	7265	890
2755	7266	890
2756	7267	891
2757	7268	891
2758	7269	892
2759	7270	892
2760	7271	893
2761	7272	893
2762	7273	887
2763	7274	887
2764	7275	887
2765	7276	887
2766	7277	887
2767	7278	887
2768	7279	887
2769	7280	887
2770	7281	887
2771	7282	887
2772	7283	887
2773	7284	887
2774	7285	887
2775	7286	887
2776	7287	887
2777	7288	887
2778	7289	887
2779	7290	887
2780	7291	887
2781	7292	887
2782	7293	888
2783	7294	888
2784	7295	888
2785	7296	888
2786	7297	888
2787	7298	888
2788	7299	888
2789	7300	888
2790	7301	888
2791	7302	888
2792	7303	888
2793	7304	888
2794	7305	888
2795	7306	888
2796	7307	888
2797	7308	888
2798	7309	888
2799	7310	888
2800	7311	888
2801	7312	888
2802	7313	889
2803	7314	889
2804	7315	889
2805	7316	889
2806	7317	889
2807	7318	889
2808	7319	889
2809	7320	889
2810	7321	889
2811	7322	889
2812	7323	889
2813	7324	889
2814	7325	889
2815	7326	889
2816	7327	889
2817	7328	889
2818	7329	889
2819	7330	889
2820	7331	889
2821	7332	889
2822	7333	890
2823	7334	890
2824	7335	890
2825	7336	890
2826	7337	890
2827	7338	890
2828	7339	890
2829	7340	890
2830	7341	890
2831	7342	890
2832	7343	890
2833	7344	890
2834	7345	890
2835	7346	890
2836	7347	890
2837	7348	890
2838	7349	890
2839	7350	890
2840	7351	890
2841	7352	890
2842	7353	891
2843	7354	891
2844	7355	891
2845	7356	891
2846	7357	891
2847	7358	891
2848	7359	891
2849	7360	891
2850	7361	891
2851	7362	891
2852	7363	891
2853	7364	891
2854	7365	891
2855	7366	891
2856	7367	891
2857	7368	891
2858	7369	891
2859	7370	891
2860	7371	891
2861	7372	891
2862	7373	892
2863	7374	892
2864	7375	892
2865	7376	892
2866	7377	892
2867	7378	892
2868	7379	892
2869	7380	892
2870	7381	892
2871	7382	892
2872	7383	892
2873	7384	892
2874	7385	892
2875	7386	892
2876	7387	892
2877	7388	892
2878	7389	892
2879	7390	892
2880	7391	892
2881	7392	892
2882	7393	893
2883	7394	893
2884	7395	893
2885	7396	893
2886	7397	893
2887	7398	893
2888	7399	893
2889	7400	893
2890	7401	893
2891	7402	893
2892	7403	893
2893	7404	893
2894	7405	893
2895	7406	893
2896	7407	893
2897	7408	893
2898	7409	893
2899	7410	893
2900	7411	893
2901	7412	893
2902	7413	894
2903	7414	894
2904	7415	894
2905	7416	895
2906	7417	895
2907	7418	895
2908	7419	896
2909	7420	896
2910	7421	896
2911	7422	897
2912	7423	897
2913	7424	897
2914	7425	898
2915	7426	898
2916	7427	898
2917	7428	899
2918	7429	899
2919	7430	899
2920	7431	900
2921	7432	900
2922	7433	900
2923	7434	901
2924	7435	901
2925	7436	901
2926	7437	902
2927	7438	902
2928	7439	902
2929	7440	903
2930	7441	903
2931	7442	903
2932	7443	904
2933	7444	904
2934	7445	904
2935	7446	905
2936	7447	905
2937	7448	905
2938	7449	906
2939	7450	906
2940	7451	907
2941	7452	907
2942	7453	908
2943	7454	908
2944	7455	909
2945	7456	909
2946	7457	910
2947	7458	910
2948	7459	911
2949	7460	911
2950	7461	912
2951	7462	912
2952	7463	913
2953	7464	913
2954	7465	914
2955	7466	914
2956	7467	915
2957	7468	915
2958	7469	916
2959	7470	916
2960	7471	917
2961	7472	917
2962	7473	918
2963	7474	918
2964	7475	919
2965	7476	919
2966	7477	920
2967	7478	920
2968	7479	921
2969	7480	921
2970	7481	906
2971	7482	907
2972	7483	908
2973	7484	909
2974	7485	910
2975	7486	911
2976	7487	912
2977	7488	913
2978	7489	914
2979	7490	915
2980	7491	916
2981	7492	917
2982	7493	918
2983	7494	919
2984	7495	920
2985	7496	921
2986	7497	906
2987	7498	907
2988	7499	908
2989	7500	909
2990	7501	910
2991	7502	911
2992	7503	912
2993	7504	913
2994	7505	914
2995	7506	915
2996	7507	916
2997	7508	917
2998	7509	918
2999	7510	919
3000	7511	920
3001	7512	921
3002	7513	906
3003	7514	906
3004	7515	907
3005	7516	907
3006	7517	908
3007	7518	908
3008	7519	909
3009	7520	909
3010	7521	910
3011	7522	910
3012	7523	911
3013	7524	911
3014	7525	912
3015	7526	912
3016	7527	913
3017	7528	913
3018	7529	914
3019	7530	914
3020	7531	915
3021	7532	915
3022	7533	916
3023	7534	916
3024	7535	917
3025	7536	917
3026	7537	918
3027	7538	918
3028	7539	919
3029	7540	919
3030	7541	920
3031	7542	920
3032	7543	921
3033	7544	921
3034	7545	922
3035	7546	922
3036	7547	923
3037	7548	923
3038	7549	924
3039	7550	924
3040	7551	925
3041	7552	925
3042	7553	926
3043	7554	926
3044	7555	927
3045	7556	927
3046	7557	928
3047	7558	928
3048	7559	922
3049	7560	922
3050	7561	922
3051	7562	922
3052	7563	922
3053	7564	922
3054	7565	922
3055	7566	922
3056	7567	922
3057	7568	922
3058	7569	922
3059	7570	922
3060	7571	922
3061	7572	922
3062	7573	922
3063	7574	922
3064	7575	922
3065	7576	922
3066	7577	922
3067	7578	922
3068	7579	907
3069	7580	907
3070	7581	907
3071	7582	907
3072	7583	907
3073	7584	907
3074	7585	907
3075	7586	907
3076	7587	907
3077	7588	907
3078	7589	907
3079	7590	907
3080	7591	907
3081	7592	907
3082	7593	907
3083	7594	907
3084	7595	907
3085	7596	907
3086	7597	907
3087	7598	907
3088	7599	923
3089	7600	923
3090	7601	923
3091	7602	923
3092	7603	923
3093	7604	923
3094	7605	923
3095	7606	923
3096	7607	923
3097	7608	923
3098	7609	923
3099	7610	923
3100	7611	923
3101	7612	923
3102	7613	923
3103	7614	923
3104	7615	923
3105	7616	923
3106	7617	923
3107	7618	923
3108	7619	924
3109	7620	924
3110	7621	924
3111	7622	924
3112	7623	924
3113	7624	924
3114	7625	924
3115	7626	924
3116	7627	924
3117	7628	924
3118	7629	924
3119	7630	924
3120	7631	924
3121	7632	924
3122	7633	924
3123	7634	924
3124	7635	924
3125	7636	924
3126	7637	924
3127	7638	924
3128	7639	910
3129	7640	910
3130	7641	910
3131	7642	910
3132	7643	910
3133	7644	910
3134	7645	910
3135	7646	910
3136	7647	910
3137	7648	910
3138	7649	910
3139	7650	910
3140	7651	910
3141	7652	910
3142	7653	910
3143	7654	910
3144	7655	910
3145	7656	910
3146	7657	910
3147	7658	910
3148	7659	925
3149	7660	925
3150	7661	925
3151	7662	925
3152	7663	925
3153	7664	925
3154	7665	925
3155	7666	925
3156	7667	925
3157	7668	925
3158	7669	925
3159	7670	925
3160	7671	925
3161	7672	925
3162	7673	925
3163	7674	925
3164	7675	925
3165	7676	925
3166	7677	925
3167	7678	925
3168	7679	912
3169	7680	912
3170	7681	912
3171	7682	912
3172	7683	912
3173	7684	912
3174	7685	912
3175	7686	912
3176	7687	912
3177	7688	912
3178	7689	912
3179	7690	912
3180	7691	912
3181	7692	912
3182	7693	912
3183	7694	912
3184	7695	912
3185	7696	912
3186	7697	912
3187	7698	912
3188	7699	913
3189	7700	913
3190	7701	913
3191	7702	913
3192	7703	913
3193	7704	913
3194	7705	913
3195	7706	913
3196	7707	913
3197	7708	913
3198	7709	913
3199	7710	913
3200	7711	913
3201	7712	913
3202	7713	913
3203	7714	913
3204	7715	913
3205	7716	913
3206	7717	913
3207	7718	913
3208	7719	914
3209	7720	914
3210	7721	914
3211	7722	914
3212	7723	914
3213	7724	914
3214	7725	914
3215	7726	914
3216	7727	914
3217	7728	914
3218	7729	914
3219	7730	914
3220	7731	914
3221	7732	914
3222	7733	914
3223	7734	914
3224	7735	914
3225	7736	914
3226	7737	914
3227	7738	914
3228	7739	915
3229	7740	915
3230	7741	915
3231	7742	915
3232	7743	915
3233	7744	915
3234	7745	915
3235	7746	915
3236	7747	915
3237	7748	915
3238	7749	915
3239	7750	915
3240	7751	915
3241	7752	915
3242	7753	915
3243	7754	915
3244	7755	915
3245	7756	915
3246	7757	915
3247	7758	915
3248	7759	916
3249	7760	916
3250	7761	916
3251	7762	916
3252	7763	916
3253	7764	916
3254	7765	916
3255	7766	916
3256	7767	916
3257	7768	916
3258	7769	916
3259	7770	916
3260	7771	916
3261	7772	916
3262	7773	916
3263	7774	916
3264	7775	916
3265	7776	916
3266	7777	916
3267	7778	916
3268	7779	917
3269	7780	917
3270	7781	917
3271	7782	917
3272	7783	917
3273	7784	917
3274	7785	917
3275	7786	917
3276	7787	917
3277	7788	917
3278	7789	917
3279	7790	917
3280	7791	917
3281	7792	917
3282	7793	917
3283	7794	917
3284	7795	917
3285	7796	917
3286	7797	917
3287	7798	917
3288	7799	926
3289	7800	926
3290	7801	926
3291	7802	926
3292	7803	926
3293	7804	926
3294	7805	926
3295	7806	926
3296	7807	926
3297	7808	926
3298	7809	926
3299	7810	926
3300	7811	926
3301	7812	926
3302	7813	926
3303	7814	926
3304	7815	926
3305	7816	926
3306	7817	926
3307	7818	926
3308	7819	927
3309	7820	927
3310	7821	927
3311	7822	927
3312	7823	927
3313	7824	927
3314	7825	927
3315	7826	927
3316	7827	927
3317	7828	927
3318	7829	927
3319	7830	927
3320	7831	927
3321	7832	927
3322	7833	927
3323	7834	927
3324	7835	927
3325	7836	927
3326	7837	927
3327	7838	927
3328	7839	928
3329	7840	928
3330	7841	928
3331	7842	928
3332	7843	928
3333	7844	928
3334	7845	928
3335	7846	928
3336	7847	928
3337	7848	928
3338	7849	928
3339	7850	928
3340	7851	928
3341	7852	928
3342	7853	928
3343	7854	928
3344	7855	928
3345	7856	928
3346	7857	928
3347	7858	928
3348	7859	921
3349	7860	921
3350	7861	921
3351	7862	921
3352	7863	921
3353	7864	921
3354	7865	921
3355	7866	921
3356	7867	921
3357	7868	921
3358	7869	921
3359	7870	921
3360	7871	921
3361	7872	921
3362	7873	921
3363	7874	921
3364	7875	921
3365	7876	921
3366	7877	921
3367	7878	921
3368	7879	922
3369	7880	922
3370	7881	922
3371	7882	922
3372	7883	922
3373	7884	922
3374	7885	922
3375	7886	922
3376	7887	922
3377	7888	922
3378	7889	923
3379	7890	923
3380	7891	923
3381	7892	923
3382	7893	923
3383	7894	923
3384	7895	923
3385	7896	923
3386	7897	923
3387	7898	923
3388	7899	924
3389	7900	924
3390	7901	924
3391	7902	924
3392	7903	924
3393	7904	924
3394	7905	924
3395	7906	924
3396	7907	924
3397	7908	924
3398	7909	925
3399	7910	925
3400	7911	925
3401	7912	925
3402	7913	925
3403	7914	925
3404	7915	925
3405	7916	925
3406	7917	925
3407	7918	925
3408	7919	926
3409	7920	926
3410	7921	926
3411	7922	926
3412	7923	926
3413	7924	926
3414	7925	926
3415	7926	926
3416	7927	926
3417	7928	926
3418	7929	927
3419	7930	927
3420	7931	927
3421	7932	927
3422	7933	927
3423	7934	927
3424	7935	927
3425	7936	927
3426	7937	927
3427	7938	927
3428	7939	928
3429	7940	928
3430	7941	928
3431	7942	928
3432	7943	928
3433	7944	928
3434	7945	928
3435	7946	928
3436	7947	933
3437	7948	933
3438	7949	934
3439	7950	934
3440	7951	935
3441	7952	935
3442	7953	936
3443	7954	936
3444	7955	937
3445	7956	937
3446	7957	938
3447	7958	938
3448	7959	939
3449	7960	939
3450	7961	940
3451	7962	940
3452	7963	941
3453	7964	941
3454	7965	942
3455	7966	942
3456	7967	943
3457	7968	943
3458	7969	944
3459	7970	944
3460	7971	945
3461	7972	945
3462	7973	946
3463	7974	946
3464	7975	947
3465	7976	947
3466	7977	948
3467	7978	948
3468	7979	949
3469	7980	949
3470	7981	950
3471	7982	950
3472	7983	951
3473	7984	951
3474	7985	952
3475	7986	952
3476	7987	953
3477	7988	953
3478	7989	954
3479	7990	954
3480	7991	955
3481	7992	955
3482	7993	956
3483	7994	956
3484	7995	957
3485	7996	957
3486	7997	958
3487	7998	958
3488	7999	959
3489	8000	959
3490	8001	933
3491	8002	933
3492	8003	934
3493	8004	934
3494	8005	935
3495	8006	935
3496	8007	936
3497	8008	936
3498	8009	937
3499	8010	937
3500	8011	938
3501	8012	938
3502	8013	939
3503	8014	939
3504	8015	940
3505	8016	940
3506	8017	941
3507	8018	941
3508	8019	942
3509	8020	942
3510	8021	943
3511	8022	943
3512	8023	944
3513	8024	944
3514	8025	945
3515	8026	945
3516	8027	946
3517	8028	946
3518	8029	947
3519	8030	947
3520	8031	948
3521	8032	948
3522	8033	949
3523	8034	949
3524	8035	950
3525	8036	950
3526	8037	951
3527	8038	951
3528	8039	952
3529	8040	952
3530	8041	953
3531	8042	953
3532	8043	954
3533	8044	954
3534	8045	955
3535	8046	955
3536	8047	956
3537	8048	956
3538	8049	957
3539	8050	957
3540	8051	958
3541	8052	958
3542	8053	959
3543	8054	959
3544	8055	933
3545	8056	933
3546	8058	933
3547	8059	933
3548	8061	933
3549	8062	933
3550	8064	933
3551	8065	933
3552	8067	933
3553	8069	933
3554	8071	933
3555	8073	960
3556	8074	960
3557	8075	961
3558	8076	961
3559	8077	933
3560	8078	933
3561	8079	933
3562	8080	933
3563	8081	933
3564	8082	933
3565	8083	933
3566	8084	933
3567	8085	933
3568	8086	933
3569	8087	933
3570	8088	933
3571	8089	933
3572	8090	933
3573	8091	933
3574	8092	933
3575	8093	933
3576	8094	933
3577	8095	933
3578	8096	933
3579	8097	934
3580	8098	934
3581	8099	934
3582	8100	934
3583	8101	934
3584	8102	934
3585	8103	934
3586	8104	934
3587	8105	934
3588	8106	934
3589	8107	934
3590	8108	934
3591	8109	934
3592	8110	934
3593	8111	934
3594	8112	934
3595	8113	934
3596	8114	934
3597	8115	934
3598	8116	934
3599	8117	935
3600	8118	935
3601	8119	935
3602	8120	935
3603	8121	935
3604	8122	935
3605	8123	935
3606	8124	935
3607	8125	935
3608	8126	935
3609	8127	935
3610	8128	935
3611	8129	935
3612	8130	935
3613	8131	935
3614	8132	935
3615	8133	935
3616	8134	935
3617	8135	935
3618	8136	935
3619	8137	936
3620	8138	936
3621	8139	936
3622	8140	936
3623	8141	936
3624	8142	936
3625	8143	936
3626	8144	936
3627	8145	936
3628	8146	936
3629	8147	936
3630	8148	936
3631	8149	936
3632	8150	936
3633	8151	936
3634	8152	936
3635	8153	936
3636	8154	936
3637	8155	936
3638	8156	936
3639	8157	937
3640	8158	937
3641	8159	937
3642	8160	937
3643	8161	937
3644	8162	937
3645	8163	937
3646	8164	937
3647	8165	937
3648	8166	937
3649	8167	937
3650	8168	937
3651	8169	937
3652	8170	937
3653	8171	937
3654	8172	937
3655	8173	937
3656	8174	937
3657	8175	937
3658	8176	937
3659	8177	938
3660	8178	938
3661	8179	938
3662	8180	938
3663	8181	938
3664	8182	938
3665	8183	938
3666	8184	938
3667	8185	938
3668	8186	938
3669	8187	938
3670	8188	938
3671	8189	938
3672	8190	938
3673	8191	938
3674	8192	938
3675	8193	938
3676	8194	938
3677	8195	938
3678	8196	938
3679	8197	939
3680	8198	939
3681	8199	939
3682	8200	939
3683	8201	939
3684	8202	939
3685	8203	939
3686	8204	939
3687	8205	939
3688	8206	939
3689	8207	939
3690	8208	939
3691	8209	939
3692	8210	939
3693	8211	939
3694	8212	939
3695	8213	939
3696	8214	939
3697	8215	939
3698	8216	939
3699	8217	940
3700	8218	940
3701	8219	940
3702	8220	940
3703	8221	940
3704	8222	940
3705	8223	940
3706	8224	940
3707	8225	940
3708	8226	940
3709	8227	940
3710	8228	940
3711	8229	940
3712	8230	940
3713	8231	940
3714	8232	940
3715	8233	940
3716	8234	940
3717	8235	940
3718	8236	940
3719	8237	941
3720	8238	941
3721	8239	941
3722	8240	941
3723	8241	941
3724	8242	941
3725	8243	941
3726	8244	941
3727	8245	941
3728	8246	941
3729	8247	941
3730	8248	941
3731	8249	941
3732	8250	941
3733	8251	941
3734	8252	941
3735	8253	941
3736	8254	941
3737	8255	941
3738	8256	941
3739	8257	942
3740	8258	942
3741	8259	942
3742	8260	942
3743	8261	942
3744	8262	942
3745	8263	942
3746	8264	942
3747	8265	942
3748	8266	942
3749	8267	942
3750	8268	942
3751	8269	942
3752	8270	942
3753	8271	942
3754	8272	942
3755	8273	942
3756	8274	942
3757	8275	942
3758	8276	942
3759	8277	943
3760	8278	943
3761	8279	943
3762	8280	943
3763	8281	943
3764	8282	943
3765	8283	943
3766	8284	943
3767	8285	943
3768	8286	943
3769	8287	943
3770	8288	943
3771	8289	943
3772	8290	943
3773	8291	943
3774	8292	943
3775	8293	943
3776	8294	943
3777	8295	943
3778	8296	943
3779	8297	944
3780	8298	944
3781	8299	944
3782	8300	944
3783	8301	944
3784	8302	944
3785	8303	944
3786	8304	944
3787	8305	944
3788	8306	944
3789	8307	944
3790	8308	944
3791	8309	944
3792	8310	944
3793	8311	944
3794	8312	944
3795	8313	944
3796	8314	944
3797	8315	944
3798	8316	944
3799	8317	945
3800	8318	945
3801	8319	945
3802	8320	945
3803	8321	945
3804	8322	945
3805	8323	945
3806	8324	945
3807	8325	945
3808	8326	945
3809	8327	945
3810	8328	945
3811	8329	945
3812	8330	945
3813	8331	945
3814	8332	945
3815	8333	945
3816	8334	945
3817	8335	945
3818	8336	945
3819	8337	946
3820	8338	946
3821	8339	946
3822	8340	946
3823	8341	946
3824	8342	946
3825	8343	946
3826	8344	946
3827	8345	946
3828	8346	946
3829	8347	946
3830	8348	946
3831	8349	946
3832	8350	946
3833	8351	946
3834	8352	946
3835	8353	946
3836	8354	946
3837	8355	946
3838	8356	946
3839	8357	947
3840	8358	947
3841	8359	947
3842	8360	947
3843	8361	947
3844	8362	947
3845	8363	947
3846	8364	947
3847	8365	947
3848	8366	947
3849	8367	947
3850	8368	947
3851	8369	947
3852	8370	947
3853	8371	947
3854	8372	947
3855	8373	947
3856	8374	947
3857	8375	947
3858	8376	947
3859	8377	948
3860	8378	948
3861	8379	948
3862	8380	948
3863	8381	948
3864	8382	948
3865	8383	948
3866	8384	948
3867	8385	948
3868	8386	948
3869	8387	948
3870	8388	948
3871	8389	948
3872	8390	948
3873	8391	948
3874	8392	948
3875	8393	948
3876	8394	948
3877	8395	948
3878	8396	948
3879	8397	949
3880	8398	949
3881	8399	949
3882	8400	949
3883	8401	949
3884	8402	949
3885	8403	949
3886	8404	949
3887	8405	949
3888	8406	949
3889	8407	949
3890	8408	949
3891	8409	949
3892	8410	949
3893	8411	949
3894	8412	949
3895	8413	949
3896	8414	949
3897	8415	949
3898	8416	949
3899	8417	950
3900	8418	950
3901	8419	950
3902	8420	950
3903	8421	950
3904	8422	950
3905	8423	950
3906	8424	950
3907	8425	950
3908	8426	950
3909	8427	950
3910	8428	950
3911	8429	950
3912	8430	950
3913	8431	950
3914	8432	950
3915	8433	950
3916	8434	950
3917	8435	950
3918	8436	950
3919	8437	951
3920	8438	951
3921	8439	951
3922	8440	951
3923	8441	951
3924	8442	951
3925	8443	951
3926	8444	951
3927	8445	951
3928	8446	951
3929	8447	951
3930	8448	951
3931	8449	951
3932	8450	951
3933	8451	951
3934	8452	951
3935	8453	951
3936	8454	951
3937	8455	951
3938	8456	951
3939	8457	952
3940	8458	952
3941	8459	952
3942	8460	952
3943	8461	952
3944	8462	952
3945	8463	952
3946	8464	952
3947	8465	952
3948	8466	952
3949	8467	952
3950	8468	952
3951	8469	952
3952	8470	952
3953	8471	952
3954	8472	952
3955	8473	952
3956	8474	952
3957	8475	952
3958	8476	952
3959	8477	953
3960	8478	953
3961	8479	953
3962	8480	953
3963	8481	953
3964	8482	953
3965	8483	953
3966	8484	953
3967	8485	953
3968	8486	953
3969	8487	953
3970	8488	953
3971	8489	953
3972	8490	953
3973	8491	953
3974	8492	953
3975	8493	953
3976	8494	953
3977	8495	953
3978	8496	953
3979	8497	954
3980	8498	954
3981	8499	954
3982	8500	954
3983	8501	954
3984	8502	954
3985	8503	954
3986	8504	954
3987	8505	954
3988	8506	954
3989	8507	954
3990	8508	954
3991	8509	954
3992	8510	954
3993	8511	954
3994	8512	954
3995	8513	954
3996	8514	954
3997	8515	954
3998	8516	954
3999	8517	955
4000	8518	955
4001	8519	955
4002	8520	955
4003	8521	955
4004	8522	955
4005	8523	955
4006	8524	955
4007	8525	955
4008	8526	955
4009	8527	955
4010	8528	955
4011	8529	955
4012	8530	955
4013	8531	955
4014	8532	955
4015	8533	955
4016	8534	955
4017	8535	955
4018	8536	955
4019	8537	956
4020	8538	956
4021	8539	956
4022	8540	956
4023	8541	956
4024	8542	956
4025	8543	956
4026	8544	956
4027	8545	956
4028	8546	956
4029	8547	956
4030	8548	956
4031	8549	956
4032	8550	956
4033	8551	956
4034	8552	956
4035	8553	956
4036	8554	956
4037	8555	956
4038	8556	956
4039	8557	957
4040	8558	957
4041	8559	957
4042	8560	957
4043	8561	957
4044	8562	957
4045	8563	957
4046	8564	957
4047	8565	957
4048	8566	957
4049	8567	957
4050	8568	957
4051	8569	957
4052	8570	957
4053	8571	957
4054	8572	957
4055	8573	957
4056	8574	957
4057	8575	957
4058	8576	957
4059	8577	958
4060	8578	958
4061	8579	958
4062	8580	958
4063	8581	958
4064	8582	958
4065	8583	958
4066	8584	958
4067	8585	958
4068	8586	958
4069	8587	958
4070	8588	958
4071	8589	958
4072	8590	958
4073	8591	958
4074	8592	958
4075	8593	958
4076	8594	958
4077	8595	958
4078	8596	958
4079	8597	959
4080	8598	959
4081	8599	959
4082	8600	959
4083	8601	959
4084	8602	959
4085	8603	959
4086	8604	959
4087	8605	959
4088	8606	959
4089	8607	959
4090	8608	959
4091	8609	959
4092	8610	959
4093	8611	959
4094	8612	959
4095	8613	959
4096	8614	959
4097	8615	959
4098	8616	959
4099	8617	953
4100	8618	953
4101	8619	953
4102	8620	953
4103	8621	953
4104	8622	953
4105	8623	953
4106	8624	953
4107	8625	953
4108	8626	953
4109	8627	953
4110	8628	953
4111	8629	953
4112	8630	953
4113	8631	953
4114	8632	953
4115	8633	953
4116	8634	953
4117	8635	953
4118	8636	953
4119	8637	933
4120	8638	933
4121	8639	933
4122	8640	933
4123	8641	933
4124	8642	933
4125	8643	933
4126	8644	933
4127	8645	933
4128	8646	933
4129	8647	933
4130	8648	933
4131	8649	933
4132	8650	933
4133	8651	933
4134	8652	933
4135	8653	933
4136	8654	933
4137	8655	933
4138	8656	933
\.


--
-- Data for Name: eppdata_raw_data_seed_lot; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY eppdata_raw_data_seed_lot (id, raw_data_id, seed_lot_id) FROM stdin;
4540	7228	1334
\.


--
-- Data for Name: eppdata_variable; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY eppdata_variable (id, name, type, season) FROM stdin;
31	recolte	T1	?
32	etat_sanitaire	T8	?
33	pmg	T1	?
34	pmg%2	T1	?
35	female_notes	T10	?
36	male_notes	T4	?
37	croisement_notes	T11	?
38	male_notes	T9	?
39	croisement_notes	T1	?
40	densite_semis	T1	?
41	semis	T1	?
42	notes	T1	?
43	confiance	T1	?
44	qualite_info	T1	?
45	selection_description	T4	?
46	pmg	T4	?
47	tallage	T1	?
48	epiaison	T1	?
49	hauteur	T11	?
50	couleur	T11	?
51	barbes	T11	?
52	poids_epis	T11	?
53	note_globale	T1	?
\.


--
-- Data for Name: network_diffusion; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY network_diffusion (id, date) FROM stdin;
248	2012
249	2012
250	2012
251	2012
252	2012
253	2012
254	2012
255	2012
256	2012
257	2012
258	2012
259	2012
260	2014
261	2014
262	2014
263	2014
264	2014
265	2014
266	2014
267	2014
268	2014
269	2014
\.


--
-- Name: network_diffusion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('network_diffusion_id_seq', 269, true);


--
-- Data for Name: network_mixture; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY network_mixture (id, date) FROM stdin;
1	2013
2	2014
3	2014
4	2014
5	2014
6	2013
7	2013
8	2014
9	2014
10	2014
11	2014
12	2014
13	2013
14	2014
15	2014
16	2014
17	2014
18	2014
19	2015
20	2015
21	2015
22	2015
23	2015
24	2013
25	2013
26	2013
27	2013
28	2014
29	2014
30	2014
31	2014
\.


--
-- Name: network_mixture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('network_mixture_id_seq', 31, true);


--
-- Data for Name: network_relation; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY network_relation (id, quantity, is_male, split, block, "X", "Y", diffusion_id, mixture_id, reproduction_id, seed_lot_father_id, seed_lot_son_id, selection_id) FROM stdin;
875	5	F	1	1	A	2	\N	\N	454	1333	1335	\N
876	5	M	1	1	A	1	\N	\N	454	1334	1335	\N
877	5	F	1	1	B	2	\N	\N	455	1336	1337	\N
878	5	M	1	1	B	1	\N	\N	455	1333	1337	\N
879	5	F	1	1	C	2	\N	\N	456	1338	1339	\N
880	5	M	1	1	C	1	\N	\N	456	1336	1339	\N
881	5	F	1	1	D	2	\N	\N	457	1338	1341	\N
882	5	M	1	1	D	1	\N	\N	457	1340	1341	\N
883	5	F	1	1	E	2	\N	\N	458	1342	1343	\N
884	5	M	1	1	E	1	\N	\N	458	1336	1343	\N
885	5	F	1	1	F	2	\N	\N	459	1333	1344	\N
886	5	M	1	1	F	1	\N	\N	459	1340	1344	\N
887	\N	X	1	1	A	1	\N	\N	460	1335	1345	\N
888	\N	X	1	1	A	2	\N	\N	461	1337	1346	\N
889	\N	X	1	1	A	3	\N	\N	462	1339	1347	\N
890	\N	X	1	1	A	4	\N	\N	463	1341	1348	\N
891	\N	X	1	1	B	1	\N	\N	464	1343	1349	\N
892	\N	X	1	1	B	2	\N	\N	465	1344	1350	\N
893	68	X	1	1	B	3	\N	\N	466	1351	1352	\N
894	50	X	1	\N	\N	\N	248	\N	\N	1345	1353	\N
895	47	X	1	\N	\N	\N	249	\N	\N	1346	1354	\N
896	48	X	1	\N	\N	\N	250	\N	\N	1347	1355	\N
897	50	X	1	\N	\N	\N	251	\N	\N	1348	1356	\N
898	52	X	1	\N	\N	\N	252	\N	\N	1349	1357	\N
899	55	X	1	\N	\N	\N	253	\N	\N	1350	1358	\N
900	51	X	1	\N	\N	\N	254	\N	\N	1345	1359	\N
901	50	X	1	\N	\N	\N	255	\N	\N	1346	1360	\N
902	49	X	1	\N	\N	\N	256	\N	\N	1347	1361	\N
903	48	X	1	\N	\N	\N	257	\N	\N	1348	1362	\N
904	47	X	1	\N	\N	\N	258	\N	\N	1349	1363	\N
905	55	X	1	\N	\N	\N	259	\N	\N	1350	1364	\N
906	\N	X	1	1	A	1	\N	\N	467	1345	1365	\N
907	\N	X	1	1	A	2	\N	\N	468	1346	1366	\N
908	\N	X	1	1	A	3	\N	\N	469	1347	1367	\N
909	\N	X	1	1	A	4	\N	\N	470	1348	1368	\N
910	\N	X	1	1	A	5	\N	\N	471	1349	1369	\N
911	\N	X	1	1	A	6	\N	\N	472	1350	1370	\N
912	\N	X	1	1	A	1	\N	\N	473	1353	1371	\N
913	\N	X	1	1	A	2	\N	\N	474	1354	1372	\N
914	\N	X	1	1	A	3	\N	\N	475	1355	1373	\N
915	\N	X	1	1	A	4	\N	\N	476	1356	1374	\N
916	\N	X	1	1	A	1	\N	\N	477	1359	1375	\N
917	\N	X	1	1	A	2	\N	\N	478	1360	1376	\N
918	\N	X	1	1	A	3	\N	\N	479	1361	1377	\N
919	\N	X	1	1	A	4	\N	\N	480	1362	1378	\N
920	\N	X	1	1	A	5	\N	\N	481	1363	1379	\N
921	\N	X	1	1	A	6	\N	\N	482	1364	1380	\N
922	51	X	\N	1	A	1	\N	\N	467	1345	1381	40
923	50	X	\N	1	A	3	\N	\N	469	1347	1382	41
924	51	X	\N	1	A	4	\N	\N	470	1348	1383	42
925	50	X	\N	1	A	6	\N	\N	472	1350	1384	43
926	50	X	\N	1	A	3	\N	\N	479	1361	1385	44
927	49	X	\N	1	A	4	\N	\N	480	1362	1386	45
928	50	X	\N	1	A	5	\N	\N	481	1363	1387	46
929	25	X	1	\N	\N	\N	\N	27	\N	1371	1388	\N
930	25	X	1	\N	\N	\N	\N	27	\N	1372	1388	\N
931	25	X	1	\N	\N	\N	\N	27	\N	1373	1388	\N
932	25	X	1	\N	\N	\N	\N	27	\N	1374	1388	\N
933	\N	X	1	1	A	1	\N	\N	483	1365	1389	\N
934	\N	X	1	1	A	2	\N	\N	484	1381	1390	\N
935	\N	X	1	1	A	3	\N	\N	485	1346	1391	\N
936	\N	X	1	1	B	1	\N	\N	486	1382	1392	\N
937	\N	X	1	1	B	2	\N	\N	487	1367	1393	\N
938	\N	X	1	1	B	3	\N	\N	488	1369	1394	\N
939	\N	X	1	2	C	1	\N	\N	489	1365	1395	\N
940	\N	X	1	2	C	2	\N	\N	490	1368	1396	\N
941	\N	X	1	2	C	3	\N	\N	491	1383	1397	\N
942	\N	X	1	2	D	1	\N	\N	492	1346	1398	\N
943	\N	X	1	2	D	2	\N	\N	493	1384	1399	\N
944	\N	X	1	2	D	3	\N	\N	494	1370	1400	\N
945	\N	X	1	1	A	1	\N	\N	495	1371	1401	\N
946	\N	X	1	1	A	2	\N	\N	496	1372	1402	\N
947	\N	X	1	1	A	3	\N	\N	497	1373	1403	\N
948	\N	X	1	1	A	4	\N	\N	498	1374	1404	\N
949	\N	X	1	1	A	5	\N	\N	499	1371	1405	\N
950	\N	X	1	1	A	1	\N	\N	500	1375	1406	\N
951	\N	X	1	1	A	2	\N	\N	501	1376	1407	\N
952	\N	X	1	1	A	3	\N	\N	502	1377	1408	\N
953	\N	X	1	1	A	4	\N	\N	503	1378	1409	\N
954	\N	X	1	1	A	5	\N	\N	504	1379	1410	\N
955	\N	X	1	1	A	6	\N	\N	505	1380	1411	\N
956	\N	X	1	1	A	7	\N	\N	506	1385	1412	\N
957	\N	X	1	1	A	8	\N	\N	507	1386	1413	\N
958	\N	X	1	1	A	9	\N	\N	508	1387	1414	\N
959	\N	X	1	1	A	10	\N	\N	509	1376	1415	\N
960	\N	X	\N	1	A	4	\N	\N	503	1378	1416	47
961	\N	X	\N	1	A	1	\N	\N	483	1365	1417	48
962	25	X	1	\N	\N	\N	\N	28	\N	1375	1418	\N
963	25	X	1	\N	\N	\N	\N	28	\N	1376	1418	\N
964	25	X	1	\N	\N	\N	\N	28	\N	1377	1418	\N
965	25	X	1	\N	\N	\N	\N	28	\N	1386	1418	\N
966	\N	X	1	\N	\N	\N	260	\N	\N	1406	1419	\N
967	\N	X	1	\N	\N	\N	261	\N	\N	1418	1420	\N
968	\N	X	1	\N	\N	\N	262	\N	\N	1421	1422	\N
969	\N	X	1	\N	\N	\N	263	\N	\N	1406	1423	\N
970	\N	X	1	\N	\N	\N	264	\N	\N	1408	1424	\N
971	\N	X	1	\N	\N	\N	265	\N	\N	1409	1425	\N
972	\N	X	1	\N	\N	\N	266	\N	\N	1390	1426	\N
973	\N	X	1	\N	\N	\N	267	\N	\N	1365	1427	\N
974	\N	X	1	\N	\N	\N	268	\N	\N	1388	1428	\N
975	\N	X	1	\N	\N	\N	269	\N	\N	1429	1430	\N
976	\N	\N	0	\N	\N	\N	\N	29	\N	1395	1431	\N
977	\N	\N	0	\N	\N	\N	\N	29	\N	1389	1431	\N
978	\N	\N	0	\N	\N	\N	\N	30	\N	1405	1432	\N
979	\N	\N	0	\N	\N	\N	\N	30	\N	1401	1432	\N
980	\N	\N	0	\N	\N	\N	\N	31	\N	1415	1433	\N
981	\N	\N	0	\N	\N	\N	\N	31	\N	1407	1433	\N
\.


--
-- Name: network_relation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('network_relation_id_seq', 981, true);


--
-- Data for Name: network_relation_project; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY network_relation_project (id, relation_id, project_id) FROM stdin;
816	875	1
817	876	1
818	877	1
819	878	1
820	879	1
821	880	1
822	881	1
823	882	1
824	883	1
825	884	1
826	885	1
827	886	1
828	887	1
829	888	1
830	889	1
831	890	1
832	891	1
833	892	1
834	894	1
835	895	1
836	896	1
837	897	1
838	898	1
839	899	1
840	900	1
841	901	1
842	902	1
843	903	1
844	904	1
845	905	1
846	906	1
847	907	1
848	908	1
849	909	1
850	910	1
851	911	1
852	912	1
853	913	1
854	914	1
855	915	1
856	916	1
857	917	1
858	918	1
859	919	1
860	920	1
861	921	1
862	922	1
863	923	1
864	924	1
865	925	1
866	926	1
867	927	1
868	928	1
869	933	1
870	934	1
871	935	1
872	936	1
873	937	1
874	938	1
875	939	1
876	940	1
877	941	1
878	942	1
879	943	1
880	944	1
881	945	1
882	946	1
883	947	1
884	948	1
885	949	1
886	950	1
887	951	1
888	952	1
889	953	1
890	954	1
891	955	1
892	956	1
893	957	1
894	958	1
895	959	1
896	960	1
897	961	1
898	966	1
899	967	1
900	968	1
901	969	1
902	970	1
903	971	1
904	972	1
905	973	1
906	974	1
907	975	1
908	976	1
909	977	1
910	978	1
911	979	1
912	980	1
913	981	1
\.


--
-- Name: network_relation_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('network_relation_project_id_seq', 913, true);


--
-- Data for Name: network_reproduction; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY network_reproduction (id, kernel_number, cross_number, description, realised, reproduction_method_id, end_date, start_date) FROM stdin;
289	\N	\N	reproduction	\N	\N	2015	2014
327	\N	\N	reproduction	\N	\N	2015	2014
328	\N	\N	reproduction	\N	\N	2015	2014
329	\N	\N	reproduction	\N	\N	2015	2014
324	\N	\N	reproduction	\N	\N	2015	2014
325	\N	\N	reproduction	\N	\N	2015	2014
326	\N	\N	reproduction	\N	\N	2015	2014
330	\N	\N	\N	Y	5	2011	2010
331	\N	\N	\N	Y	5	2011	2010
332	\N	\N	\N	Y	5	2011	2010
333	\N	\N	\N	Y	5	2011	2010
334	\N	\N	\N	Y	5	2011	2010
335	\N	\N	\N	Y	5	2011	2010
343	\N	\N	\N	Y	5	2011	2010
344	\N	\N	\N	Y	5	2011	2010
345	\N	\N	\N	Y	5	2011	2010
346	\N	\N	\N	Y	5	2011	2010
347	\N	\N	\N	Y	5	2011	2010
69	\N	\N	reproduction	\N	\N	2013	2012
348	\N	\N	\N	Y	5	2011	2010
356	\N	\N	reproduction	\N	\N	2014	2013
357	\N	\N	reproduction	\N	\N	2014	2013
358	\N	\N	reproduction	\N	\N	2014	2013
359	\N	\N	\N	Y	5	2011	2010
360	\N	\N	\N	Y	5	2011	2010
361	\N	\N	\N	Y	5	2011	2010
362	\N	\N	\N	Y	5	2011	2010
363	\N	\N	\N	Y	5	2011	2010
370	\N	\N	\N	Y	5	2011	2010
371	\N	\N	\N	Y	5	2011	2010
372	\N	\N	\N	Y	5	2011	2010
373	\N	\N	\N	Y	5	2011	2010
374	\N	\N	\N	Y	5	2011	2010
375	\N	\N	\N	Y	5	2011	2010
376	\N	\N	reproduction	\N	\N	2017	2009
377	\N	\N	reproduction	\N	\N	2017	2016
380	\N	\N	reproduction	\N	\N	2017	2016
381	\N	\N	\N	Y	5	2011	2010
70	\N	\N	reproduction	\N	\N	2013	2012
382	\N	\N	\N	Y	5	2011	2010
71	\N	\N	reproduction	\N	\N	2013	2012
383	\N	\N	\N	Y	5	2011	2010
72	\N	\N	reproduction	\N	\N	2013	2012
384	\N	\N	\N	Y	5	2011	2010
73	\N	\N	reproduction	\N	\N	2013	2012
385	\N	\N	\N	Y	5	2011	2010
74	\N	\N	reproduction	\N	\N	2013	2012
386	\N	\N	\N	Y	5	2011	2010
389	\N	\N	reproduction	\N	\N	2017	2016
393	\N	\N	reproduction	\N	\N	2017	2016
13	\N	\N	reproduction	\N	\N	2012	2011
14	\N	\N	reproduction	\N	\N	2012	2011
15	\N	\N	reproduction	\N	\N	2012	2011
16	\N	\N	reproduction	\N	\N	2012	2011
17	\N	\N	reproduction	\N	\N	2012	2011
18	\N	\N	reproduction	\N	\N	2012	2011
19	\N	\N	reproduction	\N	\N	2012	2011
20	\N	\N	reproduction	\N	\N	2012	2011
21	\N	\N	reproduction	\N	\N	2012	2011
22	\N	\N	reproduction	\N	\N	2012	2011
23	\N	\N	reproduction	\N	\N	2012	2011
24	\N	\N	reproduction	\N	\N	2012	2011
25	\N	\N	reproduction	\N	\N	2012	2011
26	\N	\N	reproduction	\N	\N	2012	2011
27	\N	\N	reproduction	\N	\N	2012	2011
28	\N	\N	reproduction	\N	\N	2012	2011
29	\N	\N	reproduction	\N	\N	2012	2011
84	\N	\N	reproduction	\N	\N	2014	2013
85	\N	\N	reproduction	\N	\N	2014	2013
86	\N	\N	reproduction	\N	\N	2014	2013
87	\N	\N	reproduction	\N	\N	2014	2013
88	\N	\N	reproduction	\N	\N	2014	2013
89	\N	\N	reproduction	\N	\N	2014	2013
59	\N	\N	reproduction	\N	\N	2013	2012
60	\N	\N	reproduction	\N	\N	2013	2012
61	\N	\N	reproduction	\N	\N	2013	2012
62	\N	\N	reproduction	\N	\N	2013	2012
63	\N	\N	reproduction	\N	\N	2013	2012
64	\N	\N	reproduction	\N	\N	2013	2012
65	\N	\N	reproduction	\N	\N	2013	2012
66	\N	\N	reproduction	\N	\N	2013	2012
67	\N	\N	reproduction	\N	\N	2013	2012
68	\N	\N	reproduction	\N	\N	2013	2012
75	\N	\N	reproduction	\N	\N	2014	2013
76	\N	\N	reproduction	\N	\N	2014	2013
77	\N	\N	reproduction	\N	\N	2014	2013
78	\N	\N	reproduction	\N	\N	2014	2013
79	\N	\N	reproduction	\N	\N	2014	2013
80	\N	\N	reproduction	\N	\N	2014	2013
81	\N	\N	reproduction	\N	\N	2014	2013
82	\N	\N	reproduction	\N	\N	2014	2013
83	\N	\N	reproduction	\N	\N	2014	2013
90	\N	\N	reproduction	\N	\N	2014	2013
91	\N	\N	reproduction	\N	\N	2014	2013
92	\N	\N	reproduction	\N	\N	2014	2013
93	\N	\N	reproduction	\N	\N	2014	2013
94	\N	\N	reproduction	\N	\N	2014	2013
95	\N	\N	reproduction	\N	\N	2014	2013
96	\N	\N	reproduction	\N	\N	2014	2013
97	\N	\N	reproduction	\N	\N	2014	2013
98	\N	\N	reproduction	\N	\N	2014	2013
99	\N	\N	reproduction	\N	\N	2014	2013
100	\N	\N	reproduction	\N	\N	2014	2013
101	\N	\N	reproduction	\N	\N	2014	2013
108	\N	\N	reproduction	\N	\N	2012	2011
109	\N	\N	reproduction	\N	\N	2012	2011
110	\N	\N	reproduction	\N	\N	2012	2011
111	\N	\N	reproduction	\N	\N	2012	2011
112	\N	\N	reproduction	\N	\N	2012	2011
113	\N	\N	reproduction	\N	\N	2012	2011
114	\N	\N	reproduction	\N	\N	2012	2011
121	\N	\N	reproduction	\N	\N	2012	2011
122	\N	\N	reproduction	\N	\N	2012	2011
123	\N	\N	reproduction	\N	\N	2012	2011
124	\N	\N	reproduction	\N	\N	2012	2011
125	\N	\N	reproduction	\N	\N	2012	2011
126	\N	\N	reproduction	\N	\N	2012	2011
127	\N	\N	reproduction	\N	\N	2012	2011
290	\N	\N	reproduction	\N	\N	2015	2014
304	\N	\N	reproduction	\N	\N	2015	2014
52	\N	\N	reproduction	\N	\N	2012	2011
53	\N	\N	reproduction	\N	\N	2012	2011
54	\N	\N	reproduction	\N	\N	2012	2011
55	\N	\N	reproduction	\N	\N	2012	2011
56	\N	\N	reproduction	\N	\N	2012	2011
57	\N	\N	reproduction	\N	\N	2012	2011
58	\N	\N	reproduction	\N	\N	2012	2011
128	\N	\N	reproduction	\N	\N	2013	2012
129	\N	\N	reproduction	\N	\N	2013	2012
130	\N	\N	reproduction	\N	\N	2013	2012
131	\N	\N	reproduction	\N	\N	2013	2012
132	\N	\N	reproduction	\N	\N	2013	2012
133	\N	\N	reproduction	\N	\N	2013	2012
134	\N	\N	reproduction	\N	\N	2013	2012
135	\N	\N	reproduction	\N	\N	2013	2012
136	\N	\N	reproduction	\N	\N	2013	2012
137	\N	\N	reproduction	\N	\N	2013	2012
138	\N	\N	reproduction	\N	\N	2013	2012
139	\N	\N	reproduction	\N	\N	2013	2012
140	\N	\N	reproduction	\N	\N	2013	2012
141	\N	\N	reproduction	\N	\N	2013	2012
142	\N	\N	reproduction	\N	\N	2013	2012
143	\N	\N	reproduction	\N	\N	2013	2012
150	\N	\N	reproduction	\N	\N	2012	2011
154	\N	\N	reproduction	\N	\N	2012	2011
151	\N	\N	reproduction	\N	\N	2012	2011
152	\N	\N	reproduction	\N	\N	2012	2011
155	\N	\N	reproduction	\N	\N	2012	2011
153	\N	\N	reproduction	\N	\N	2012	2011
156	\N	\N	reproduction	\N	\N	2012	2011
163	\N	\N	reproduction	\N	\N	2012	2011
164	\N	\N	reproduction	\N	\N	2012	2011
165	\N	\N	reproduction	\N	\N	2012	2011
166	\N	\N	reproduction	\N	\N	2012	2011
167	\N	\N	reproduction	\N	\N	2012	2011
168	\N	\N	reproduction	\N	\N	2012	2011
169	\N	\N	reproduction	\N	\N	2012	2011
288	\N	\N	reproduction	\N	\N	2014	2013
291	\N	\N	reproduction	\N	\N	2015	2014
292	\N	\N	reproduction	\N	\N	2015	2014
293	\N	\N	reproduction	\N	\N	2015	2014
294	\N	\N	reproduction	\N	\N	2015	2014
295	\N	\N	reproduction	\N	\N	2015	2014
296	\N	\N	reproduction	\N	\N	2015	2014
297	\N	\N	reproduction	\N	\N	2015	2014
298	\N	\N	reproduction	\N	\N	2015	2014
299	\N	\N	reproduction	\N	\N	2015	2014
300	\N	\N	reproduction	\N	\N	2015	2014
301	\N	\N	reproduction	\N	\N	2015	2014
302	\N	\N	reproduction	\N	\N	2015	2014
303	\N	\N	reproduction	\N	\N	2015	2014
170	\N	\N	reproduction	\N	2	2013	2012
171	\N	\N	reproduction	\N	2	2013	2012
172	\N	\N	reproduction	\N	2	2013	2012
173	\N	\N	reproduction	\N	2	2013	2012
174	\N	\N	reproduction	\N	2	2013	2012
175	\N	\N	reproduction	\N	2	2013	2012
176	\N	\N	reproduction	\N	2	2013	2012
177	\N	\N	reproduction	\N	2	2013	2012
178	\N	\N	reproduction	\N	2	2013	2012
179	\N	\N	reproduction	\N	2	2013	2012
180	\N	\N	reproduction	\N	2	2013	2012
305	\N	\N	reproduction	\N	\N	2015	2014
306	\N	\N	reproduction	\N	\N	2015	2014
307	\N	\N	reproduction	\N	\N	2015	2014
308	\N	\N	reproduction	\N	\N	2015	2014
309	\N	\N	reproduction	\N	\N	2015	2014
310	\N	\N	reproduction	\N	\N	2015	2014
311	\N	\N	reproduction	\N	\N	2015	2014
312	\N	\N	reproduction	\N	\N	2015	2014
313	\N	\N	reproduction	\N	\N	2015	2014
314	\N	\N	reproduction	\N	\N	2015	2014
315	\N	\N	reproduction	\N	\N	2015	2014
316	\N	\N	reproduction	\N	\N	2015	2014
317	\N	\N	reproduction	\N	\N	2015	2014
318	\N	\N	reproduction	\N	\N	2015	2014
319	\N	\N	reproduction	\N	\N	2015	2014
320	\N	\N	reproduction	\N	\N	2015	2014
321	\N	\N	reproduction	\N	\N	2015	2014
322	\N	\N	reproduction	\N	\N	2015	2014
323	\N	\N	reproduction	\N	\N	2015	2014
336	\N	\N	reproduction	\N	\N	2012	2011
337	\N	\N	reproduction	\N	\N	2012	2011
338	\N	\N	reproduction	\N	\N	2012	2011
339	\N	\N	reproduction	\N	\N	2012	2011
340	\N	\N	reproduction	\N	\N	2012	2011
341	\N	\N	reproduction	\N	\N	2012	2011
342	\N	\N	reproduction	\N	\N	2012	2011
349	\N	\N	reproduction	\N	\N	2012	2011
350	\N	\N	reproduction	\N	\N	2012	2011
351	\N	\N	reproduction	\N	\N	2012	2011
352	\N	\N	reproduction	\N	\N	2012	2011
353	\N	\N	reproduction	\N	\N	2012	2011
354	\N	\N	reproduction	\N	\N	2012	2011
355	\N	\N	reproduction	\N	\N	2012	2011
364	\N	\N	\N	Y	5	2011	2010
365	\N	\N	\N	Y	5	2011	2010
366	\N	\N	\N	Y	5	2011	2010
367	\N	\N	\N	Y	5	2011	2010
368	\N	\N	\N	Y	5	2011	2010
369	\N	\N	\N	Y	5	2011	2010
378	\N	\N	reproduction	\N	\N	2017	2016
387	\N	\N	reproduction	\N	\N	2017	2016
390	\N	\N	reproduction	\N	\N	2017	2016
394	\N	\N	reproduction	\N	\N	2017	2016
467	\N	\N	reproduction	\N	\N	2013	2012
468	\N	\N	reproduction	\N	\N	2013	2012
469	\N	\N	reproduction	\N	\N	2013	2012
470	\N	\N	reproduction	\N	\N	2013	2012
471	\N	\N	reproduction	\N	\N	2013	2012
472	\N	\N	reproduction	\N	\N	2013	2012
473	\N	\N	reproduction	\N	\N	2013	2012
474	\N	\N	reproduction	\N	\N	2013	2012
475	\N	\N	reproduction	\N	\N	2013	2012
181	\N	\N	reproduction	\N	2	2013	2012
182	\N	\N	reproduction	\N	2	2013	2012
183	\N	\N	reproduction	\N	2	2013	2012
184	\N	\N	reproduction	\N	2	2013	2012
185	\N	\N	reproduction	\N	2	2013	2012
219	\N	\N	reproduction	\N	\N	2012	2011
220	\N	\N	reproduction	\N	\N	2012	2011
221	\N	\N	reproduction	\N	\N	2012	2011
222	\N	\N	reproduction	\N	\N	2012	2011
223	\N	\N	reproduction	\N	\N	2012	2011
224	\N	\N	reproduction	\N	\N	2012	2011
225	\N	\N	reproduction	\N	\N	2012	2011
379	\N	\N	reproduction	\N	\N	2017	2016
388	\N	\N	reproduction	\N	\N	2017	2016
391	\N	\N	reproduction	\N	\N	2017	2016
395	\N	\N	reproduction	\N	\N	2017	2016
396	\N	\N	reproduction	\N	\N	2017	2016
398	\N	\N	\N	Y	5	2011	2010
399	\N	\N	\N	Y	5	2011	2010
400	\N	\N	\N	Y	5	2011	2010
401	\N	\N	\N	Y	5	2011	2010
402	\N	\N	\N	Y	5	2011	2010
403	\N	\N	\N	Y	5	2011	2010
404	\N	\N	reproduction	\N	\N	2012	2011
405	\N	\N	reproduction	\N	\N	2012	2011
406	\N	\N	reproduction	\N	\N	2012	2011
407	\N	\N	reproduction	\N	\N	2012	2011
408	\N	\N	reproduction	\N	\N	2012	2011
409	\N	\N	reproduction	\N	\N	2012	2011
410	\N	\N	reproduction	\N	\N	2012	2011
427	\N	\N	reproduction	\N	\N	2014	2013
428	\N	\N	reproduction	\N	\N	2014	2013
429	\N	\N	reproduction	\N	\N	2014	2013
238	\N	\N	reproduction	\N	2	2012	2011
239	\N	\N	reproduction	\N	2	2012	2011
240	\N	\N	reproduction	\N	2	2012	2011
241	\N	\N	reproduction	\N	2	2012	2011
242	\N	\N	reproduction	\N	2	2012	2011
243	\N	\N	reproduction	\N	2	2012	2011
244	\N	\N	reproduction	\N	2	2012	2011
186	\N	\N	reproduction	\N	2	2014	2013
187	\N	\N	reproduction	\N	2	2014	2013
188	\N	\N	reproduction	\N	2	2014	2013
189	\N	\N	reproduction	\N	2	2014	2013
190	\N	\N	reproduction	\N	2	2014	2013
191	\N	\N	reproduction	\N	2	2014	2013
192	\N	\N	reproduction	\N	2	2014	2013
193	\N	\N	reproduction	\N	2	2014	2013
194	\N	\N	reproduction	\N	2	2014	2013
195	\N	\N	reproduction	\N	2	2014	2013
196	\N	\N	reproduction	\N	2	2014	2013
197	\N	\N	reproduction	\N	2	2014	2013
198	\N	\N	reproduction	\N	2	2014	2013
199	\N	\N	reproduction	\N	2	2014	2013
200	\N	\N	reproduction	\N	2	2014	2013
201	\N	\N	reproduction	\N	2	2014	2013
202	\N	\N	reproduction	\N	2	2014	2013
203	\N	\N	reproduction	\N	2	2014	2013
204	\N	\N	reproduction	\N	2	2014	2013
205	\N	\N	reproduction	\N	2	2014	2013
206	\N	\N	reproduction	\N	2	2014	2013
207	\N	\N	reproduction	\N	2	2014	2013
208	\N	\N	reproduction	\N	2	2014	2013
209	\N	\N	reproduction	\N	2	2014	2013
210	\N	\N	reproduction	\N	2	2014	2013
211	\N	\N	reproduction	\N	2	2014	2013
212	\N	\N	reproduction	\N	2	2014	2013
430	\N	\N	reproduction	\N	\N	2014	2013
431	\N	\N	reproduction	\N	\N	2014	2013
432	\N	\N	reproduction	\N	\N	2014	2013
433	\N	\N	reproduction	\N	\N	2014	2013
434	\N	\N	reproduction	\N	\N	2014	2013
435	\N	\N	reproduction	\N	\N	2014	2013
436	\N	\N	reproduction	\N	\N	2014	2013
245	\N	\N	reproduction	\N	2	2013	2012
246	\N	\N	reproduction	\N	2	2013	2012
247	\N	\N	reproduction	\N	2	2013	2012
248	\N	\N	reproduction	\N	2	2013	2012
249	\N	\N	reproduction	\N	2	2013	2012
250	\N	\N	reproduction	\N	2	2013	2012
251	\N	\N	reproduction	\N	2	2013	2012
252	\N	\N	reproduction	\N	2	2013	2012
253	\N	\N	reproduction	\N	2	2013	2012
254	\N	\N	reproduction	\N	2	2013	2012
255	\N	\N	reproduction	\N	2	2013	2012
256	\N	\N	reproduction	\N	2	2013	2012
257	\N	\N	reproduction	\N	2	2013	2012
258	\N	\N	reproduction	\N	2	2013	2012
259	\N	\N	reproduction	\N	2	2013	2012
260	\N	\N	reproduction	\N	2	2013	2012
437	\N	\N	reproduction	\N	\N	2014	2013
438	\N	\N	reproduction	\N	\N	2014	2013
439	\N	\N	reproduction	\N	\N	2014	2013
440	\N	\N	reproduction	\N	\N	2014	2013
441	\N	\N	reproduction	\N	\N	2014	2013
442	\N	\N	reproduction	\N	\N	2014	2013
443	\N	\N	reproduction	\N	\N	2014	2013
444	\N	\N	reproduction	\N	\N	2014	2013
445	\N	\N	reproduction	\N	\N	2014	2013
446	\N	\N	reproduction	\N	\N	2014	2013
447	\N	\N	reproduction	\N	\N	2014	2013
448	\N	\N	reproduction	\N	\N	2014	2013
449	\N	\N	reproduction	\N	\N	2014	2013
450	\N	\N	reproduction	\N	\N	2014	2013
451	\N	\N	reproduction	\N	\N	2014	2013
452	\N	\N	reproduction	\N	\N	2014	2013
453	\N	\N	reproduction	\N	\N	2014	2013
454	\N	\N	\N	Y	5	2011	2010
455	\N	\N	\N	Y	5	2011	2010
456	\N	\N	\N	Y	5	2011	2010
457	\N	\N	\N	Y	5	2011	2010
458	\N	\N	\N	Y	5	2011	2010
459	\N	\N	\N	Y	5	2011	2010
476	\N	\N	reproduction	\N	\N	2013	2012
477	\N	\N	reproduction	\N	\N	2013	2012
478	\N	\N	reproduction	\N	\N	2013	2012
479	\N	\N	reproduction	\N	\N	2013	2012
480	\N	\N	reproduction	\N	\N	2013	2012
392	\N	\N	reproduction	\N	\N	2017	2016
397	\N	\N	reproduction	\N	\N	2017	2016
411	\N	\N	reproduction	\N	\N	2013	2012
412	\N	\N	reproduction	\N	\N	2013	2012
413	\N	\N	reproduction	\N	\N	2013	2012
414	\N	\N	reproduction	\N	\N	2013	2012
415	\N	\N	reproduction	\N	\N	2013	2012
416	\N	\N	reproduction	\N	\N	2013	2012
417	\N	\N	reproduction	\N	\N	2013	2012
418	\N	\N	reproduction	\N	\N	2013	2012
419	\N	\N	reproduction	\N	\N	2013	2012
420	\N	\N	reproduction	\N	\N	2013	2012
421	\N	\N	reproduction	\N	\N	2013	2012
422	\N	\N	reproduction	\N	\N	2013	2012
423	\N	\N	reproduction	\N	\N	2013	2012
424	\N	\N	reproduction	\N	\N	2013	2012
425	\N	\N	reproduction	\N	\N	2013	2012
426	\N	\N	reproduction	\N	\N	2013	2012
460	\N	\N	reproduction	\N	\N	2012	2011
461	\N	\N	reproduction	\N	\N	2012	2011
462	\N	\N	reproduction	\N	\N	2012	2011
463	\N	\N	reproduction	\N	\N	2012	2011
464	\N	\N	reproduction	\N	\N	2012	2011
465	\N	\N	reproduction	\N	\N	2012	2011
466	\N	\N	reproduction	\N	\N	2012	2011
481	\N	\N	reproduction	\N	\N	2013	2012
482	\N	\N	reproduction	\N	\N	2013	2012
261	\N	\N	reproduction	\N	2	2014	2013
262	\N	\N	reproduction	\N	2	2014	2013
263	\N	\N	reproduction	\N	2	2014	2013
264	\N	\N	reproduction	\N	2	2014	2013
265	\N	\N	reproduction	\N	2	2014	2013
266	\N	\N	reproduction	\N	2	2014	2013
267	\N	\N	reproduction	\N	2	2014	2013
268	\N	\N	reproduction	\N	2	2014	2013
269	\N	\N	reproduction	\N	2	2014	2013
270	\N	\N	reproduction	\N	2	2014	2013
271	\N	\N	reproduction	\N	2	2014	2013
272	\N	\N	reproduction	\N	2	2014	2013
273	\N	\N	reproduction	\N	2	2014	2013
274	\N	\N	reproduction	\N	2	2014	2013
275	\N	\N	reproduction	\N	2	2014	2013
276	\N	\N	reproduction	\N	2	2014	2013
277	\N	\N	reproduction	\N	2	2014	2013
278	\N	\N	reproduction	\N	2	2014	2013
279	\N	\N	reproduction	\N	2	2014	2013
280	\N	\N	reproduction	\N	2	2014	2013
281	\N	\N	reproduction	\N	2	2014	2013
282	\N	\N	reproduction	\N	2	2014	2013
283	\N	\N	reproduction	\N	2	2014	2013
284	\N	\N	reproduction	\N	2	2014	2013
285	\N	\N	reproduction	\N	2	2014	2013
287	\N	\N	reproduction	\N	2	2014	2013
483	\N	\N	reproduction	\N	\N	2014	2013
484	\N	\N	reproduction	\N	\N	2014	2013
485	\N	\N	reproduction	\N	\N	2014	2013
486	\N	\N	reproduction	\N	\N	2014	2013
487	\N	\N	reproduction	\N	\N	2014	2013
488	\N	\N	reproduction	\N	\N	2014	2013
489	\N	\N	reproduction	\N	\N	2014	2013
490	\N	\N	reproduction	\N	\N	2014	2013
491	\N	\N	reproduction	\N	\N	2014	2013
492	\N	\N	reproduction	\N	\N	2014	2013
493	\N	\N	reproduction	\N	\N	2014	2013
494	\N	\N	reproduction	\N	\N	2014	2013
495	\N	\N	reproduction	\N	\N	2014	2013
496	\N	\N	reproduction	\N	\N	2014	2013
497	\N	\N	reproduction	\N	\N	2014	2013
498	\N	\N	reproduction	\N	\N	2014	2013
499	\N	\N	reproduction	\N	\N	2014	2013
500	\N	\N	reproduction	\N	\N	2014	2013
501	\N	\N	reproduction	\N	\N	2014	2013
502	\N	\N	reproduction	\N	\N	2014	2013
503	\N	\N	reproduction	\N	\N	2014	2013
504	\N	\N	reproduction	\N	\N	2014	2013
505	\N	\N	reproduction	\N	\N	2014	2013
506	\N	\N	reproduction	\N	\N	2014	2013
507	\N	\N	reproduction	\N	\N	2014	2013
508	\N	\N	reproduction	\N	\N	2014	2013
509	\N	\N	reproduction	\N	\N	2014	2013
\.


--
-- Name: network_reproduction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('network_reproduction_id_seq', 509, true);


--
-- Data for Name: network_reproduction_method; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY network_reproduction_method (id, reproduction_methode_name, description) FROM stdin;
2	fecondation libre	
5	cross	\N
\.


--
-- Name: network_reproduction_method_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('network_reproduction_method_id_seq', 5, true);


--
-- Data for Name: network_selection; Type: TABLE DATA; Schema: public; Owner: bioinfo
--

COPY network_selection (id, selection_name, date, person_id) FROM stdin;
1	a	2013	1
2	a	2013	1
3	a	2013	1
4	a	2013	1
5	b	2013	2
6	b	2013	2
7	a	2013	2
8	a	2013	1
9	a	2013	1
10	a	2013	1
11	a	2013	1
12	b	2013	2
13	b	2013	2
14	a	2013	2
15	a	2013	1
16	a	2013	1
17	a	2013	1
18	a	2013	1
19	b	2013	2
20	b	2013	2
21	a	2013	2
22	c	2014	1
23	c	2014	2
24	a	2013	1
25	a	2013	1
26	a	2013	1
27	a	2013	1
28	b	2013	2
29	b	2013	2
30	a	2013	2
31	c	2014	2
32	c	2014	1
33	a	2013	1
34	a	2013	1
35	a	2013	1
36	a	2013	1
37	b	2013	2
38	b	2013	2
39	a	2013	2
40	a	2013	1
41	a	2013	1
42	a	2013	1
43	a	2013	1
44	b	2013	2
45	b	2013	2
46	a	2013	2
47	c	2014	2
48	c	2014	1
\.


--
-- Name: network_selection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bioinfo
--

SELECT pg_catalog.setval('network_selection_id_seq', 48, true);


--
-- Name: actors_location_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY actors_location
    ADD CONSTRAINT actors_location_pkey PRIMARY KEY (id);


--
-- Name: actors_person_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY actors_person
    ADD CONSTRAINT actors_person_pkey PRIMARY KEY (id);


--
-- Name: actors_person_short_name_key; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY actors_person
    ADD CONSTRAINT actors_person_short_name_key UNIQUE (short_name);


--
-- Name: actors_project_person_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY actors_project_person
    ADD CONSTRAINT actors_project_person_pkey PRIMARY KEY (id);


--
-- Name: actors_project_person_project_id_ab99e668_uniq; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY actors_project_person
    ADD CONSTRAINT actors_project_person_project_id_ab99e668_uniq UNIQUE (project_id, person_id);


--
-- Name: actors_project_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY actors_project
    ADD CONSTRAINT actors_project_pkey PRIMARY KEY (id);


--
-- Name: actors_project_project_name_key; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY actors_project
    ADD CONSTRAINT actors_project_project_name_key UNIQUE (project_name);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: entities_germplasm_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY entities_germplasm
    ADD CONSTRAINT entities_germplasm_pkey PRIMARY KEY (id);


--
-- Name: entities_germplasm_species_id_9d045359_uniq; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY entities_germplasm
    ADD CONSTRAINT entities_germplasm_species_id_9d045359_uniq UNIQUE (species_id, germplasm_name);


--
-- Name: entities_germplasm_type_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY entities_germplasm_type
    ADD CONSTRAINT entities_germplasm_type_pkey PRIMARY KEY (id);


--
-- Name: entities_seed_lot_name_key; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY entities_seed_lot
    ADD CONSTRAINT entities_seed_lot_name_key UNIQUE (name);


--
-- Name: entities_seed_lot_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY entities_seed_lot
    ADD CONSTRAINT entities_seed_lot_pkey PRIMARY KEY (id);


--
-- Name: entities_species_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY entities_species
    ADD CONSTRAINT entities_species_pkey PRIMARY KEY (id);


--
-- Name: entities_species_species_key; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY entities_species
    ADD CONSTRAINT entities_species_species_key UNIQUE (species);


--
-- Name: eppdata_classe_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY eppdata_classe
    ADD CONSTRAINT eppdata_classe_pkey PRIMARY KEY (id);


--
-- Name: eppdata_env_pra_phe_method_method_name_key; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY eppdata_method
    ADD CONSTRAINT eppdata_env_pra_phe_method_method_name_key UNIQUE (method_name);


--
-- Name: eppdata_env_pra_phe_method_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY eppdata_method
    ADD CONSTRAINT eppdata_env_pra_phe_method_pkey PRIMARY KEY (id);


--
-- Name: eppdata_env_pra_phe_raw_d_env_pra_phe_raw_data_id_390735d0_uniq; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY eppdata_raw_data_seed_lot
    ADD CONSTRAINT eppdata_env_pra_phe_raw_d_env_pra_phe_raw_data_id_390735d0_uniq UNIQUE (raw_data_id, seed_lot_id);


--
-- Name: eppdata_env_pra_phe_raw_d_env_pra_phe_raw_data_id_6d12d773_uniq; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY eppdata_raw_data_relation
    ADD CONSTRAINT eppdata_env_pra_phe_raw_d_env_pra_phe_raw_data_id_6d12d773_uniq UNIQUE (raw_data_id, relation_id);


--
-- Name: eppdata_env_pra_phe_raw_data_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY eppdata_raw_data
    ADD CONSTRAINT eppdata_env_pra_phe_raw_data_pkey PRIMARY KEY (id);


--
-- Name: eppdata_env_pra_phe_raw_data_relation_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY eppdata_raw_data_relation
    ADD CONSTRAINT eppdata_env_pra_phe_raw_data_relation_pkey PRIMARY KEY (id);


--
-- Name: eppdata_env_pra_phe_raw_data_seed_lot_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY eppdata_raw_data_seed_lot
    ADD CONSTRAINT eppdata_env_pra_phe_raw_data_seed_lot_pkey PRIMARY KEY (id);


--
-- Name: eppdata_env_pra_phe_variable_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY eppdata_variable
    ADD CONSTRAINT eppdata_env_pra_phe_variable_pkey PRIMARY KEY (id);


--
-- Name: network_diffusion_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY network_diffusion
    ADD CONSTRAINT network_diffusion_pkey PRIMARY KEY (id);


--
-- Name: network_mixture_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY network_mixture
    ADD CONSTRAINT network_mixture_pkey PRIMARY KEY (id);


--
-- Name: network_relation_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY network_relation
    ADD CONSTRAINT network_relation_pkey PRIMARY KEY (id);


--
-- Name: network_relation_project_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY network_relation_project
    ADD CONSTRAINT network_relation_project_pkey PRIMARY KEY (id);


--
-- Name: network_relation_project_relation_id_6c1e5071_uniq; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY network_relation_project
    ADD CONSTRAINT network_relation_project_relation_id_6c1e5071_uniq UNIQUE (relation_id, project_id);


--
-- Name: network_reproduction_method_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY network_reproduction_method
    ADD CONSTRAINT network_reproduction_method_pkey PRIMARY KEY (id);


--
-- Name: network_reproduction_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY network_reproduction
    ADD CONSTRAINT network_reproduction_pkey PRIMARY KEY (id);


--
-- Name: network_selection_pkey; Type: CONSTRAINT; Schema: public; Owner: bioinfo; Tablespace: 
--

ALTER TABLE ONLY network_selection
    ADD CONSTRAINT network_selection_pkey PRIMARY KEY (id);


--
-- Name: actors_person_e274a5da; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX actors_person_e274a5da ON actors_person USING btree (location_id);


--
-- Name: actors_person_short_name_956739a3_like; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX actors_person_short_name_956739a3_like ON actors_person USING btree (short_name varchar_pattern_ops);


--
-- Name: actors_project_person_a8452ca7; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX actors_project_person_a8452ca7 ON actors_project_person USING btree (person_id);


--
-- Name: actors_project_person_b098ad43; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX actors_project_person_b098ad43 ON actors_project_person USING btree (project_id);


--
-- Name: actors_project_project_name_ab6498b2_like; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX actors_project_project_name_ab6498b2_like ON actors_project USING btree (project_name varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX auth_user_username_6821ab7c_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX django_site_domain_a2e37b91_like ON django_site USING btree (domain varchar_pattern_ops);


--
-- Name: entities_germplasm_03a6b4f5; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX entities_germplasm_03a6b4f5 ON entities_germplasm USING btree (germplasm_type_id);


--
-- Name: entities_germplasm_1699a6e9; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX entities_germplasm_1699a6e9 ON entities_germplasm USING btree (species_id);


--
-- Name: entities_germplasm_a8452ca7; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX entities_germplasm_a8452ca7 ON entities_germplasm USING btree (person_id);


--
-- Name: entities_seed_lot_12cb458d; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX entities_seed_lot_12cb458d ON entities_seed_lot USING btree (germplasm_id);


--
-- Name: entities_seed_lot_a8452ca7; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX entities_seed_lot_a8452ca7 ON entities_seed_lot USING btree (person_id);


--
-- Name: entities_seed_lot_name_d9e93cf1_like; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX entities_seed_lot_name_d9e93cf1_like ON entities_seed_lot USING btree (name varchar_pattern_ops);


--
-- Name: entities_species_species_d8634a47_like; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX entities_species_species_d8634a47_like ON entities_species USING btree (species varchar_pattern_ops);


--
-- Name: eppdata_env_pra_phe_method_889ff0f8; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX eppdata_env_pra_phe_method_889ff0f8 ON eppdata_method USING btree (classe_id);


--
-- Name: eppdata_env_pra_phe_method_a8452ca7; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX eppdata_env_pra_phe_method_a8452ca7 ON eppdata_method USING btree (person_id);


--
-- Name: eppdata_env_pra_phe_method_method_name_8ba6337a_like; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX eppdata_env_pra_phe_method_method_name_8ba6337a_like ON eppdata_method USING btree (method_name varchar_pattern_ops);


--
-- Name: eppdata_env_pra_phe_raw_data_59bc5ce5; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX eppdata_env_pra_phe_raw_data_59bc5ce5 ON eppdata_raw_data USING btree (variable_id);


--
-- Name: eppdata_env_pra_phe_raw_data_836f12fb; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX eppdata_env_pra_phe_raw_data_836f12fb ON eppdata_raw_data USING btree (method_id);


--
-- Name: eppdata_env_pra_phe_raw_data_relation_651a712a; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX eppdata_env_pra_phe_raw_data_relation_651a712a ON eppdata_raw_data_relation USING btree (raw_data_id);


--
-- Name: eppdata_env_pra_phe_raw_data_relation_76258650; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX eppdata_env_pra_phe_raw_data_relation_76258650 ON eppdata_raw_data_relation USING btree (relation_id);


--
-- Name: eppdata_env_pra_phe_raw_data_seed_lot_3d32ecd4; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX eppdata_env_pra_phe_raw_data_seed_lot_3d32ecd4 ON eppdata_raw_data_seed_lot USING btree (seed_lot_id);


--
-- Name: eppdata_env_pra_phe_raw_data_seed_lot_651a712a; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX eppdata_env_pra_phe_raw_data_seed_lot_651a712a ON eppdata_raw_data_seed_lot USING btree (raw_data_id);


--
-- Name: network_relation_237b44e6; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX network_relation_237b44e6 ON network_relation USING btree (seed_lot_son_id);


--
-- Name: network_relation_2fe24271; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX network_relation_2fe24271 ON network_relation USING btree (reproduction_id);


--
-- Name: network_relation_532d3945; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX network_relation_532d3945 ON network_relation USING btree (selection_id);


--
-- Name: network_relation_582fa7a8; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX network_relation_582fa7a8 ON network_relation USING btree (mixture_id);


--
-- Name: network_relation_61906443; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX network_relation_61906443 ON network_relation USING btree (seed_lot_father_id);


--
-- Name: network_relation_734126f9; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX network_relation_734126f9 ON network_relation USING btree (diffusion_id);


--
-- Name: network_relation_project_76258650; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX network_relation_project_76258650 ON network_relation_project USING btree (relation_id);


--
-- Name: network_relation_project_b098ad43; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX network_relation_project_b098ad43 ON network_relation_project USING btree (project_id);


--
-- Name: network_reproduction_98e5d8f4; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX network_reproduction_98e5d8f4 ON network_reproduction USING btree (reproduction_method_id);


--
-- Name: network_selection_a8452ca7; Type: INDEX; Schema: public; Owner: bioinfo; Tablespace: 
--

CREATE INDEX network_selection_a8452ca7 ON network_selection USING btree (person_id);


--
-- Name: D0bbb703a9f5974680d55a363bf940dc; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_reproduction
    ADD CONSTRAINT "D0bbb703a9f5974680d55a363bf940dc" FOREIGN KEY (reproduction_method_id) REFERENCES network_reproduction_method(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: actors_person_location_id_f2c233d3_fk_actors_location_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY actors_person
    ADD CONSTRAINT actors_person_location_id_f2c233d3_fk_actors_location_id FOREIGN KEY (location_id) REFERENCES actors_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: actors_project_person_person_id_ead0e615_fk_actors_person_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY actors_project_person
    ADD CONSTRAINT actors_project_person_person_id_ead0e615_fk_actors_person_id FOREIGN KEY (person_id) REFERENCES actors_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: actors_project_person_project_id_0e132328_fk_actors_project_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY actors_project_person
    ADD CONSTRAINT actors_project_person_project_id_0e132328_fk_actors_project_id FOREIGN KEY (project_id) REFERENCES actors_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_content_type_id_c4bce8eb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: entiti_germplasm_type_id_29db5a78_fk_entities_germplasm_type_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY entities_germplasm
    ADD CONSTRAINT entiti_germplasm_type_id_29db5a78_fk_entities_germplasm_type_id FOREIGN KEY (germplasm_type_id) REFERENCES entities_germplasm_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: entities_germplasm_person_id_816155a0_fk_actors_person_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY entities_germplasm
    ADD CONSTRAINT entities_germplasm_person_id_816155a0_fk_actors_person_id FOREIGN KEY (person_id) REFERENCES actors_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: entities_germplasm_species_id_e133882b_fk_entities_species_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY entities_germplasm
    ADD CONSTRAINT entities_germplasm_species_id_e133882b_fk_entities_species_id FOREIGN KEY (species_id) REFERENCES entities_species(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: entities_seed_lo_germplasm_id_defbb307_fk_entities_germplasm_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY entities_seed_lot
    ADD CONSTRAINT entities_seed_lo_germplasm_id_defbb307_fk_entities_germplasm_id FOREIGN KEY (germplasm_id) REFERENCES entities_germplasm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: entities_seed_lot_person_id_d72407a7_fk_actors_person_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY entities_seed_lot
    ADD CONSTRAINT entities_seed_lot_person_id_d72407a7_fk_actors_person_id FOREIGN KEY (person_id) REFERENCES actors_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eppdata_env_pra_ph_seed_lot_id_74e5562f_fk_entities_seed_lot_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY eppdata_raw_data_seed_lot
    ADD CONSTRAINT eppdata_env_pra_ph_seed_lot_id_74e5562f_fk_entities_seed_lot_id FOREIGN KEY (seed_lot_id) REFERENCES entities_seed_lot(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eppdata_env_pra_phe_met_classe_id_e9adb268_fk_eppdata_classe_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY eppdata_method
    ADD CONSTRAINT eppdata_env_pra_phe_met_classe_id_e9adb268_fk_eppdata_classe_id FOREIGN KEY (classe_id) REFERENCES eppdata_classe(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eppdata_env_pra_phe_meth_person_id_07175eb7_fk_actors_person_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY eppdata_method
    ADD CONSTRAINT eppdata_env_pra_phe_meth_person_id_07175eb7_fk_actors_person_id FOREIGN KEY (person_id) REFERENCES actors_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eppdata_env_pra_phe_relation_id_7d579896_fk_network_relation_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY eppdata_raw_data_relation
    ADD CONSTRAINT eppdata_env_pra_phe_relation_id_7d579896_fk_network_relation_id FOREIGN KEY (relation_id) REFERENCES network_relation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eppdata_raw_data_method_id_494533ae_fk_eppdata_method_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY eppdata_raw_data
    ADD CONSTRAINT eppdata_raw_data_method_id_494533ae_fk_eppdata_method_id FOREIGN KEY (method_id) REFERENCES eppdata_method(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eppdata_raw_data_re_raw_data_id_4c12518b_fk_eppdata_raw_data_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY eppdata_raw_data_relation
    ADD CONSTRAINT eppdata_raw_data_re_raw_data_id_4c12518b_fk_eppdata_raw_data_id FOREIGN KEY (raw_data_id) REFERENCES eppdata_raw_data(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eppdata_raw_data_se_raw_data_id_dabe043c_fk_eppdata_raw_data_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY eppdata_raw_data_seed_lot
    ADD CONSTRAINT eppdata_raw_data_se_raw_data_id_dabe043c_fk_eppdata_raw_data_id FOREIGN KEY (raw_data_id) REFERENCES eppdata_raw_data(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: eppdata_raw_data_variable_id_31b65aa6_fk_eppdata_variable_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY eppdata_raw_data
    ADD CONSTRAINT eppdata_raw_data_variable_id_31b65aa6_fk_eppdata_variable_id FOREIGN KEY (variable_id) REFERENCES eppdata_variable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: network_rel_reproduction_id_dc1c8b57_fk_network_reproduction_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_relation
    ADD CONSTRAINT network_rel_reproduction_id_dc1c8b57_fk_network_reproduction_id FOREIGN KEY (reproduction_id) REFERENCES network_reproduction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: network_rel_seed_lot_father_id_8d6f78f8_fk_entities_seed_lot_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_relation
    ADD CONSTRAINT network_rel_seed_lot_father_id_8d6f78f8_fk_entities_seed_lot_id FOREIGN KEY (seed_lot_father_id) REFERENCES entities_seed_lot(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: network_relati_seed_lot_son_id_95cc4d1d_fk_entities_seed_lot_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_relation
    ADD CONSTRAINT network_relati_seed_lot_son_id_95cc4d1d_fk_entities_seed_lot_id FOREIGN KEY (seed_lot_son_id) REFERENCES entities_seed_lot(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: network_relation_diffusion_id_1bdc10c9_fk_network_diffusion_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_relation
    ADD CONSTRAINT network_relation_diffusion_id_1bdc10c9_fk_network_diffusion_id FOREIGN KEY (diffusion_id) REFERENCES network_diffusion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: network_relation_mixture_id_90d68c83_fk_network_mixture_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_relation
    ADD CONSTRAINT network_relation_mixture_id_90d68c83_fk_network_mixture_id FOREIGN KEY (mixture_id) REFERENCES network_mixture(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: network_relation_pr_relation_id_da9a8799_fk_network_relation_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_relation_project
    ADD CONSTRAINT network_relation_pr_relation_id_da9a8799_fk_network_relation_id FOREIGN KEY (relation_id) REFERENCES network_relation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: network_relation_proje_project_id_d69668ed_fk_actors_project_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_relation_project
    ADD CONSTRAINT network_relation_proje_project_id_d69668ed_fk_actors_project_id FOREIGN KEY (project_id) REFERENCES actors_project(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: network_relation_selection_id_09404841_fk_network_selection_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_relation
    ADD CONSTRAINT network_relation_selection_id_09404841_fk_network_selection_id FOREIGN KEY (selection_id) REFERENCES network_selection(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: network_selection_person_id_7ffbeb89_fk_actors_person_id; Type: FK CONSTRAINT; Schema: public; Owner: bioinfo
--

ALTER TABLE ONLY network_selection
    ADD CONSTRAINT network_selection_person_id_7ffbeb89_fk_actors_person_id FOREIGN KEY (person_id) REFERENCES actors_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

