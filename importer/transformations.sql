/* name */
SELECT DISTINCT name INTO TABLE study_names FROM studies;
ALTER TABLE study_names ADD COLUMN id integer;
CREATE SEQUENCE study_names_id_seq OWNED BY study_names.id;
ALTER TABLE study_names ALTER COLUMN id SET DEFAULT nextval('study_names_id_seq');
UPDATE study_names SET id = nextval('study_names_id_seq');
UPDATE studies SET name = (SELECT id FROM study_names WHERE name = studies.name);
ALTER TABLE study_names ADD CONSTRAINT study_names_unique_id UNIQUE(id);
ALTER TABLE studies ALTER COLUMN name TYPE integer USING (name::integer);
ALTER TABLE studies RENAME COLUMN name TO name_id;
ALTER TABLE studies ADD FOREIGN KEY (name_id) REFERENCES study_names(id);

/* institutions */
SELECT DISTINCT institution INTO TABLE institutions FROM studies;
ALTER TABLE institutions ADD COLUMN id integer;
CREATE SEQUENCE institutions_id_seq OWNED BY institutions.id;
ALTER TABLE institutions ALTER COLUMN id SET DEFAULT nextval('institutions_id_seq');
UPDATE institutions SET id = nextval('institutions_id_seq');
UPDATE studies SET institution = (SELECT id FROM institutions WHERE institution = studies.institution);
ALTER TABLE institutions ADD CONSTRAINT institutions_unique_id UNIQUE(id);
ALTER TABLE studies ALTER COLUMN institution TYPE integer USING (institution::integer);
ALTER TABLE studies RENAME COLUMN institution TO institution_id;
ALTER TABLE institutions ADD PRIMARY KEY (id);
ALTER TABLE studies ADD FOREIGN KEY (institution_id) REFERENCES institutions(id);

/* level */
CREATE TYPE study_level AS enum('jednolite magisterskie', 'drugiego stopnia', 'pierwszego stopnia');
ALTER table studies ALTER COLUMN level TYPE study_level USING (level::study_level);

/* profile */
CREATE TYPE study_profile AS enum('praktyczny', 'ogólnoakademicki');
ALTER table studies ALTER COLUMN profile TYPE study_profile USING (profile::study_profile);

/* isced */
SELECT DISTINCT isced_id, isced_name INTO TABLE isced FROM studies;
ALTER TABLE isced ADD COLUMN id integer;
CREATE SEQUENCE isced_id_seq OWNED BY isced.id;
ALTER TABLE isced ALTER COLUMN id SET DEFAULT nextval('isced_id_seq');
UPDATE isced SET id = nextval('isced_id_seq');
UPDATE studies SET isced_id = (SELECT id FROM isced WHERE isced_id = studies.isced_id);
ALTER TABLE isced ADD CONSTRAINT isced_unique_id UNIQUE(id);
ALTER TABLE studies ALTER COLUMN isced_id TYPE integer USING (isced_id::integer);
ALTER TABLE studies DROP COLUMN isced_name;
ALTER TABLE isced ADD PRIMARY KEY (id);
ALTER TABLE studies ADD FOREIGN KEY (isced_id) REFERENCES isced(id);

/* status */
CREATE TYPE study_status AS enum('wygaszane', 'zlikwidowane', 'prowadzone');
ALTER table studies ALTER COLUMN status TYPE study_status USING (status::study_status);

/* cooperator */
SELECT DISTINCT cooperator_id, cooperator_name, is_abroad_cooperator INTO TABLE cooperators FROM studies;
ALTER TABLE cooperators ADD COLUMN id integer;
CREATE SEQUENCE cooperators_id_seq OWNED BY cooperators.id;
ALTER TABLE cooperators ALTER COLUMN id SET DEFAULT nextval('cooperators_id_seq');
UPDATE cooperators SET id = nextval('cooperators_id_seq');
UPDATE studies SET cooperator_id = (SELECT id FROM cooperators WHERE cooperator_id = cooperators.cooperator_id LIMIT 1);
ALTER TABLE cooperators ADD CONSTRAINT cooperators_unique_id UNIQUE(id);
ALTER TABLE studies ALTER COLUMN cooperator_id TYPE integer USING (cooperator_id::integer);
ALTER TABLE studies DROP COLUMN cooperator_name;
ALTER TABLE studies DROP COLUMN ia_abroad_cooperator;
ALTER TABLE cooperators ADD PRIMARY KEY (id);
ALTER TABLE studies ADD FOREIGN KEY (cooperator_id) REFERENCES cooperators(id);

/* run name */
SELECT DISTINCT run_name INTO TABLE run_names FROM studies;
ALTER TABLE run_names ADD COLUMN id integer;
CREATE SEQUENCE run_names_id_seq OWNED BY run_names.id;
ALTER TABLE run_names ALTER COLUMN id SET DEFAULT nextval('run_names_id_seq');
UPDATE run_names SET id = nextval('run_names_id_seq');
UPDATE studies SET run_name = (SELECT id FROM run_names WHERE run_name = studies.run_name);
ALTER TABLE run_names ADD CONSTRAINT run_names_unique_id UNIQUE(id);
ALTER TABLE studies ALTER COLUMN run_name TYPE integer USING (run_name::integer);
ALTER TABLE studies RENAME COLUMN run_name TO run_name_id;
ALTER TABLE run_names ADD PRIMARY KEY (id);
ALTER TABLE studies ADD FOREIGN KEY (run_name_id) REFERENCES run_names(id);

/* run status */
ALTER table studies ALTER COLUMN run_status TYPE study_status USING (run_status::study_status);

/* run titles */
CREATE TYPE title AS enum('licencjat', 'inżynier', 'magister', 'magister inżynier');
ALTER table studies ALTER COLUMN run_title TYPE title USING (run_title::title);

/* languages */
SELECT DISTINCT run_lang INTO TABLE languages FROM studies;
ALTER TABLE languages ADD COLUMN id integer;
CREATE SEQUENCE languages_id_seq OWNED BY languages.id;
ALTER TABLE languages ALTER COLUMN id SET DEFAULT nextval('languages_id_seq');
UPDATE languages SET id = nextval('languages_id_seq');
UPDATE studies SET run_lang = (SELECT id FROM languages WHERE run_lang = languages.run_lang LIMIT 1);
ALTER TABLE languages ADD CONSTRAINT languages_unique_id UNIQUE(id);
ALTER TABLE studies ALTER COLUMN run_lang TYPE integer USING (run_lang::integer);
ALTER TABLE studies RENAME COLUMN run_lang TO lang_id;
ALTER TABLE languages ADD PRIMARY KEY (id);
ALTER TABLE studies ADD FOREIGN KEY (lang_id) REFERENCES languages(id);
ALTER TABLE languages RENAME COLUMN run_lang TO language;
