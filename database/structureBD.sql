CREATE OR REPLACE DATABASE musicify DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE musicify;

CREATE OR REPLACE TABLE IF NOT EXISTS utilisateurs
(
    id           INT PRIMARY KEY AUTO_INCREMENT,
    prenom       VARCHAR(50)        DEFAULT NOT NULL,
    nom          VARCHAR(50)        DEFAULT NOT NULL,
    email        VARCHAR(50)        DEFAULT NOT NULL,
    password     VARCHAR(255)       DEFAULT NOT NULL,
    nationalite1 VARCHAR(50)        DEFAULT NOT NULL,
    nationalite2 VARCHAR(50)        DEFAULT NULL,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP NULL
);

CREATE OR REPLACE TABLE IF NOT EXISTS ecoutes
(
    id                INT PRIMARY KEY AUTO_INCREMENT,
    date_debut_ecoute TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_fin_ecoute   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    est_terminee      BOOLEAN   NOT NULL DEFAULT FALSE,
    utilisateur_id    INT       NOT NULL,
    id_evaluations    INT       NOT NULL,
    chanson_id        INT       NOT NULL,
    created_at        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP NULL,
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs (id),
    FOREIGN KEY (id_evaluations) REFERENCES evaluations (id),
);
CREATE OR REPLACE TABLE IF NOT EXISTS evaluations
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    note        INT       NOT NULL,
    qualite_audio     TINYINT   NOT NULL,
    qualite_chanson   TINYINT   NOT NULL,
    commentaire TEXT               DEFAULT NULL,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP NULL
);
CREATE OR REPLACE TABLE IF NOT EXISTS artistes
(
    id             INT PRIMARY KEY AUTO_INCREMENT,
    prenom         VARCHAR(50)        DEFAULT NOT NULL,
    nom            VARCHAR(50)        DEFAULT NOT NULL,
    date_naissance DATE               DEFAULT NOT NULL,
    nationalite1   VARCHAR(50)        DEFAULT NOT NULL,
    nationalite2   VARCHAR(50)        DEFAULT NULL,
    biophraphie    TEXT               DEFAULT NOT NULL,
    created_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP NULL
);

CREATE OR REPLACE TABLE IF NOT EXISTS alias_artistes
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    alias      VARCHAR(50)        DEFAULT NOT NULL,
    artiste_id INT       NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (artiste_id) REFERENCES artistes (id)
);

CREATE OR REPLACE TABLE IF NOT EXISTS groupes
(
    id             INT PRIMARY KEY AUTO_INCREMENT,
    nom            VARCHAR(50)        DEFAULT NOT NULL,
    biographie     TEXT               DEFAULT NOT NULL,
    date_fondation DATE               DEFAULT NOT NULL,
    created_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP NULL
);

CREATE OR REPLACE TABLE IF NOT EXISTS groupes_nationalites
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    nationalite VARCHAR(50)        DEFAULT NOT NULL,
    groupe_id   INT       NOT NULL,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP NULL,
    FOREIGN KEY (groupe_id) REFERENCES groupes (id)
);

CREATE OR REPLACE TABLE IF NOT EXISTS artistes_groupes
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    artiste_id INT       NOT NULL,
    groupe_id  INT       NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (artiste_id) REFERENCES artistes (id),
    FOREIGN KEY (groupe_id) REFERENCES groupes (id)
);

CREATE OR REPLACE TABLE IF NOT EXISTS chansons
(
    id            INT PRIMARY KEY AUTO_INCREMENT,
    titre         VARCHAR(50)        DEFAULT NOT NULL,
    duree         TIME               DEFAULT NOT NULL,
    annee         YEAR               DEFAULT NOT NULL,
    contenu_audio TINYBLOB           DEFAULT NOT NULL,
    artiste_id    INT       NOT NULL,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP NULL,
    FOREIGN KEY (artiste_id) REFERENCES artistes (id)
);

CREATE OR REPLACE TABLE IF NOT EXISTS chansons_groupes
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    chanson_id INT       NOT NULL,
    groupe_id  INT       NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (chanson_id) REFERENCES chansons (id),
    FOREIGN KEY (groupe_id) REFERENCES groupes (id)
);

CREATE OR REPLACE TABLE IF NOT EXISTS albums
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    titre       VARCHAR(50)        DEFAULT NOT NULL,
    date_sortie DATE               DEFAULT NOT NULL,
    artiste_id  INT       NOT NULL,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP NULL,
    FOREIGN KEY (artiste_id) REFERENCES artistes (id)
);

CREATE OR REPLACE TABLE IF NOT EXISTS albums_chansons
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    album_id   INT       NOT NULL,
    chanson_id INT       NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (album_id) REFERENCES albums (id),
    FOREIGN KEY (chanson_id) REFERENCES chansons (id)
);

CREATE OR REPLACE TABLE IF NOT EXISTS styles
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    nom        VARCHAR(50)        DEFAULT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL
);

CREATE OR REPLACE TABLE IF NOT EXISTS chansons_styles
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    chanson_id INT       NOT NULL,
    style_id   INT       NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (chanson_id) REFERENCES chansons (id),
    FOREIGN KEY (style_id) REFERENCES styles (id)
);

CREATE OR REPLACE TABLE IF NOT EXISTS artistes_chansons
(
    id            INT PRIMARY KEY AUTO_INCREMENT,
    participation VARCHAR(50) DEFAULT NOT NULL,
    artiste_id    INT NOT NULL,
    chanson_id    INT NOT NULL
);