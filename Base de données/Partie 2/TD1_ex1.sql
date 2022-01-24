-- Produits présents dans le dépôt 2

SELECT nom, pu, qte
FROM produits p, stocks s
WHERE p.prod_id = s.prod_id
AND depot_id = 2

-- Capacité maximale d'un dépôt

SELECT MAX(volume)
FROM depots

-- Prix moyen des produits présent dans le dépôt 3

SELECT AVG(pu)
FROM produits p, stocks s
WHERE p.prod_id = s.prod_id
AND depot_id = 3

-- Produits stockés dans les dépôts qui sont en rupture de stock dans ce dépôt (< 10)

SELECT p.prod_id, nom, d.depot_id, adr, qte
FROM produits p, depots d, stocks s
WHERE p.prod_id = s.prod_id
AND d.depot_id= s.depot_id
AND qte < 10

-- Identifiant et adresse du dépôt ayant la capacité de stockage maximale
SELECT depot_id, adr, volume
FROM depots
WHERE volume = (SELECT MAX(VOLUME) FROM depots)


-- Infos du dépôt ayant la capacité de stockage maximale : variante
-- SELECT depot_id, adr, volume
-- FROM depots
-- WHERE volume IN (SELECT MAX(volume) FROM depots)

-- Coût total de la marchandise par dépôt par produit

SELECT depot_id, s.prod_id, pu * qte cout_total
FROM produits p, stocks s
WHERE p.prod_id = s.prod_id
