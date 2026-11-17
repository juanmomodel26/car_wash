-- Base de données : prestations et produits de lavage automobile
-- Compatible SQLite / PostgreSQL (légères adaptations possibles pour MySQL)

DROP TABLE IF EXISTS composition_coffret;
DROP TABLE IF EXISTS composants;
DROP TABLE IF EXISTS produits;
DROP TABLE IF EXISTS prestations;

CREATE TABLE prestations (
    id                    INTEGER PRIMARY KEY,
    nom                   VARCHAR(100) NOT NULL UNIQUE,
    caracteristiques      TEXT NOT NULL,
    detail_service        TEXT,
    duree_heures          INTEGER NOT NULL,
    rdv_necessaire        BOOLEAN NOT NULL DEFAULT TRUE,
    prerequis_id          INTEGER REFERENCES prestations(id),
    prix                  DECIMAL(8,2) NOT NULL,
    description_devis     TEXT NOT NULL
);

CREATE TABLE produits (
    id                    INTEGER PRIMARY KEY,
    nom                   VARCHAR(100) NOT NULL UNIQUE,
    categorie             VARCHAR(30) NOT NULL CHECK (categorie IN ('Coffret','Produit à l''unité')),
    caracteristiques      TEXT NOT NULL,
    prix                  DECIMAL(8,2) NOT NULL,
    description_devis     TEXT NOT NULL
);

-- Éléments entrant dans la composition des coffrets
-- produit_id est renseigné lorsque l'élément est aussi vendu à l'unité
CREATE TABLE composants (
    id                    INTEGER PRIMARY KEY,
    nom                   VARCHAR(100) NOT NULL UNIQUE,
    produit_id            INTEGER REFERENCES produits(id)
);

CREATE TABLE composition_coffret (
    coffret_id            INTEGER NOT NULL REFERENCES produits(id),
    composant_id          INTEGER NOT NULL REFERENCES composants(id),
    quantite              INTEGER NOT NULL DEFAULT 1,
    PRIMARY KEY (coffret_id, composant_id)
);

-- PRESTATIONS
INSERT INTO prestations VALUES
(1,'Lavage extérieur',
 'Le lavage extérieur est l’étape indispensable pour une brillance incomparable et un entretien total de votre véhicule.',
 'Carrosserie, vitres et pare-brise et jantes.',2,TRUE,NULL,69.00,
 'Temps estimé : 2 heures. Prise de rendez-vous nécessaire.'),
(2,'Lavage intérieur',
 'Quoi de mieux que le lavage intérieur pour se sentir agréablement bien dans votre voiture ?',
 'Aspiration, lavage des moquettes et tissus et nettoyage des plastiques.',1,TRUE,NULL,59.00,
 'Temps estimé : 1 heure. Prise de rendez-vous nécessaire.'),
(3,'Lavage extérieur et intérieur',
 'Le lavage extérieur et intérieur est la formule all exclusive pour votre voiture et votre bien-être de conduite.',
 'Carrosserie, vitres et pare-brise, jantes, aspiration, lavage moquettes et tissus et nettoyage des plastiques.',3,TRUE,NULL,109.00,
 'Temps estimé : 3 heures. Prise de rendez-vous nécessaire.'),
(4,'Traitement céramique',
 'Un traitement céramique est une innovation technologique utilisée pour protéger la carrosserie d''un véhicule.',
 NULL,1,TRUE,1,39.00,
 'Temps estimé : 1 heure. Prise de rendez-vous nécessaire. NB : Nécessite un lavage extérieur au préalable.'),
(5,'Lustrage intégral',
 'Il regroupe de multiples techniques qui cherchent à nourrir le vernis ou la peinture d''une carrosserie afin de lui donner un aspect brillant, voire un effet miroir.',
 NULL,2,TRUE,1,49.00,
 'Temps estimé : 2 heures. Prise de rendez-vous nécessaire. NB : Nécessite un lavage extérieur au préalable.');

-- PRODUITS
INSERT INTO produits VALUES
(1,'Coffret lavage normal','Coffret',
 'Le coffret lavage normal permet un lavage simple pour l’extérieur de votre véhicule.',12.00,
 'Sous réserve de stock disponible. Pas de livraison possible, passez en magasin.'),
(2,'Coffret lavage prémium','Coffret',
 'Le coffret lavage prémium permet un lavage efficace pour l’extérieur de votre véhicule.',21.00,
 'Sous réserve de stock disponible. Pas de livraison possible, passez en magasin.'),
(3,'Coffret lavage exclusif','Coffret',
 'Le coffret lavage exclusif permet un lavage total pour l’extérieur de votre véhicule pour une durabilité maximale.',35.00,
 'Sous réserve de stock disponible. Pas de livraison possible, passez en magasin.'),
(4,'Bouteille de savon ultra moussant','Produit à l''unité',
 'Ce savon vous permet la décontamination de votre carrosserie et la désincrustation de salissures et goudron.',6.90,
 'Sous réserve de stock disponible. Pas de livraison possible, passez en magasin.'),
(5,'Pulvérisateur lustrant déperlant','Produit à l''unité',
 'Grâce à ce pulvérisateur, les salissures adhèrent moins à la carrosserie et il évite les traces de calcaire.',4.90,
 'Sous réserve de stock disponible. Pas de livraison possible, passez en magasin.'),
(6,'Cire lustrante','Produit à l''unité',
 'Cette cire s’applique sur une carrosserie sèche et permet une brillance extrême.',16.90,
 'Sous réserve de stock disponible. Pas de livraison possible, passez en magasin.');

-- COMPOSANTS
INSERT INTO composants VALUES
(1,'Bouteille de savon ultra moussant',4),
(2,'Éponge désincrustante',NULL),
(3,'Peau de chamois',NULL),
(4,'Pulvérisateur lustrage déperlant',5),
(5,'Micro fibre',NULL),
(6,'Cire lustrante',6),
(7,'Patin d’application de cire',NULL);

-- COMPOSITION DES COFFRETS
INSERT INTO composition_coffret (coffret_id, composant_id) VALUES
(1,1),(1,2),(1,3),
(2,1),(2,2),(2,3),(2,4),(2,5),
(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7);

-- Exemple de requête : composition de chaque coffret
-- SELECT p.nom AS coffret, GROUP_CONCAT(c.nom, ' ; ') AS contenu
-- FROM produits p
-- JOIN composition_coffret cc ON cc.coffret_id = p.id
-- JOIN composants c ON c.id = cc.composant_id
-- GROUP BY p.id;
