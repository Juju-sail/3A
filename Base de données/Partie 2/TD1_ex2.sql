-- Liste des livres de Michel Bussi
SELECT li.id_livre, titre, date_parution
FROM livres li, auteurs a
WHERE li.id_auteur = a.id_auteur
AND nom = "Bussi"


-- Liste des tags associés au livre "L'homme qui mit fin à l'histoire"
SELECT t.id_tag, libelle
FROM tags t, tags_par_livre tl, livres li
WHERE t.id_tag = tl.id_tag
AND tl.id_livre = li.id_livre
AND titre = "L'homme qui mit fin à l'histoire"

-- Liste des emprunts de Clayson Berkowitz

SELECT e.id_emprunt, titre, date_emprunt
FROM livres li, emprunt e, lecteurs le
WHERE li.id_livre = e.id_livre
AND e.id_lecteur = le.id_lecteur
AND nom = "Berkowitz"
AND prenom = "Clayson"

-- Liste des lecteurs n'ayant pas rendu un livre

SELECT le.id_lecteur, le.nom, le.prenom, titre, date_emprunt
FROM livres li, emprunt e, lecteurs le
WHERE li.id_livre = e.id_livre
AND e.id_lecteur = le.id_lecteur
AND est_rendu = false

-- Nom et prénom des auteurs sud-coréens ou japonais

SELECT id_auteur, a.nom, prenom
FROM auteurs a, pays p
WHERE a.nationalite = p.id_pays
AND (p.nom = "Corée du sud"
    OR p.nom = "Japon")

-- Nombre de livres non-rendus par Roselia Gummery

SELECT COUNT(*)
FROM livres li, emprunt e, lecteurs le
WHERE li.id_livre = e.id_livre
AND e.id_lecteur = le.id_lecteur
AND nom = "Gummery"
AND prenom = "Roselia"
AND est_rendu = false

-- Titre, date de parution, noms et prénoms des auteurs de livres parus en 2020
-- https://sql.sh/fonctions/date-heure

SELECT titre, nom, prenom, date_parution
FROM livres l, auteurs a
WHERE YEAR(date_parution) = 2020
AND l.id_auteur = a.id_auteur

-- Liste des livres possédant le tag "Humour" et "Fantasy"
-- https://riptutorial.com/fr/mysql/example/20331/creer-une-table-temporaire

CREATE TEMPORARY TABLE livres_humour
SELECT l.id_livre, titre, date_parution
FROM livres l, tags t, tags_par_livre tl
WHERE libelle = "Humour"
AND   t.id_tag = tl.id_tag
AND   tl.id_livre = l.id_livre;

SELECT titre, date_parution
FROM livres_humour l, tags t, tags_par_livre tl
WHERE libelle = "Fantasy"
AND   t.id_tag = tl.id_tag
AND   tl.id_livre = l.id_livre
