-- Livres des livres possédant le tag "Humour" et "Fantasy" : variante
SELECT l.id_livre, titre, date_parution
FROM livres l, tags t, tags_par_livre tl
WHERE libelle = "Humour"
AND t.id_tag = tl.id_tag
AND tl.id_livre = l.id_livre
AND l.id_livre IN (
    SELECT id_livre
    FROM tags t, tags_par_livre tl
    WHERE libelle = "Fantasy"
    AND t.id_tag = tl.id_tag)

-- Nombre de livres pour chaque auteur
SELECT nom, COUNT(*)
FROM auteurs a, livres l
WHERE a.id_auteur = l.id_auteur
GROUP BY a.id_auteur

-- Nombre d'emprunts pour chaque lecteur
SELECT nom, COUNT(*)
FROM lecteurs l, emprunt e
WHERE l.id_lecteur = e.id_lecteur
GROUP BY l.id_lecteur


-- Nombre de livres empruntés pour chaque lecteur
SELECT nom, COUNT(DISTINCT id_livre)
FROM lecteurs l, emprunt e
WHERE l.id_lecteur = e.id_lecteur
GROUP BY l.id_lecteur

-- Liste des livres pas encore empruntés par Cahen Reinhard
SELECT *
FROM livres l
WHERE id_livre NOT IN (
    SELECT li.id_livre
    FROM lecteurs l, emprunt e, livres li
    WHERE nom = "Cahen" -- Attwooll
    AND l.id_lecteur = e.id_lecteur
    AND e.id_livre = li.id_livre
)

-- Liste des lecteurs ayant empruntés tous les livres
SELECT l.id_lecteur, nom, prenom
FROM lecteurs l, emprunt e
WHERE l.id_lecteur = e.id_lecteur
GROUP BY id_lecteur
HAVING COUNT(DISTINCT id_livre) = (
    SELECT COUNT(*)
    FROM livres l
)

-- Liste des lecteurs ayant empruntés tous les livres de Pratchett
SELECT l.id_lecteur, l.nom, l.prenom
FROM lecteurs l, emprunt e, livres li, auteurs a
WHERE l.id_lecteur = e.id_lecteur
AND e.id_livre = li.id_livre
AND li.id_auteur = a.id_auteur
AND a.nom = "Pratchett"
GROUP BY id_lecteur
HAVING COUNT(DISTINCT li.id_livre) = (
    SELECT COUNT(*)
    FROM auteurs a, livres l
    WHERE a.id_auteur = l.id_auteur
    AND nom = "Pratchett")
