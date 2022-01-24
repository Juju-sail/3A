-- Lister les acteur-rice-s qui ont joué un rôle dans le film Iron Man.
Select acteurs.nom, acteurs.prenom
From acteurs, films, role, role_film
Where acteurs.id_acteur = role.id_acteur
and role_film.id_role = role.id_role
and films.id_film = role_film.id_film
and films.titre = 'Iron Man'

-- Lister les rôles qu’a interprété Jennifer Aniston dans des films et séries, du plus récent au plus ancien.
-- Pour un acteur de series :
Select series.titre
from role, role_serie, acteurs, series
Where role_serie.id_role = role.id_role
and series.id_serie = role_serie.id_serie
and acteurs.id_acteur = role.id_acteur
and acteurs.nom = 'Aniston'
and acteurs.prenom = 'Jennifer'

-- Pour un acteur de films :
Select films.titre
from role, role_film, acteurs, films
Where role_film.id_role = role.id_role
and films.id_film = role_film.id_film
and acteurs.id_acteur = role.id_acteur
and acteurs.nom = 'Downey'
and acteurs.prenom = 'Robert'
ORDER BY films.date_sortie

-- Récupérer le nombre de saisons de la série Friends.
Select series.nb_saisons
from series
where series.titre = 'Friends'

-- Récupérer les informations du film le mieux noté.
Select titre, date_sortie, resume, Note 
from films
where Note = (Select max(Note) from films)

-- Calculer la note moyenne des series enregistrées.
Select avg(note)
from series

-- Recuperer la note de la serie Friends.
Select titre, note
from series
where titre = 'Friends'

-- Lister tous les acteur-rice-s qui ont joué plusieurs rôles dans un film ou série.
Select acteurs.nom
from acteurs, role, role_film
where role.id_role = role_film.id_role
and acteurs.id_acteur = role.id_acteur
and 