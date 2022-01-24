-- Créer table acteurs
CREATE TABLE acteurs(
    id_acteur INT,
    prenom VARCHAR(20),
    nom VARCHAR(20)
)

-- Définir id_acteur en tant que clé primaire
ALTER TABLE acteurs
ADD CONSTRAINT PK_acteurs PRIMARY KEY (id_acteur)

-- Modifier l'attribut existant id_acteur pour que ça soit un entier AUTO_INCREMENT
ALTER TABLE acteurs
CHANGE id_acteur id_acteur INT AUTO_INCREMENT

-- Peupler acteurs
INSERT INTO acteurs(nom, prenom) VALUES ("Kristen", "Bell");
INSERT INTO acteurs(nom, prenom) VALUES ("William", "Harper");
INSERT INTO acteurs(nom, prenom) VALUES ("Kristen", "Connolly");
INSERT INTO acteurs(nom, prenom) VALUES ("Adam", "Driver");
INSERT INTO acteurs(nom, prenom) VALUES ("Lily", "James");

-- Créer table films
CREATE TABLE films(
    id_film INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(40),
    date_sortie DATE
)

-- Peupler films
INSERT INTO films(titre, date_sortie) VALUES ("Veronica Mars", "2014-03-08");
INSERT INTO films(titre, date_sortie) VALUES ("Midsommar", "2019-07-03");
INSERT INTO films(titre, date_sortie) VALUES ("Paterson", "2016-12-08");
INSERT INTO films(titre, date_sortie) VALUES ("The Cabin in the Woods", "2012-04-13");
INSERT INTO films(titre, date_sortie) VALUES ("Baby Driver", "2017-06-28");

-- Créer table roles
CREATE TABLE roles(
    id_acteur INT,
    id_film INT,
    nom_complet_personnage VARCHAR(40),
    PRIMARY KEY (id_acteur, id_film),
    FOREIGN KEY (id_acteur) REFERENCES acteurs(id_acteur)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_film) REFERENCES films(id_film)  ON DELETE CASCADE ON UPDATE CASCADE
)

-- Peupler roles
INSERT INTO roles VALUES (1, 1, "Veronica Mars");
INSERT INTO roles VALUES (2, 2, "Josh");
INSERT INTO roles VALUES (3, 4, "Dana");
INSERT INTO roles VALUES (3, 5, "Debora");
INSERT INTO roles VALUES (2, 3, "Everett");
INSERT INTO roles VALUES (4, 3, "Paterson");

-- Corriger la date de sortie du film Paterson
UPDATE films
SET date_sortie = "2016-12-28"
WHERE titre = "Paterson"

-- Ajouter champ date_naiss à la table acteurs
ALTER TABLE acteurs
ADD date_naiss DATE
