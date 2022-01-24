-- Prix moyen des produits présent par dépôt
SELECT depot_id, AVG(pu)
FROM produits p, stocks s
WHERE p.prod_id = s.prod_id
GROUP BY depot_id

-- Infos du dépôt + nombre de produits qu'il stocke
SELECT d.depot_id, adr, volume, COUNT(prod_id)
FROM depots d, stocks s
WHERE d.depot_id = s.depot_id
GROUP BY d.depot_id

-- Informations des produits stockés dans le dépôt 3 qui ne sont pas stockés dans le dépôt 1
SELECT nom, pu
FROM produits p, stocks s
WHERE depot_id = 3
AND p.prod_id = s.prod_id
AND p.prod_id NOT IN (
    SELECT prod_id
    FROM stocks
    WHERE depot_id = 1
)

-- Coût total de la marchandise stockée pour chaque dépôt qui stocke au moins 2 produits différents
SELECT depot_id, SUM(pu * qte) cout_total
FROM produits p, stocks s
WHERE p.prod_id = s.prod_id
GROUP BY depot_id
HAVING COUNT(*) >= 2

-- Liste des dépôts qui contiennent tous les produits : variante
SELECT d.depot_id, adr
FROM depots d, stocks s
WHERE d.depot_id = s.depot_id
GROUP BY d.depot_id
HAVING COUNT(*) = (SELECT COUNT(*)
                    FROM produits)

-- Liste des produits qui sont stockés dans tous les dépôts
SELECT *
FROM produits p
WHERE NOT EXISTS(
    SELECT * -- Liste des dépôts
    FROM depots d
    WHERE NOT EXISTS(
        SELECT * -- Liste les stocks
        FROM stocks s
        WHERE s.prod_id = p.prod_id
        AND s.depot_id = d.depot_id
    )
)

-- Liste des produits qui sont stockés dans tous les dépôts : variante
SELECT p.prod_id, nom, qte
FROM produits p, stocks s
WHERE p.prod_id = s.prod_id
GROUP BY p.prod_id
HAVING COUNT(*) = (SELECT COUNT(*)
                    FROM depots)
