-- Afficher toutes les chansons des groupes avec les noms des artistes ayant participé sur chacune des pièces.
    CREATE OR REPLACE VIEW chansons_artistes AS
    SELECT chansons.id, chansons.titre, chansons.duree, chansons.annee, chansons.genre, chansons.album, chansons.groupe_id, artistes.nom AS artiste_nom
    FROM chansons
    JOIN artistes ON chansons.groupe_id = artistes.id;

-- Afficher toutes les chansons écoutées au complet dans la dernière année regroupée par utilisateur.
    CREATE OR REPLACE VIEW chansons_ecoutees_par_utilisateur AS
    SELECT ecoutes.utilisateur_id, chansons.titre, chansons.duree, chansons.annee, chansons.genre, chansons.album, chansons.groupe_id
    FROM ecoutes
    JOIN chansons ON ecoutes.chanson_id = chansons.id
    WHERE ecoutes.ecoute_complete = 1 AND ecoutes.created_at >= DATE_SUB(NOW(), INTERVAL 1 YEAR)
    GROUP BY ecoutes.utilisateur_id, chansons.titre, chansons.duree, chansons.annee, chansons.genre, chansons.album, chansons.groupe_id;

-- Afficher les chansons les mieux évaluées du dernier mois pour tous les critères.
    CREATE OR REPLACE VIEW chansons_mieux_evaluees AS
    SELECT chansons.id, chansons.titre, chansons.duree, chansons.annee, chansons.genre, chansons.album, chansons.groupe_id, AVG(evaluations.note) AS moyenne
    FROM evaluations
    JOIN chansons ON evaluations.chanson_id = chansons.id
    WHERE evaluations.created_at >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
    GROUP BY chansons.id, chansons.titre, chansons.duree, chansons.annee, chansons.genre, chansons.album, chansons.groupe_id
    ORDER BY moyenne DESC;

-- Afficher les chansons les plus écoutées de la dernière année.
    CREATE OR REPLACE VIEW chansons_plus_ecoutees AS
    SELECT chansons.id, chansons.titre, chansons.duree, chansons.annee, chansons.genre, chansons.album, chansons.groupe_id, COUNT(ecoutes.id) AS nb_ecoutes
    FROM ecoutes
    JOIN chansons ON ecoutes.chanson_id = chansons.id
    WHERE ecoutes.created_at >= DATE_SUB(NOW(), INTERVAL 1 YEAR)
    GROUP BY chansons.id, chansons.titre, chansons.duree, chansons.annee, chansons.genre, chansons.album, chansons.groupe_id
    ORDER BY nb_ecoutes DESC;