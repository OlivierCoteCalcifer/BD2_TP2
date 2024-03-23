-- Lors de la création d’un nouvel utilisateur, assurez-vous que celui-ci n’est pas déjà existant et qu’il est majeur.
    DELIMITER |
    CREATE PROCEDURE ajouter_utilisateur(IN nom VARCHAR(255), IN prenom VARCHAR(255), IN date_naissance DATE)
    BEGIN
        DECLARE age INT;
        SELECT TIMESTAMPDIFF(YEAR, date_naissance, CURDATE()) INTO age;
        IF age < 18 THEN
           SELECT "L'utilisateur doit être majeur" AS message;
        ELSE
            INSERT INTO utilisateurs (nom, prenom, date_naissance) VALUES (nom, prenom, date_naissance);
        END IF;
    END |
-- Tester la procédure ajouter_utilisateur:
    CALL ajouter_utilisateur('nom', 'prenom', '2003-01-01');
    CALL ajouter_utilisateur('nom', 'prenom', '1990-01-01');

-- Obtenir toutes les informations d’un groupe à partir d’une recherche sur le nom.
    DELIMITER |
    CREATE PROCEDURE obtenir_groupe(IN nom VARCHAR(255))
    BEGIN
        SELECT * FROM groupes WHERE nom = nom;
    END |
-- Obtenir toutes les informations d’un artiste à partir d’une recherche sur le nom.
    CALL obtenir_groupe('nom');

-- Ajouter une chanson avec ses styles.Si certains styles n’existent pas, vous devez les ajouter dans le système.
--      Pour le style, seul l’ajout du nom est suffisant,la description sera mise à jour par un autre processus
DELIMITER |
    CREATE PROCEDURE ajouter_chanson(IN titre VARCHAR(255), IN duree INT, IN annee INT, IN genre VARCHAR(255), IN album VARCHAR(255), IN groupe_id INT, IN styles VARCHAR(255))
    BEGIN
    DECLARE style_id INT;
    DECLARE style_nom VARCHAR(255);

    END|



    -- Exemple d'appel de la procédure ajouter_chanson:
CALL ajouter_chanson('titre', 180, 2021, 'genre', 'album', 1, 'style1,style2,style3');

-- Obtenir les statistiques du temps total d’écoute par jour de la semaine (lundi, mardi, mercredi, etc).
   -- Contrainte: Dans cette procédure, vous devez obligatoirement utiliser un curseur sur la table d’écoute pour traiter
   -- individuellement toutes les écoutes.
   -- À la fin, vous devez afficher un tableau contenantpour chaque jour le temps d’écoute total.
   -- Le temps d’écoute peut être calculéà partir de la date de début et la date de fin de chaque écoute.
   -- Si la journée change durant l’écoute, le temps est additionné à la journée du début de l’écoute