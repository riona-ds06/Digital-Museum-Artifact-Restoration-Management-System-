-- DBMS Mini Project
-- RIONA JEENA DSOUSZA (PES2UG24CS654) ; RAMYA (PES2UG24CS653)
-- SQL Statements



-- DDL statements:

CREATE DATABASE digital_museum_db;

USE digital_museum_db;

CREATE TABLE MUSEUM (
    museum_id INT AUTO_INCREMENT,
    museum_name VARCHAR(150) NOT NULL,
    description TEXT,
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    contact_email VARCHAR(150),
    contact_phone VARCHAR(30),
    established_year YEAR,

    PRIMARY KEY (museum_id)
);

CREATE TABLE COLLECTION (
    collection_id INT AUTO_INCREMENT,
    museum_id INT NOT NULL,
    collection_name VARCHAR(150) NOT NULL,
    description TEXT,
    historical_period VARCHAR(100),
    collection_type VARCHAR(100),
    date_created DATE,

    PRIMARY KEY (collection_id),

    CONSTRAINT fk_collection_museum
        FOREIGN KEY (museum_id)
        REFERENCES MUSEUM(museum_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE CREATOR (
    creator_id INT NOT NULL,
    creator_name VARCHAR(150) NOT NULL,
    birth_year YEAR,
    nationality VARCHAR(100),
    biography TEXT,

    PRIMARY KEY (creator_id)
);

CREATE TABLE ARTIFACT (
    artifact_id INT AUTO_INCREMENT,
    collection_id INT NOT NULL,
    creator_id INT,
    accession_number VARCHAR(100) NOT NULL,
    artifact_name VARCHAR(200) NOT NULL,
    description TEXT,
    artifact_type VARCHAR(100),
    origin_place VARCHAR(150),
    creation_date DATE,
    estimated_value DECIMAL(15,2),
    acquisition_date DATE,
    status VARCHAR(100),

    PRIMARY KEY (artifact_id),

    CONSTRAINT uq_artifact_accession UNIQUE (accession_number),

    CONSTRAINT fk_artifact_collection
        FOREIGN KEY (collection_id)
        REFERENCES COLLECTION(collection_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_artifact_creator
        FOREIGN KEY (creator_id)
        REFERENCES CREATOR(creator_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE STAFF (
    staff_id INT AUTO_INCREMENT,
    staff_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(30),
    designation VARCHAR(100),
    department VARCHAR(100),
    username VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    staff_status VARCHAR(50),

    PRIMARY KEY (staff_id),

    CONSTRAINT uq_staff_email
        UNIQUE (email),

    CONSTRAINT uq_staff_username
        UNIQUE (username)
);

CREATE TABLE EXHIBITION (
    exhibition_id INT NOT NULL,
    museum_id INT NOT NULL,
    exhibition_name VARCHAR(200) NOT NULL,
    description TEXT,
    theme VARCHAR(150),
    start_date DATE,
    end_date DATE,
    status VARCHAR(50),

    PRIMARY KEY (exhibition_id),

    CONSTRAINT fk_exhibition_museum
        FOREIGN KEY (museum_id)
        REFERENCES MUSEUM(museum_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE DISPLAY (
    exhibition_id INT NOT NULL,
    artifact_id INT NOT NULL,
    display_start_date DATE,
    display_end_date DATE,
    display_location VARCHAR(150),
    display_case VARCHAR(100),
    display_notes TEXT,

    CONSTRAINT fk_display_exhibition
        FOREIGN KEY (exhibition_id)
        REFERENCES EXHIBITION(exhibition_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_display_artifact
        FOREIGN KEY (artifact_id)
        REFERENCES ARTIFACT(artifact_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE ARTIFACT_MEDIA (
    media_id INT NOT NULL,
    artifact_id INT NOT NULL,
    staff_id INT,
    media_type VARCHAR(50),
    file_name VARCHAR(255),
    file_url VARCHAR(500),
    description TEXT,
    uploaded_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    file_size BIGINT,

    PRIMARY KEY (media_id),

    CONSTRAINT fk_media_artifact
        FOREIGN KEY (artifact_id)
        REFERENCES ARTIFACT(artifact_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_media_staff
        FOREIGN KEY (staff_id)
        REFERENCES STAFF(staff_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE ARTIFACT_HISTORY (
    history_id INT AUTO_INCREMENT,
    artifact_id INT NOT NULL,
    staff_id INT,
    event_date DATE NOT NULL,
    event_type VARCHAR(100),
    location VARCHAR(150),
    description TEXT,
    source_reference VARCHAR(500),

    PRIMARY KEY (history_id),

    CONSTRAINT fk_history_artifact
        FOREIGN KEY (artifact_id)
        REFERENCES ARTIFACT(artifact_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_history_staff
        FOREIGN KEY (staff_id)
        REFERENCES STAFF(staff_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE RESTORATION_PROJECT (
    project_id INT AUTO_INCREMENT,
    artifact_id INT NOT NULL,
    manager_id INT,
    project_name VARCHAR(200) NOT NULL,
    objective TEXT,
    start_date DATE,
    end_date DATE,
    status VARCHAR(50),
    cost DECIMAL(15,2),

    PRIMARY KEY (project_id),

    CONSTRAINT fk_project_artifact
        FOREIGN KEY (artifact_id)
        REFERENCES ARTIFACT(artifact_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_project_manager
        FOREIGN KEY (manager_id)
        REFERENCES STAFF(staff_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE CONDITION_ASSESSMENT (
    assessment_id INT AUTO_INCREMENT,
    artifact_id INT NOT NULL,
    staff_id INT,
    assessment_date DATE NOT NULL,
    conditions VARCHAR(100),
    damage_type VARCHAR(100),
    damage_description TEXT,
    recommended_action TEXT,
    priority VARCHAR(50),

    PRIMARY KEY (assessment_id),

    CONSTRAINT fk_assessment_artifact
        FOREIGN KEY (artifact_id)
        REFERENCES ARTIFACT(artifact_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_assessment_staff
        FOREIGN KEY (staff_id)
        REFERENCES STAFF(staff_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE RESTORATION_EXPERT (
    expert_id INT AUTO_INCREMENT,
    expert_name VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    phone VARCHAR(30),
    hours_worked DECIMAL(8,2),

    PRIMARY KEY (expert_id)
);

CREATE TABLE PROJECT_EXPERT (
    project_id INT NOT NULL,
    expert_id INT NOT NULL,

    CONSTRAINT fk_project_expert_project
        FOREIGN KEY (project_id)
        REFERENCES RESTORATION_PROJECT(project_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_project_expert_expert
        FOREIGN KEY (expert_id)
        REFERENCES RESTORATION_EXPERT(expert_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE RESTORATION_MATERIAL (
    material_id INT AUTO_INCREMENT,
    material_name VARCHAR(150) NOT NULL,
    material_type VARCHAR(100),
    supplier VARCHAR(150),
    unit VARCHAR(50),
    unit_cost DECIMAL(12,2),
    quantity_used DECIMAL(10,2),
    total_cost DECIMAL(15,2),

    PRIMARY KEY (material_id)
);

CREATE TABLE PROJECT_MATERIAL (
    project_id INT NOT NULL,
    material_id INT NOT NULL,

    CONSTRAINT fk_project_material_project
        FOREIGN KEY (project_id)
        REFERENCES RESTORATION_PROJECT(project_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_project_material_material
        FOREIGN KEY (material_id)
        REFERENCES RESTORATION_MATERIAL(material_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE VISITOR (
    visitor_id INT AUTO_INCREMENT,
    visitor_name VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    phone VARCHAR(30),
    age INT,
    nationality VARCHAR(100),
    registration_date DATE,

    PRIMARY KEY (visitor_id)
);

CREATE TABLE VISIT_RECORD (
    visit_id INT AUTO_INCREMENT,
    visitor_id INT NOT NULL,
    museum_id INT NOT NULL,
    visit_date DATE NOT NULL,
    entry_time TIME,
    exit_time TIME,
    visit_type VARCHAR(50),
    ticket_type VARCHAR(50),

    PRIMARY KEY (visit_id),

    CONSTRAINT fk_visit_visitor
        FOREIGN KEY (visitor_id)
        REFERENCES VISITOR(visitor_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_visit_museum
        FOREIGN KEY (museum_id)
        REFERENCES MUSEUM(museum_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

SHOW TABLES;

DESC ARTIFACT;

DESC ARTIFACT_HISTORY;

DESC ARTIFACT_MEDIA;

DESC COLLECTION;

DESC CONDITION_ASSESSMENT;

DESC CREATOR;

DESC DISPLAY;

DESC EXHIBITION;

DESC MUSEUM;

DESC PROJECT_EXPERT;

DESC PROJECT_MATERIAL;

DESC RESTORATION_EXPERT;

DESC RESTORATION_MATERIAL;

DESC RESTORATION_PROJECT;

DESC STAFF;

DESC VISITOR;

DESC VISIT_RECORD;



-- DML statements:


INSERT INTO MUSEUM
(museum_id, museum_name, description, address, city, state, country, contact_email, contact_phone, established_year)
VALUES
(1, 'National Heritage Museum',
 'Museum preserving Indian historical and cultural artifacts.',
 'MG Road', 'Bengaluru', 'Karnataka', 'India',
 'info@nationalheritage.com', '08040001001', 1985),

(2, 'Royal History Museum',
 'Museum dedicated to royal history and traditional artifacts.',
 'Palace Road', 'Mysuru', 'Karnataka', 'India',
 'info@royalhistory.com', '08214000102', 1992),

(3, 'Indian Art Museum',
 'Museum showcasing traditional and modern Indian art.',
 'Museum Road', 'New Delhi', 'Delhi', 'India',
 'info@indianartmuseum.com', '01140001003', 1978),

(4, 'South Indian Heritage Museum',
 'Museum preserving cultural heritage from South India.',
 'Temple Street', 'Chennai', 'Tamil Nadu', 'India',
 'info@sihmuseum.com', '04440001004', 1995),

(5, 'Ancient Civilisation Museum',
 'Museum containing archaeological and ancient civilisation artifacts.',
 'Heritage Avenue', 'Hyderabad', 'Telangana', 'India',
 'info@ancientcivilisation.com', '04040001005', 2001);


INSERT INTO COLLECTION
(collection_id, museum_id, collection_name, description, historical_period, collection_type, date_created)
VALUES
(1, 1, 'Ancient Indian Art',
 'Collection of ancient Indian sculptures and artwork.',
 'Ancient India', 'Sculpture', '1986-01-10'),

(2, 1, 'Medieval Manuscripts',
 'Collection of historical manuscripts and documents.',
 'Medieval Period', 'Manuscript', '1987-05-15'),

(3, 2, 'Royal Heritage',
 'Artifacts belonging to historical royal families.',
 'Medieval India', 'Royal Artifacts', '1993-03-20'),

(4, 2, 'Mysuru Palace Collection',
 'Objects associated with Mysuru royal history.',
 '18th-20th Century', 'Royal Collection', '1994-04-15'),

(5, 3, 'Indian Paintings',
 'Collection of traditional Indian paintings.',
 '19th-20th Century', 'Painting', '1979-02-12'),

(6, 3, 'Modern Art',
 'Collection of modern Indian artworks.',
 '20th-21st Century', 'Modern Art', '1985-07-21'),

(7, 4, 'Temple Artifacts',
 'Artifacts collected from South Indian temples.',
 'Ancient-Medieval', 'Religious Art', '1996-03-10'),

(8, 4, 'Traditional Crafts',
 'Traditional crafts and handmade cultural objects.',
 '19th-20th Century', 'Craft', '1997-08-18'),

(9, 5, 'Archaeological Collection',
 'Artifacts discovered through archaeological research.',
 'Ancient Period', 'Archaeological', '2002-01-20'),

(10, 5, 'Coins and Currency',
 'Historical coins and currency from different periods.',
 'Ancient-Modern', 'Numismatics', '2003-06-11');

ALTER TABLE CREATOR
MODIFY birth_year INT;

INSERT INTO CREATOR
(creator_id, creator_name, birth_year, nationality, biography)
VALUES
(1, 'Ravi Varma', 1848, 'Indian',
 'Indian painter known for paintings based on Indian mythology.'),

(2, 'Unknown Ancient Sculptor', 1200, 'Indian',
 'Ancient sculptor whose identity remains unknown.'),

(3, 'Mysuru Royal Artisan', 1750, 'Indian',
 'Traditional artisan associated with the Mysuru royal court.'),

(4, 'Unknown Manuscript Artist', 1600, 'Indian',
 'Artist responsible for illustrating historical manuscripts.'),

(5, 'Abanindranath Tagore', 1871, 'Indian',
 'Indian painter and one of the founders of the Bengal School of Art.'),

(6, 'Nandalal Bose', 1882, 'Indian',
 'Indian painter associated with the Bengal School of Art.'),

(7, 'Jamini Roy', 1887, 'Indian',
 'Indian painter known for folk-inspired artistic styles.'),

(8, 'Unknown Temple Artisan', 1400, 'Indian',
 'Traditional artisan responsible for temple artwork.'),

(9, 'Ancient Metalworker', 1100, 'Indian',
 'Ancient artisan specializing in metal objects.'),

(10, 'Royal Coin Maker', 1650, 'Indian',
 'Artisan associated with historical royal coin production.');


INSERT INTO STAFF
(staff_id, staff_name, email, phone, designation, department, username, password_hash, staff_status)
VALUES
(1, 'Anita Rao', 'anita@museum.com', '9876500001',
 'Curator', 'Collections', 'anita.rao', 'hash_anita123', 'Active'),

(2, 'Rahul Sharma', 'rahul@museum.com', '9876500002',
 'Restoration Manager', 'Restoration', 'rahul.sharma', 'hash_rahul123', 'Active'),

(3, 'Meera Nair', 'meera@museum.com', '9876500003',
 'Archivist', 'Archives', 'meera.nair', 'hash_meera123', 'Active'),

(4, 'Kiran Kumar', 'kiran@museum.com', '9876500004',
 'Museum Director', 'Administration', 'kiran.kumar', 'hash_kiran123', 'Active'),

(5, 'Priya Menon', 'priya@museum.com', '9876500005',
 'Conservator', 'Restoration', 'priya.menon', 'hash_priya123', 'Active'),

(6, 'Vivek Rao', 'vivek@museum.com', '9876500006',
 'Researcher', 'Research', 'vivek.rao', 'hash_vivek123', 'Active'),

(7, 'Sneha Iyer', 'sneha@museum.com', '9876500007',
 'Curator', 'Exhibitions', 'sneha.iyer', 'hash_sneha123', 'Active'),

(8, 'Arjun Das', 'arjun@museum.com', '9876500008',
 'Security Officer', 'Security', 'arjun.das', 'hash_arjun123', 'Active'),

(9, 'Divya Shah', 'divya@museum.com', '9876500009',
 'Archivist', 'Archives', 'divya.shah', 'hash_divya123', 'Active'),

(10, 'Manoj Kumar', 'manoj@museum.com', '9876500010',
 'Technician', 'Digital Archives', 'manoj.kumar', 'hash_manoj123', 'Active');


INSERT INTO ARTIFACT
(artifact_id, collection_id, creator_id, accession_number, artifact_name,
 description, artifact_type, origin_place, creation_date,
 estimated_value, acquisition_date, status)
VALUES
(1, 1, 2, 'ART-001',
 'Ancient Stone Sculpture',
 'Stone sculpture depicting an ancient Indian deity.',
 'Sculpture', 'Hampi', '1250-01-01',
 250000.00, '1986-03-12', 'Good'),

(2, 1, 2, 'ART-002',
 'Granite Temple Statue',
 'Carved granite statue from a historic temple.',
 'Sculpture', 'Hampi', '1300-01-01',
 320000.00, '1987-04-15', 'Good'),

(3, 2, 4, 'ART-003',
 'Royal Manuscript',
 'Handwritten manuscript containing historical records.',
 'Manuscript', 'Mysuru', '1650-01-01',
 150000.00, '1988-04-10', 'Good'),

(4, 2, 4, 'ART-004',
 'Historical Document',
 'Historical administrative document.',
 'Document', 'Karnataka', '1700-01-01',
 80000.00, '1990-08-19', 'Good'),

(5, 3, 3, 'ART-005',
 'Royal Wooden Chest',
 'Decorated wooden chest used by a historical royal family.',
 'Furniture', 'Mysuru', '1780-01-01',
 180000.00, '1994-02-15', 'Damaged'),

(6, 3, 3, 'ART-006',
 'Royal Sword',
 'Ceremonial sword belonging to a royal collection.',
 'Weapon', 'Mysuru', '1775-01-01',
 300000.00, '1995-07-11', 'Good'),

(7, 4, 3, 'ART-007',
 'Royal Throne',
 'Decorated wooden throne used for ceremonial purposes.',
 'Furniture', 'Mysuru', '1800-01-01',
 550000.00, '1996-01-20', 'Needs Restoration'),

(8, 4, 3, 'ART-008',
 'Royal Jewellery Box',
 'Ornamented jewellery box from the royal collection.',
 'Furniture', 'Mysuru', '1820-01-01',
 210000.00, '1997-05-12', 'Good'),

(9, 5, 1, 'ART-009',
 'Mythological Painting',
 'Painting depicting an Indian mythological scene.',
 'Painting', 'Mysuru', '1890-01-01',
 450000.00, '1987-06-20', 'Needs Restoration'),

(10, 5, 5, 'ART-010',
 'Bharat Mata Painting',
 'Traditional Indian painting representing Bharat Mata.',
 'Painting', 'Kolkata', '1905-01-01',
 500000.00, '1990-02-11', 'Good'),

(11, 5, 6, 'ART-011',
 'Village Life Painting',
 'Painting depicting rural Indian life.',
 'Painting', 'Kolkata', '1920-01-01',
 350000.00, '1995-03-22', 'Good'),

(12, 6, 7, 'ART-012',
 'Folk Art Composition',
 'Folk-inspired modern Indian artwork.',
 'Painting', 'West Bengal', '1935-01-01',
 280000.00, '2000-07-15', 'Good'),

(13, 7, 8, 'ART-013',
 'Temple Bronze Idol',
 'Traditional bronze idol from a South Indian temple.',
 'Religious Artifact', 'Tamil Nadu', '1450-01-01',
 400000.00, '1998-04-18', 'Damaged'),

(14, 7, 8, 'ART-014',
 'Temple Stone Panel',
 'Decorative stone panel from an ancient temple.',
 'Sculpture', 'Tamil Nadu', '1500-01-01',
 275000.00, '1999-08-20', 'Good'),

(15, 8, 8, 'ART-015',
 'Traditional Wooden Doll',
 'Traditional South Indian wooden craft.',
 'Craft', 'Karnataka', '1880-01-01',
 65000.00, '2001-05-10', 'Good'),

(16, 8, 8, 'ART-016',
 'Handwoven Textile',
 'Traditional handwoven textile with cultural patterns.',
 'Textile', 'Tamil Nadu', '1900-01-01',
 95000.00, '2002-09-14', 'Needs Restoration'),

(17, 9, 9, 'ART-017',
 'Ancient Bronze Vessel',
 'Bronze vessel discovered during archaeological research.',
 'Vessel', 'Andhra Pradesh', '1100-01-01',
 600000.00, '2003-01-22', 'Good'),

(18, 9, 9, 'ART-018',
 'Ancient Terracotta Figure',
 'Terracotta figure from an archaeological excavation.',
 'Terracotta', 'Telangana', '1000-01-01',
 220000.00, '2004-03-18', 'Damaged'),

(19, 10, 10, 'ART-019',
 'Ancient Gold Coin',
 'Historical gold coin from a royal period.',
 'Coin', 'Hyderabad', '1650-01-01',
 750000.00, '2005-06-10', 'Good'),

(20, 10, 10, 'ART-020',
 'Silver Royal Coin',
 'Historical silver coin belonging to a royal collection.',
 'Coin', 'Hyderabad', '1700-01-01',
 180000.00, '2006-08-25', 'Good');

INSERT INTO EXHIBITION
(exhibition_id, museum_id, exhibition_name, description, theme, start_date, end_date, status)
VALUES
(1, 1, 'Indian Heritage Exhibition',
 'Exhibition showcasing important Indian historical artifacts.',
 'Indian Heritage', '2026-01-01', '2026-06-30', 'Active'),

(2, 1, 'Ancient Sculptures',
 'Collection of ancient Indian sculptures.',
 'Ancient Art', '2026-03-01', '2026-08-31', 'Active'),

(3, 2, 'Royal Mysuru Collection',
 'Artifacts from the Mysuru royal period.',
 'Royal Heritage', '2026-02-01', '2026-12-31', 'Active'),

(4, 2, 'Palace Treasures',
 'Royal furniture and ceremonial objects.',
 'Royal Treasures', '2026-04-01', '2026-09-30', 'Active'),

(5, 3, 'Masters of Indian Painting',
 'Exhibition of famous Indian paintings.',
 'Indian Painting', '2026-01-15', '2026-05-30', 'Completed'),

(6, 4, 'Temple Heritage',
 'Traditional temple artifacts from South India.',
 'Temple Culture', '2026-05-01', '2026-10-31', 'Active'),

(7, 4, 'Traditional Crafts',
 'Exhibition of traditional South Indian crafts.',
 'Traditional Crafts', '2026-06-01', '2026-11-30', 'Planned'),

(8, 5, 'Archaeological Discoveries',
 'Important archaeological discoveries.',
 'Archaeology', '2026-02-15', '2026-07-31', 'Active');

INSERT INTO DISPLAY
(exhibition_id, artifact_id, display_start_date, display_end_date,
 display_location, display_case, display_notes)
VALUES
(1, 1, '2026-01-01', '2026-06-30', 'Gallery A', 'A1', 'Ancient sculpture section'),
(1, 3, '2026-01-01', '2026-06-30', 'Gallery A', 'A2', 'Historical manuscripts'),
(1, 9, '2026-01-01', '2026-06-30', 'Gallery B', 'B1', 'Indian paintings'),

(2, 2, '2026-03-01', '2026-08-31', 'Gallery C', 'C1', 'Granite sculpture'),
(2, 14, '2026-03-01', '2026-08-31', 'Gallery C', 'C2', 'Temple stone panel'),

(3, 5, '2026-02-01', '2026-12-31', 'Royal Gallery', 'R1', 'Royal furniture'),
(3, 6, '2026-02-01', '2026-12-31', 'Royal Gallery', 'R2', 'Royal ceremonial sword'),
(3, 7, '2026-02-01', '2026-12-31', 'Royal Gallery', 'R3', 'Royal throne'),

(4, 8, '2026-04-01', '2026-09-30', 'Palace Gallery', 'P1', 'Royal jewellery box'),

(5, 10, '2026-01-15', '2026-05-30', 'Painting Gallery', 'PG1', 'Bengal School painting'),
(5, 11, '2026-01-15', '2026-05-30', 'Painting Gallery', 'PG2', 'Village life painting'),

(6, 13, '2026-05-01', '2026-10-31', 'Temple Gallery', 'T1', 'Bronze idol'),
(6, 14, '2026-05-01', '2026-10-31', 'Temple Gallery', 'T2', 'Temple stone panel'),

(8, 17, '2026-02-15', '2026-07-31', 'Archaeology Gallery', 'AR1', 'Bronze vessel'),
(8, 18, '2026-02-15', '2026-07-31', 'Archaeology Gallery', 'AR2', 'Terracotta figure');

INSERT INTO ARTIFACT_MEDIA
(media_id, artifact_id, staff_id, media_type, file_name, file_url, description, file_size)
VALUES
(1, 1, 1, 'Image', 'artifact001.jpg',
 'https://museum.com/media/artifact001.jpg',
 'Front view of stone sculpture.', 250000),

(2, 2, 1, 'Image', 'artifact002.jpg',
 'https://museum.com/media/artifact002.jpg',
 'Granite temple statue image.', 280000),

(3, 3, 3, 'Document', 'artifact003.pdf',
 'https://museum.com/media/artifact003.pdf',
 'Digital copy of royal manuscript.', 850000),

(4, 5, 1, 'Image', 'artifact005.jpg',
 'https://museum.com/media/artifact005.jpg',
 'Royal wooden chest image.', 310000),

(5, 6, 1, 'Image', 'artifact006.jpg',
 'https://museum.com/media/artifact006.jpg',
 'Royal sword image.', 290000),

(6, 7, 7, 'Image', 'artifact007.jpg',
 'https://museum.com/media/artifact007.jpg',
 'Royal throne image.', 350000),

(7, 9, 1, 'Image', 'artifact009.jpg',
 'https://museum.com/media/artifact009.jpg',
 'Mythological painting photograph.', 420000),

(8, 10, 7, 'Image', 'artifact010.jpg',
 'https://museum.com/media/artifact010.jpg',
 'Bharat Mata painting photograph.', 450000),

(9, 13, 5, 'Image', 'artifact013.jpg',
 'https://museum.com/media/artifact013.jpg',
 'Temple bronze idol photograph.', 300000),

(10, 15, 5, 'Image', 'artifact015.jpg',
 'https://museum.com/media/artifact015.jpg',
 'Traditional wooden doll photograph.', 180000),

(11, 17, 6, 'Image', 'artifact017.jpg',
 'https://museum.com/media/artifact017.jpg',
 'Ancient bronze vessel photograph.', 320000),

(12, 19, 6, 'Image', 'artifact019.jpg',
 'https://museum.com/media/artifact019.jpg',
 'Ancient gold coin photograph.', 150000);

INSERT INTO ARTIFACT_HISTORY
(history_id, artifact_id, staff_id, event_date, event_type,
 location, description, source_reference)
VALUES
(1, 1, 1, '1986-03-12', 'Acquisition',
 'National Heritage Museum',
 'Artifact acquired and added to museum collection.',
 'Acquisition Register 1986'),

(2, 2, 1, '1987-04-15', 'Acquisition',
 'National Heritage Museum',
 'Granite statue added to collection.',
 'Acquisition Register 1987'),

(3, 3, 3, '1988-04-10', 'Acquisition',
 'National Heritage Museum',
 'Royal manuscript added to archives.',
 'Archive Register 1988'),

(4, 5, 1, '1994-02-15', 'Acquisition',
 'Royal History Museum',
 'Royal wooden chest acquired.',
 'Royal Collection Register'),

(5, 6, 1, '1995-07-11', 'Acquisition',
 'Royal History Museum',
 'Royal sword acquired.',
 'Royal Collection Register'),

(6, 7, 2, '1996-01-20', 'Acquisition',
 'Royal History Museum',
 'Royal throne added to collection.',
 'Royal Collection Register'),

(7, 9, 1, '1987-06-20', 'Acquisition',
 'Indian Art Museum',
 'Mythological painting acquired.',
 'Painting Register'),

(8, 10, 7, '1990-02-11', 'Acquisition',
 'Indian Art Museum',
 'Bharat Mata painting acquired.',
 'Painting Register'),

(9, 11, 7, '1995-03-22', 'Acquisition',
 'Indian Art Museum',
 'Village life painting acquired.',
 'Painting Register'),

(10, 13, 1, '1998-04-18', 'Acquisition',
 'South Indian Heritage Museum',
 'Bronze temple idol acquired.',
 'Temple Artifact Register'),

(11, 14, 1, '1999-08-20', 'Acquisition',
 'South Indian Heritage Museum',
 'Temple stone panel acquired.',
 'Temple Artifact Register'),

(12, 15, 6, '2001-05-10', 'Acquisition',
 'South Indian Heritage Museum',
 'Traditional wooden doll acquired.',
 'Craft Register'),

(13, 17, 6, '2003-01-22', 'Discovery',
 'Ancient Civilisation Museum',
 'Bronze vessel obtained through archaeological research.',
 'Archaeology Report 2003'),

(14, 18, 6, '2004-03-18', 'Discovery',
 'Ancient Civilisation Museum',
 'Terracotta figure discovered during excavation.',
 'Archaeology Report 2004'),

(15, 19, 6, '2005-06-10', 'Acquisition',
 'Ancient Civilisation Museum',
 'Ancient gold coin acquired.',
 'Numismatic Register');

INSERT INTO RESTORATION_PROJECT
(project_id, artifact_id, manager_id, project_name, objective,
 start_date, end_date, status, cost)
VALUES
(1, 9, 2, 'Mythological Painting Restoration',
 'Restore damaged paint layers and improve structural stability.',
 '2026-01-15', '2026-05-15', 'In Progress', 75000.00),

(2, 5, 2, 'Royal Wooden Chest Restoration',
 'Repair structural damage and restore original surface finish.',
 '2026-02-01', '2026-07-01', 'Planned', 55000.00),

(3, 7, 2, 'Royal Throne Conservation',
 'Restore damaged wooden structure and decorative elements.',
 '2026-03-01', '2026-08-30', 'In Progress', 120000.00),

(4, 13, 5, 'Bronze Idol Conservation',
 'Clean and preserve the historical bronze surface.',
 '2026-04-01', '2026-06-30', 'Planned', 65000.00),

(5, 16, 5, 'Textile Restoration',
 'Restore damaged fibers and preserve traditional patterns.',
 '2026-05-01', '2026-09-30', 'Planned', 45000.00),

(6, 18, 2, 'Terracotta Figure Restoration',
 'Repair cracks and stabilize the terracotta artifact.',
 '2026-02-15', '2026-05-30', 'Completed', 38000.00),

(7, 14, 5, 'Temple Stone Panel Conservation',
 'Clean and stabilize the historical stone panel.',
 '2026-06-01', '2026-10-31', 'Planned', 70000.00),

(8, 4, 2, 'Historical Document Preservation',
 'Preserve and digitally archive the historical document.',
 '2026-01-10', '2026-04-30', 'Completed', 30000.00);

INSERT INTO CONDITION_ASSESSMENT
(assessment_id, artifact_id, staff_id, assessment_date,
 conditions, damage_type, damage_description,
 recommended_action, priority)
VALUES
(1, 9, 2, '2026-01-10','Poor', 'Surface Damage',
 'Paint layer is damaged in multiple areas.','Clean surface and restore damaged paint.',
 'High'),

(2, 5, 2, '2026-01-20','Fair', 'Structural Damage',
 'Wooden structure has cracks and weakened joints.','Repair joints and treat damaged wood.',
 'Medium'),

(3, 7, 2, '2026-02-01','Poor', 'Structural Damage',
 'Several wooden joints are unstable.','Structural restoration required.',
 'High'),

(4, 13, 5, '2026-02-10','Fair', 'Surface Corrosion',
 'Bronze surface has developed oxidation.','Clean and apply conservation coating.',
 'Medium'),

(5, 16, 5, '2026-02-15','Poor', 'Fiber Damage',
 'Several textile fibers are weakened.','Textile conservation required.',
 'High'),

(6, 18, 2, '2026-02-20','Poor', 'Cracking',
 'Terracotta figure contains multiple cracks.','Stabilize and repair cracks.',
 'High'),

(7, 14, 5, '2026-03-05','Fair', 'Surface Wear',
 'Stone surface shows signs of weathering.','Surface cleaning and stabilization.',
 'Medium'),

(8, 2, 1, '2026-03-10','Good', 'Minor Wear',
 'Minor surface wear observed.','Routine monitoring.',
 'Low'),

(9, 3, 3, '2026-03-15','Good', 'Paper Aging',
 'Paper has minor signs of aging.','Climate-controlled storage.',
 'Low'),

(10, 6, 1, '2026-03-20','Good', 'Minor Scratches',
 'Minor scratches observed on surface.','Routine conservation.',
 'Low'),

(11, 10, 7, '2026-03-25','Good', 'Minor Wear',
 'Minor frame and surface wear.','Routine conservation.',
 'Low'),

(12, 15, 5, '2026-04-01','Good', 'Surface Wear',
 'Minor wear due to handling.','Preventive conservation.',
 'Low');

INSERT INTO RESTORATION_EXPERT
(expert_id, expert_name, email, phone, hours_worked)
VALUES
(1, 'Dr. Arjun Kumar', 'arjun@restoration.com', '9988700001', 120.00),

(2, 'Priya Menon', 'priya@restoration.com', '9988700002', 85.50),

(3, 'Vikram Rao', 'vikram@restoration.com', '9988700003', 60.00),

(4, 'Kavya Iyer', 'kavya@restoration.com', '9988700004', 95.00),

(5, 'Suresh Bhat', 'suresh@restoration.com', '9988700005', 72.50),

(6, 'Neha Sharma', 'neha@restoration.com', '9988700006', 110.00),

(7, 'Rohan Das', 'rohan@restoration.com', '9988700007', 65.00),

(8, 'Lakshmi Rao', 'lakshmi@restoration.com', '9988700008', 88.00);


INSERT INTO PROJECT_EXPERT
(project_id, expert_id)
VALUES
(1, 1),
(1, 2),
(1, 4),

(2, 2),
(2, 3),

(3, 1),
(3, 5),
(3, 6),

(4, 4),
(4, 7),

(5, 6),
(5, 8),

(6, 3),
(6, 5),

(7, 1);

INSERT INTO RESTORATION_MATERIAL
(material_id, material_name, material_type, supplier, unit,
 unit_cost, quantity_used, total_cost)
VALUES
(1, 'Archival Adhesive', 'Adhesive',
 'Heritage Supplies', 'litre', 2500.00, 5.00, 12500.00),

(2, 'Protective Varnish', 'Coating',
 'Heritage Supplies', 'litre', 3500.00, 4.00, 14000.00),

(3, 'Wood Treatment Oil', 'Wood Treatment',
 'Conservation Materials Ltd', 'litre', 1800.00, 6.00, 10800.00),

(4, 'Cleaning Solution', 'Cleaning',
 'Conservation Materials Ltd', 'litre', 1200.00, 5.00, 6000.00),

(5, 'Archival Paper', 'Paper',
 'Museum Supplies India', 'sheet', 150.00, 100.00, 15000.00),

(6, 'Protective Glass', 'Glass',
 'Heritage Supplies', 'sqft', 850.00, 20.00, 17000.00),

(7, 'Gold Leaf', 'Decorative',
 'Traditional Materials Co', 'sheet', 450.00, 50.00, 22500.00),

(8, 'Bronze Cleaner', 'Cleaning',
 'Conservation Materials Ltd', 'litre', 2200.00, 4.00, 8800.00),

(9, 'Textile Support Fabric', 'Textile',
 'Heritage Textiles', 'metre', 900.00, 15.00, 13500.00),

(10, 'Stone Consolidant', 'Stone Treatment',
 'Heritage Supplies', 'litre', 3200.00, 5.00, 16000.00);

INSERT INTO PROJECT_MATERIAL
(project_id, material_id)
VALUES
(1, 1),
(1, 2),
(1, 4),

(2, 3),
(2, 4),
(2, 7),

(3, 3),
(3, 6),
(3, 7),

(4, 4),
(4, 8),

(5, 5),
(5, 9),

(6, 1),
(6, 4),

(7, 4),
(7, 10),

(8, 1),
(8, 5),
(8, 6);


INSERT INTO VISITOR
(visitor_id, visitor_name, email, phone, age, nationality, registration_date)
VALUES
(1, 'Aarav Singh', 'aarav@gmail.com', '9000000001', 24, 'Indian', '2026-01-05'),

(2, 'Ananya Rao', 'ananya@gmail.com', '9000000002', 21, 'Indian', '2026-01-10'),

(3, 'John Smith', 'john@gmail.com', '9000000003', 35, 'British', '2026-02-15'),

(4, 'Sophia Lee', 'sophia@gmail.com', '9000000004', 28, 'Singaporean', '2026-03-01'),

(5, 'Rahul Verma', 'rahulv@gmail.com', '9000000005', 30, 'Indian', '2026-03-05'),

(6, 'Sneha Kapoor', 'sneha@gmail.com', '9000000006', 22, 'Indian', '2026-03-12'),

(7, 'David Wilson', 'david@gmail.com', '9000000007', 42, 'British', '2026-03-20'),

(8, 'Emily Brown', 'emily@gmail.com', '9000000008', 31, 'American', '2026-03-25'),

(9, 'Vikram Shetty', 'vikram@gmail.com', '9000000009', 26, 'Indian', '2026-04-01'),

(10, 'Priya Nair', 'priya@gmail.com', '9000000010', 23, 'Indian', '2026-04-05'),

(11, 'Michael Chen', 'michael@gmail.com', '9000000011', 38, 'Singaporean', '2026-04-10'),

(12, 'Kavya Menon', 'kavya@gmail.com', '9000000012', 27, 'Indian', '2026-04-15'),

(13, 'Daniel Garcia', 'daniel@gmail.com', '9000000013', 34, 'Spanish', '2026-04-20'),

(14, 'Meera Iyer', 'meera.visitor@gmail.com', '9000000014', 29, 'Indian', '2026-04-25'),

(15, 'Lucas Martin', 'lucas@gmail.com', '9000000015', 40, 'French', '2026-05-01');

INSERT INTO VISIT_RECORD
(visit_id, visitor_id, museum_id, visit_date,
 entry_time, exit_time, visit_type, ticket_type)
VALUES
(1, 1, 1, '2026-02-10', '10:00:00', '13:00:00', 'Individual', 'General'),

(2, 2, 1, '2026-02-12', '11:00:00', '14:00:00', 'Individual', 'Student'),

(3, 3, 2, '2026-03-05', '09:30:00', '12:30:00', 'Tourist', 'General'),

(4, 4, 2, '2026-03-10', '14:00:00', '17:00:00', 'Tourist', 'General'),

(5, 5, 1, '2026-03-15', '10:30:00', '13:30:00', 'Individual', 'General'),

(6, 6, 3, '2026-03-18', '11:00:00', '15:00:00', 'Student', 'Student'),

(7, 7, 3, '2026-03-20', '09:00:00', '12:00:00', 'Tourist', 'General'),

(8, 8, 4, '2026-03-22', '10:00:00', '13:00:00', 'Tourist', 'General'),

(9, 9, 4, '2026-03-25', '12:00:00', '15:00:00', 'Individual', 'Student'),

(10, 10, 5, '2026-03-28', '09:30:00', '12:30:00', 'Tourist', 'General'),

(11, 11, 5, '2026-04-01', '10:00:00', '14:00:00', 'Tourist', 'General'),

(12, 12, 1, '2026-04-03', '11:00:00', '13:00:00', 'Individual', 'Student'),

(13, 13, 2, '2026-04-05', '09:00:00', '12:00:00', 'Tourist', 'General'),

(14, 14, 3, '2026-04-08', '13:00:00', '16:00:00', 'Individual', 'General'),

(15, 15, 4, '2026-04-10', '10:30:00', '14:00:00', 'Tourist', 'General'),

(16, 1, 5, '2026-04-12', '09:00:00', '12:00:00', 'Individual', 'General'),

(17, 2, 2, '2026-04-15', '10:00:00', '13:00:00', 'Individual', 'Student'),

(18, 3, 1, '2026-04-18', '11:00:00', '14:30:00', 'Tourist', 'General'),

(19, 4, 3, '2026-04-20', '09:30:00', '12:30:00', 'Tourist', 'General'),

(20, 5, 4, '2026-04-22', '10:00:00', '13:00:00', 'Individual', 'General'),

(21, 6, 5, '2026-04-25', '12:00:00', '15:00:00', 'Student', 'Student'),

(22, 7, 1, '2026-04-27', '09:00:00', '11:30:00', 'Tourist', 'General'),

(23, 8, 2, '2026-04-29', '10:00:00', '13:00:00', 'Individual', 'General'),

(24, 9, 3, '2026-05-01', '11:00:00', '14:00:00', 'Student', 'Student'),

(25, 10, 5, '2026-05-03', '09:30:00', '12:30:00', 'Tourist', 'General');


UPDATE ARTIFACT
SET estimated_value = 300000.00
WHERE artifact_id = 1;

UPDATE ARTIFACT
SET status = 'Needs Restoration'
WHERE artifact_id = 2;

DELETE FROM VISITOR
WHERE visitor_id = 15;



-- SELECT , WHERE , ORDER BY, GROUP BY , aggregate functions, joins, subqueries

SELECT artifact_id, artifact_name, estimated_value
FROM ARTIFACT
WHERE estimated_value > 300000;

SELECT creator_id, creator_name, birth_year
FROM CREATOR
ORDER BY birth_year ASC;

SELECT artifact_type, COUNT(*) AS total_artifacts
FROM ARTIFACT
GROUP BY artifact_type;

SELECT COUNT(*) AS total_artifacts
FROM ARTIFACT;

SELECT AVG(estimated_value) AS average_artifact_value
FROM ARTIFACT;

SELECT
    A.artifact_id,
    A.artifact_name,
    C.collection_name
FROM ARTIFACT A
INNER JOIN COLLECTION C
ON A.collection_id = C.collection_id;

SELECT artifact_id, artifact_name, estimated_value
FROM ARTIFACT
WHERE estimated_value >
      (SELECT AVG(estimated_value)
       FROM ARTIFACT);

SELECT artifact_id, artifact_name, estimated_value
FROM ARTIFACT
WHERE estimated_value =
      (SELECT MAX(estimated_value)
       FROM ARTIFACT);

SELECT artifact_type, COUNT(*) AS total_artifacts
FROM ARTIFACT
GROUP BY artifact_type
HAVING COUNT(*) > 1;


-- Triggers:

-- Trigger to automatically calculate material cost
DELIMITER $$

CREATE TRIGGER trg_material_before_insert
BEFORE INSERT ON RESTORATION_MATERIAL
FOR EACH ROW
BEGIN
    SET NEW.total_cost = NEW.unit_cost * NEW.quantity_used;
END$$

DELIMITER ;

INSERT INTO RESTORATION_MATERIAL
(material_id, material_name, material_type, supplier,
 unit, unit_cost, quantity_used, total_cost)
VALUES
(11, 'Conservation Wax', 'Protective Material',
 'Heritage Supplies', 'kg', 1500.00, 4.00, 0);

SELECT material_id, material_name, unit_cost,
       quantity_used, total_cost
FROM RESTORATION_MATERIAL
WHERE material_id = 11;

-- Trigger to prevent an exhibition ending before it starts
DELIMITER $$

CREATE TRIGGER trg_exhibition_before_insert
BEFORE INSERT ON EXHIBITION
FOR EACH ROW
BEGIN
    IF NEW.end_date < NEW.start_date THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Exhibition end date cannot be before start date';
    END IF;
END$$

DELIMITER ;

INSERT INTO EXHIBITION
(exhibition_id, museum_id, exhibition_name,
 description, theme, start_date, end_date, status)
VALUES
(9, 1, 'Invalid Exhibition',
 'Testing date validation',
 'Test',
 '2026-12-01',
 '2026-10-01',
 'Planned');


-- Functions:

-- Function to calculate artifact age
DELIMITER $$

CREATE FUNCTION fn_artifact_age(p_artifact_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_age INT;

    SELECT TIMESTAMPDIFF(
        YEAR,
        creation_date,
        CURDATE()
    )
    INTO v_age
    FROM ARTIFACT
    WHERE artifact_id = p_artifact_id;

    RETURN v_age;
END$$

DELIMITER ;

SELECT
    artifact_id,
    artifact_name,
    fn_artifact_age(artifact_id) AS Artifact_Age
FROM ARTIFACT;


-- Function to calculate total restoration cost
DELIMITER $$

CREATE FUNCTION fn_total_restoration_cost(p_artifact_id INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(12,2);

    SELECT COALESCE(SUM(cost), 0.00)
    INTO v_total
    FROM RESTORATION_PROJECT
    WHERE artifact_id = p_artifact_id;

    RETURN v_total;
END$$

DELIMITER ;

SELECT
    artifact_id,
    artifact_name,
    fn_total_restoration_cost(artifact_id) AS Total_Restoration_Cost
FROM ARTIFACT;


-- Procedures:

-- Procedure to display all artifacts of a particular status
DELIMITER $$

CREATE PROCEDURE sp_artifacts_by_status(IN p_status VARCHAR(50))
BEGIN
    SELECT
        artifact_id,
        artifact_name,
        artifact_type,
        estimated_value,
        status
    FROM ARTIFACT
    WHERE status = p_status
    ORDER BY artifact_name;
END$$

DELIMITER ;

CALL sp_artifacts_by_status('Needs Restoration');


-- Procedure to display restoration projects for an artifact
DELIMITER $$

CREATE PROCEDURE sp_artifact_restoration_projects(IN p_artifact_id INT)
BEGIN
    SELECT
        project_id,
        project_name,
        objective,
        start_date,
        end_date,
        status,
        cost
    FROM RESTORATION_PROJECT
    WHERE artifact_id = p_artifact_id
    ORDER BY start_date;
END$$

DELIMITER ;

CALL sp_artifact_restoration_projects(4);


