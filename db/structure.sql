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

--
-- Name: description_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.description_type AS ENUM (
    'recorded',
    'generated'
);


--
-- Name: vote_direction; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.vote_direction AS ENUM (
    'up',
    'down'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: description_track_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.description_track_comments (
    id bigint NOT NULL,
    desc_track_id bigint NOT NULL,
    comment_author_id bigint NOT NULL,
    comment_text text,
    parent_comment_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: description_track_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.description_track_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: description_track_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.description_track_comments_id_seq OWNED BY public.description_track_comments.id;


--
-- Name: description_track_votes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.description_track_votes (
    id bigint NOT NULL,
    desc_track_id bigint NOT NULL,
    voter_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    vote_dir public.vote_direction
);


--
-- Name: description_track_votes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.description_track_votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: description_track_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.description_track_votes_id_seq OWNED BY public.description_track_votes.id;


--
-- Name: description_tracks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.description_tracks (
    id bigint NOT NULL,
    video_id bigint NOT NULL,
    track_author_id bigint NOT NULL,
    lang character(2) DEFAULT 'en'::bpchar NOT NULL,
    is_generated boolean NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    published boolean NOT NULL
);


--
-- Name: description_tracks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.description_tracks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: description_tracks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.description_tracks_id_seq OWNED BY public.description_tracks.id;


--
-- Name: descriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.descriptions (
    id bigint NOT NULL,
    desc_track_id bigint NOT NULL,
    start_time_sec double precision NOT NULL,
    pause_at_start_time boolean NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    audio_file_loc character varying NOT NULL,
    desc_text text,
    voice_id bigint,
    voice_speed double precision,
    desc_type public.description_type
);


--
-- Name: descriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.descriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: descriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.descriptions_id_seq OWNED BY public.descriptions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    options jsonb DEFAULT '{"default_lang": "en"}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    username character varying,
    auth0_id character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: video_request_upvotes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.video_request_upvotes (
    id bigint NOT NULL,
    video_request_id bigint NOT NULL,
    upvoter_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: video_request_upvotes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.video_request_upvotes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: video_request_upvotes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.video_request_upvotes_id_seq OWNED BY public.video_request_upvotes.id;


--
-- Name: video_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.video_requests (
    id bigint NOT NULL,
    video_id bigint NOT NULL,
    requested_lang character(2),
    requester_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: video_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.video_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: video_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.video_requests_id_seq OWNED BY public.video_requests.id;


--
-- Name: videos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.videos (
    id bigint NOT NULL,
    yt_video_id character varying NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: videos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.videos_id_seq OWNED BY public.videos.id;


--
-- Name: voices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.voices (
    id bigint NOT NULL,
    common_name character varying NOT NULL,
    system_name character varying NOT NULL,
    provider character varying NOT NULL
);


--
-- Name: voices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.voices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: voices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.voices_id_seq OWNED BY public.voices.id;


--
-- Name: description_track_comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.description_track_comments ALTER COLUMN id SET DEFAULT nextval('public.description_track_comments_id_seq'::regclass);


--
-- Name: description_track_votes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.description_track_votes ALTER COLUMN id SET DEFAULT nextval('public.description_track_votes_id_seq'::regclass);


--
-- Name: description_tracks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.description_tracks ALTER COLUMN id SET DEFAULT nextval('public.description_tracks_id_seq'::regclass);


--
-- Name: descriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.descriptions ALTER COLUMN id SET DEFAULT nextval('public.descriptions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: video_request_upvotes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.video_request_upvotes ALTER COLUMN id SET DEFAULT nextval('public.video_request_upvotes_id_seq'::regclass);


--
-- Name: video_requests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.video_requests ALTER COLUMN id SET DEFAULT nextval('public.video_requests_id_seq'::regclass);


--
-- Name: videos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.videos ALTER COLUMN id SET DEFAULT nextval('public.videos_id_seq'::regclass);


--
-- Name: voices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.voices ALTER COLUMN id SET DEFAULT nextval('public.voices_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: description_track_comments description_track_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.description_track_comments
    ADD CONSTRAINT description_track_comments_pkey PRIMARY KEY (id);


--
-- Name: description_track_votes description_track_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.description_track_votes
    ADD CONSTRAINT description_track_votes_pkey PRIMARY KEY (id);


--
-- Name: description_tracks description_tracks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.description_tracks
    ADD CONSTRAINT description_tracks_pkey PRIMARY KEY (id);


--
-- Name: descriptions descriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.descriptions
    ADD CONSTRAINT descriptions_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: video_request_upvotes video_request_upvotes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.video_request_upvotes
    ADD CONSTRAINT video_request_upvotes_pkey PRIMARY KEY (id);


--
-- Name: video_requests video_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.video_requests
    ADD CONSTRAINT video_requests_pkey PRIMARY KEY (id);


--
-- Name: videos videos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- Name: voices voices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.voices
    ADD CONSTRAINT voices_pkey PRIMARY KEY (id);


--
-- Name: index_description_track_comments_on_comment_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_description_track_comments_on_comment_author_id ON public.description_track_comments USING btree (comment_author_id);


--
-- Name: index_description_track_comments_on_desc_track_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_description_track_comments_on_desc_track_id ON public.description_track_comments USING btree (desc_track_id);


--
-- Name: index_description_track_comments_on_parent_comment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_description_track_comments_on_parent_comment_id ON public.description_track_comments USING btree (parent_comment_id);


--
-- Name: index_description_track_votes_on_desc_track_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_description_track_votes_on_desc_track_id ON public.description_track_votes USING btree (desc_track_id);


--
-- Name: index_description_track_votes_on_desc_track_id_and_voter_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_description_track_votes_on_desc_track_id_and_voter_id ON public.description_track_votes USING btree (desc_track_id, voter_id);


--
-- Name: index_description_track_votes_on_voter_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_description_track_votes_on_voter_id ON public.description_track_votes USING btree (voter_id);


--
-- Name: index_description_tracks_on_track_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_description_tracks_on_track_author_id ON public.description_tracks USING btree (track_author_id);


--
-- Name: index_description_tracks_on_video_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_description_tracks_on_video_id ON public.description_tracks USING btree (video_id);


--
-- Name: index_descriptions_on_desc_track_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_descriptions_on_desc_track_id ON public.descriptions USING btree (desc_track_id);


--
-- Name: index_descriptions_on_voice_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_descriptions_on_voice_id ON public.descriptions USING btree (voice_id);


--
-- Name: index_video_request_upvotes_on_upvoter_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_video_request_upvotes_on_upvoter_id ON public.video_request_upvotes USING btree (upvoter_id);


--
-- Name: index_video_request_upvotes_on_video_request_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_video_request_upvotes_on_video_request_id ON public.video_request_upvotes USING btree (video_request_id);


--
-- Name: index_video_request_upvotes_on_video_request_id_and_upvoter_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_video_request_upvotes_on_video_request_id_and_upvoter_id ON public.video_request_upvotes USING btree (video_request_id, upvoter_id);


--
-- Name: index_video_requests_on_requester_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_video_requests_on_requester_id ON public.video_requests USING btree (requester_id);


--
-- Name: index_video_requests_on_video_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_video_requests_on_video_id ON public.video_requests USING btree (video_id);


--
-- Name: index_videos_on_yt_video_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_videos_on_yt_video_id ON public.videos USING btree (yt_video_id);


--
-- Name: index_voices_on_common_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_voices_on_common_name ON public.voices USING btree (common_name);


--
-- Name: index_voices_on_system_name_and_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_voices_on_system_name_and_provider ON public.voices USING btree (system_name, provider);


--
-- Name: description_track_comments fk_rails_0ab621a69f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.description_track_comments
    ADD CONSTRAINT fk_rails_0ab621a69f FOREIGN KEY (parent_comment_id) REFERENCES public.description_track_comments(id);


--
-- Name: description_track_comments fk_rails_213042b4a0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.description_track_comments
    ADD CONSTRAINT fk_rails_213042b4a0 FOREIGN KEY (comment_author_id) REFERENCES public.users(id);


--
-- Name: video_request_upvotes fk_rails_259e983ca1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.video_request_upvotes
    ADD CONSTRAINT fk_rails_259e983ca1 FOREIGN KEY (upvoter_id) REFERENCES public.users(id);


--
-- Name: video_request_upvotes fk_rails_424c88ddc1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.video_request_upvotes
    ADD CONSTRAINT fk_rails_424c88ddc1 FOREIGN KEY (video_request_id) REFERENCES public.video_requests(id);


--
-- Name: description_tracks fk_rails_68bd8b88de; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.description_tracks
    ADD CONSTRAINT fk_rails_68bd8b88de FOREIGN KEY (track_author_id) REFERENCES public.users(id);


--
-- Name: descriptions fk_rails_712eef50a3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.descriptions
    ADD CONSTRAINT fk_rails_712eef50a3 FOREIGN KEY (voice_id) REFERENCES public.voices(id);


--
-- Name: video_requests fk_rails_78e4b92c70; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.video_requests
    ADD CONSTRAINT fk_rails_78e4b92c70 FOREIGN KEY (requester_id) REFERENCES public.users(id);


--
-- Name: video_requests fk_rails_90e184756e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.video_requests
    ADD CONSTRAINT fk_rails_90e184756e FOREIGN KEY (video_id) REFERENCES public.videos(id);


--
-- Name: description_track_votes fk_rails_a4af1ab8f6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.description_track_votes
    ADD CONSTRAINT fk_rails_a4af1ab8f6 FOREIGN KEY (desc_track_id) REFERENCES public.description_tracks(id);


--
-- Name: descriptions fk_rails_bd1077d069; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.descriptions
    ADD CONSTRAINT fk_rails_bd1077d069 FOREIGN KEY (desc_track_id) REFERENCES public.description_tracks(id);


--
-- Name: description_track_comments fk_rails_e78b505b03; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.description_track_comments
    ADD CONSTRAINT fk_rails_e78b505b03 FOREIGN KEY (desc_track_id) REFERENCES public.description_tracks(id);


--
-- Name: description_tracks fk_rails_ecf6330529; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.description_tracks
    ADD CONSTRAINT fk_rails_ecf6330529 FOREIGN KEY (video_id) REFERENCES public.videos(id);


--
-- Name: description_track_votes fk_rails_f4d78577b2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.description_track_votes
    ADD CONSTRAINT fk_rails_f4d78577b2 FOREIGN KEY (voter_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20210313034723'),
('20210313035441'),
('20210313040408'),
('20210313041345'),
('20210313044710'),
('20210313045416'),
('20210313050808'),
('20210313051417'),
('20210313055109'),
('20210314213123'),
('20210314213225'),
('20210315031858'),
('20210315040013'),
('20210315214324'),
('20210318003159'),
('20210318005441'),
('20210318010121'),
('20210318011347'),
('20210318011705'),
('20210318012725'),
('20210321234900'),
('20210324201847');


