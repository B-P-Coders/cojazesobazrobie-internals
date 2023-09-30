CREATE TABLE
  public.studies (
    id serial NOT NULL,
    name character varying (255) NULL,
    institution character varying (255) NULL,
    level character varying (255) NULL,
    profile character varying (255) NULL,
    isced_id integer NULL,
    isced_name character varying (255) NULL,
    create_date date NULL,
    is_for_teacher boolean NULL,
    language_list character varying (200) NULL,
    is_shared boolean NULL,
    status character varying (255) NULL,
    expire_date character varying (255) NULL,
    del_date character varying (255) NULL,
    trades character varying (2000) NULL,
    cooperator_id character varying (255) NULL,
    cooperator_name character varying (255) NULL,
    is_abroad_cooperator boolean NULL,
    cooperation_start_date date NULL,
    cooperation_end_date date NULL,
    run_name character varying (255) NULL,
    run_form character varying (255) NULL,
    run_lang character varying (255) NULL,
    run_date date NULL,
    semester_count integer NULL,
    ects_count integer NULL,
    is_dual boolean NULL,
    run_status character varying (255) NULL,
    is_work_cooperation boolean NULL,
    run_title character varying (255) NULL
  );

ALTER TABLE
  public.studies
ADD
  CONSTRAINT studies_pkey PRIMARY KEY (id)