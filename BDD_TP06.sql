LOAD DATA LOCAL INFILE 'C:/Users/Jean-Claude/Desktop/IUT/TP BDD/TP6FichierSource/Client.csv'
INTO TABLE Client
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

LOAD DATA LOCAL INFILE 'C:/Users/Jean-Claude/Desktop/IUT/TP BDD/TP6FichierSource/Commande.csv'
INTO TABLE Commande
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

LOAD DATA LOCAL INFILE 'C:/Users/Jean-Claude/Desktop/IUT/TP BDD/TP6FichierSource/Produit.csv'
INTO TABLE Produit
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

LOAD DATA LOCAL INFILE 'C:/Users/Jean-Claude/Desktop/IUT/TP BDD/TP6FichierSource/Vente.csv'
INTO TABLE Vente
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

LOAD DATA LOCAL INFILE 'C:/Users/Jean-Claude/Desktop/IUT/TP BDD/TP6FichierSource/Boutique.csv'
INTO TABLE Boutique
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

LOAD DATA LOCAL INFILE 'C:/Users/Jean-Claude/Desktop/IUT/TP BDD/TP6FichierSource/Fabrique.csv'
INTO TABLE Fabrique
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

LOAD DATA LOCAL INFILE 'C:/Users/Jean-Claude/Desktop/IUT/TP BDD/TP6FichierSource/Laboratoire.csv'
INTO TABLE Laboratoire
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';




CREATE TABLE Client (
idClient int,
nomClient varchar(45),
telephone int(10),
CONSTRAINT pk_client PRIMARY KEY (idClient)
)
COMMENT 'Précisez que le numéro de téléphone commence toujours pas 0.', ENGINE InnoDB;

CREATE TABLE Commande (
idClient int,
idProduit int,
dateCommande date,
lieuLivraison varchar(45),
quantite int(10),
CONSTRAINT pk_commande PRIMARY KEY (idClient, idProduit, dateCommande)
)
COMMENT 'Par défaut le lieuLivraison est Dijon.', ENGINE InnoDB;

CREATE TABLE Produit (
idProduit int,
prix real(4,2),
categorie varchar(45),
poids real(4,2),
CONSTRAINT pk_produit PRIMARY KEY (idProduit)
)
COMMENT 'Précisez que le poids est en kilogrammes .', ENGINE InnoDB;

CREATE TABLE Vente (
idProduit int,
idBoutique int,
dateVente timestamp,
quantiteVente real(4,2),
CONSTRAINT pk_vente PRIMARY KEY (idProduit, idBoutique, dateVente)
)
COMMENT 'Vente', ENGINE InnoDB;

CREATE TABLE Boutique (
idBoutique int,
gerant varchar(45),
nomBoutique varchar(45),
adresseBoutique varchar(45),
CONSTRAINT pk_boutique PRIMARY KEY (idBoutique)
)
COMMENT 'Boutique', ENGINE InnoDB;

CREATE TABLE Fabrique (
idProduit int,
idLaboratoire int,
dateFabrique timestamp,
quantiteFabrique int,
CONSTRAINT pk_fabrique PRIMARY KEY (idProduit, idLaboratoire, dateFabrique)
)
COMMENT 'Fabrique', ENGINE InnoDB;

CREATE TABLE Laboratoire (
idLaboratoire int,
lieu varchar(45),
nomLaboratoire varchar(45),
CONSTRAINT pk_commande PRIMARY KEY (idLaboratoire)
)
COMMENT 'Laboratoire', ENGINE InnoDB;


ALTER TABLE Commande
ADD CONSTRAINT fk_commande FOREIGN KEY (idClient) REFERENCES Client(idClient);

ALTER TABLE Commande
ADD CONSTRAINT fk_commande2 FOREIGN KEY (idProduit) REFERENCES Produit(idProduit);

ALTER TABLE Vente
ADD CONSTRAINT fk_vente FOREIGN KEY (idProduit) REFERENCES Produit(idProduit);

ALTER TABLE Vente
ADD CONSTRAINT fk_vente2 FOREIGN KEY (idBoutique) REFERENCES Boutique(idBoutique);

ALTER TABLE Fabrique
ADD CONSTRAINT fk_fabrique FOREIGN KEY (idProduit) REFERENCES Produit(idProduit);

ALTER TABLE Fabrique
ADD CONSTRAINT fk_fabrique2 FOREIGN KEY (idLaboratoire) REFERENCES Laboratoire(idLaboratoire);



DELETE FROM Client
WHERE idClient = 3;

DELETE FROM Client
WHERE nomClient = 'Fantome';

UPDATE Client
SET nomClient = 'Bressis'
WHERE nomClient = 'Brezis';



SELECT *
FROM Client
ORDER BY idClient;

SELECT MIN(prix) AS prixMinimum
FROM Produit;

SELECT MAX(prix) AS prixMaximum
FROM Produit;

SELECT AVG(prix) AS prixMoyen
FROM Produit;

SELECT (prix * 1000) / poids AS prixAuKilo
FROM Produit;

SELECT *
FROM Client
ORDER BY nomClient ASC;

SELECT *
FROM Boutique
WHERE nomBoutique like '%pain%';

SELECT *
FROM Produit INNER JOIN Fabrique ON (Produit.idProduit = Fabrique.idProduit) INNER JOIN Laboratoire ON (Fabrique.idLaboratoire = Laboratoire.idLaboratoire)
WHERE Laboratoire.nomLaboratoire = 'SERVIER';

SELECT Boutique.idBoutique, Boutique.nomBoutique, Laboratoire.idLaboratoire, Laboratoire.nomLaboratoire
FROM Boutique INNER JOIN Vente ON (Boutique.idBoutique = Vente.idBoutique) INNER JOIN Fabrique ON (Vente.idProduit = Fabrique.idProduit) INNER JOIN Laboratoire ON (Fabrique.idLaboratoire = Laboratoire.idLaboratoire);

SELECT *
FROM Vente
ORDER BY dateVente;




