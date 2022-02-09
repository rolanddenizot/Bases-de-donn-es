DROP DATABASE IF EXISTS veloMax;
CREATE DATABASE veloMax;
USE veloMax;
SET sql_safe_updates=0;
--
DROP TABLE IF EXISTS bicyclette;
DROP TABLE IF EXISTS liste_Assemblage;
DROP TABLE IF EXISTS boutique_Entreprise;
DROP TABLE IF EXISTS commande;
DROP TABLE IF EXISTS client_particulier;
DROP TABLE IF EXISTS piece;
DROP TABLE IF EXISTS fournisseur;
DROP TABLE IF EXISTS programme_fidelio;
DROP TABLE IF EXISTS constitution;
DROP TABLE IF EXISTS approvisionnement;
DROP TABLE IF EXISTS commande_velo;
DROP TABLE IF EXISTS commande_piece;
--
CREATE TABLE `veloMax`.`liste_Assemblage` (
  `id_liste_assemblage` VARCHAR(4) NOT NULL,
  `nom_liste_assemblage` VARCHAR(15) NULL,
  `grandeur` VARCHAR(20) NOT NULL,
  `cadre` VARCHAR(20) NULL,
  `guidon` VARCHAR(20) NULL,
  `freins` VARCHAR(20) NULL,
  `selle` VARCHAR(20) NULL,
  `derailleur_avant` VARCHAR(20) NULL,
  `derailleur_arriere` VARCHAR(20) NULL,
  `roue_avant` VARCHAR(20) NULL,
  `roue_arriere` VARCHAR(20) NULL,
  `reflecteurs` VARCHAR(20) NULL,
  `pedalier` VARCHAR(20) NULL,
  `ordinateur` VARCHAR(20) NULL,
  `panier` VARCHAR(20) NULL,
  PRIMARY KEY (`id_liste_assemblage`) );
--
CREATE TABLE `veloMax`.`piece` (
  `id_piece` VARCHAR(20) NOT NULL,
  `numero_produit_piece` VARCHAR(20) NOT NULL,
  `description_piece` VARCHAR(100) NULL,
  `date_introduction_marche_piece` DATETIME NULL,
  `date_discontinuation_production_piece` DATETIME NULL,
  `quantite_en_stock` INTEGER NULL,
  PRIMARY KEY (`id_piece`) );
--
CREATE TABLE `veloMax`.`fournisseur` (
  `siret` VARCHAR(14) NOT NULL,
  `nom_fournisseur` VARCHAR(20) NULL,
  `contact_fournisseur` VARCHAR(40) NULL,
  `rue_fournisseur` VARCHAR(40) NULL,
  `ville_fournisseur` VARCHAR(20) NULL,
  `code_postal_fournisseur` INTEGER NULL,
  `province_fournisseur` VARCHAR(20) NULL,
  `libelle` INTEGER NULL,
  PRIMARY KEY (`siret`) );
--
CREATE TABLE `veloMax`.`boutique_Entreprise` (
  `nom_compagnie` VARCHAR(20) NOT NULL,
  `rue_entreprise` VARCHAR(40) NULL,
  `ville_entreprise` VARCHAR(20) NULL,
  `code_postal_entreprise` INTEGER NULL,
  `province_entreprise` VARCHAR(20) NULL,
  `telephone_entreprise` VARCHAR(20) NULL,
  `courriel_entreprise` VARCHAR(40) NULL,
  `nom_personne_contact` VARCHAR(20) NULL,
  `volume_total_achat` INTEGER NULL,
  `remise` DOUBLE NULL,
  PRIMARY KEY (`nom_compagnie`) );
--
  CREATE TABLE `veloMax`.`programme_fidelio` (
  `id_programme` VARCHAR(20) NOT NULL,
  `description_programme` VARCHAR(100) NULL,
  `cout_programme` FLOAT NULL,
  `duree_programme` INTEGER NULL,
  `rabais_programme` FLOAT NULL,
  PRIMARY KEY (`id_programme`) );
--
CREATE TABLE `veloMax`.`bicyclette` (
  `numero_produit_bicyclette` VARCHAR(4) NOT NULL,
  `nom_modele` VARCHAR(20) NULL,
  `grandeur_modele` VARCHAR(20) NULL,
  `prix_unitaire` INTEGER,
  `ligne_produit` VARCHAR(20) NULL,
  `date_introduction_bicyclette` DATETIME NULL,
  `date_discontinuation_bicyclette` DATETIME NULL, 
  `id_liste_assemblage` VARCHAR(4) NOT NULL,
  `quantite_velo_en_stock` INTEGER,
   PRIMARY KEY (`numero_produit_bicyclette`),
   INDEX `F_bicy1_idx` (`id_liste_assemblage` ASC),
   CONSTRAINT `id_liste_assemblage` FOREIGN KEY (`id_liste_assemblage`)
		REFERENCES `veloMax`.`liste_Assemblage` (`id_liste_assemblage`)
		ON DELETE CASCADE
		ON UPDATE NO ACTION);
--
  CREATE TABLE `veloMax`.`approvisionnement` (
  `id_piece` VARCHAR(20) NOT NULL,
  `siret` VARCHAR(20) NOT NULL,
  `prix_unitaire_piece` FLOAT NULL,
  `delai_approvisionnement_piece` INTEGER NULL,
  `numero_produit_catalogue_fournisseur` VARCHAR(20) NULL,
  `quantite_appro`INTEGER NULL,
   PRIMARY KEY (`id_piece`, `siret`),
   INDEX `F_appro1_idx` (`id_piece` ASC),
   INDEX `F_appro2_idx` (`siret` ASC),
   CONSTRAINT `id_piece` FOREIGN KEY (`id_piece`)
		REFERENCES `veloMax`.`piece` (`id_piece`)
		ON DELETE CASCADE
		ON UPDATE NO ACTION,
  CONSTRAINT `siret` FOREIGN KEY (`siret`)
		REFERENCES `veloMax`.`fournisseur` (`siret`)
		ON DELETE CASCADE
		ON UPDATE NO ACTION );
--
  CREATE TABLE `veloMax`.`client_particulier` (
  `id_client` VARCHAR(20) NOT NULL,
  `nom_client` VARCHAR(20) NULL,
  `prenom_client` VARCHAR(20) NULL,
  `courriel_client` VARCHAR(30) NULL,
  `telephone_client` VARCHAR(20) NULL,
  `rue_client` VARCHAR(30) NULL,
  `ville_client` VARCHAR(20) NULL,
  `code_postal_client` INTEGER NULL,
  `province_client` VARCHAR(20) NULL,
  `date_adhesion` DATETIME NULL,
  `id_programme` VARCHAR(20),
  PRIMARY KEY (`id_client`), 
  INDEX `F_client_part2_idx` (`id_programme` ASC),
CONSTRAINT `id_programme` FOREIGN KEY (`id_programme`)
	REFERENCES `veloMax`.`programme_fidelio` (`id_programme`)
	ON DELETE CASCADE
	ON UPDATE NO ACTION );
--
  CREATE TABLE `veloMax`.`commande` (
  `numero_commande` VARCHAR(20) NOT NULL,
  `date_commande` DATETIME NULL,
  `rue_comm` VARCHAR(30) NULL,
  `ville_comm` VARCHAR(20) NULL,
  `code_postal_com` INTEGER NULL,
  `province_com` VARCHAR(20) NULL,
  `date_livraison` DATETIME NULL,
  `nom_compagnie` VARCHAR(20),
  `id_client` VARCHAR(20),
  PRIMARY KEY (`numero_commande`),
    INDEX `F_comm1_idx` (`nom_compagnie` ASC),
	INDEX `F_comm2_idx` (`id_client` ASC),
   CONSTRAINT `nom_compagnie` FOREIGN KEY (`nom_compagnie`)
		REFERENCES `veloMax`.`boutique_Entreprise` (`nom_compagnie`)
		ON DELETE CASCADE
		ON UPDATE NO ACTION,
   CONSTRAINT `id_client` FOREIGN KEY (`id_client`)
		REFERENCES `veloMax`.`client_particulier` (`id_client`)
		ON DELETE CASCADE
		ON UPDATE NO ACTION  );
-- 
  CREATE TABLE `veloMax`.`commande_velo` (
  `numero_produit_bicyclette` VARCHAR(4) NOT NULL,
  `numero_commande` VARCHAR(20) NOT NULL,
  `quantite_velo` INTEGER NULL,
   PRIMARY KEY (`numero_produit_bicyclette`, `numero_commande`),
   INDEX `F_comm_velo1_idx` (`numero_produit_bicyclette` ASC),
   INDEX `F_comm_velo2_idx` (`numero_commande` ASC),
   CONSTRAINT `numero_produit_bicyclette` FOREIGN KEY (`numero_produit_bicyclette`)
		REFERENCES `veloMax`.`bicyclette` (`numero_produit_bicyclette`)
		ON DELETE CASCADE
		ON UPDATE NO ACTION,
  CONSTRAINT `numero_commande` FOREIGN KEY (`numero_commande`)
		REFERENCES `veloMax`.`commande` (`numero_commande`)
		ON DELETE CASCADE
		ON UPDATE NO ACTION );
  
  CREATE TABLE `veloMax`.`constitution` (
  `id_liste_assemblage2` VARCHAR(4) NOT NULL,
  `id_piece3` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_liste_assemblage2`, `id_piece3`),
	INDEX `F_const1_idx` (`id_liste_assemblage2` ASC),
	INDEX `F_const2_idx` (`id_piece3` ASC)  );
        
  CREATE TABLE `veloMax`.`commande_piece` (
  `id_piece2` VARCHAR(20) NOT NULL,
  `numero_commande2` VARCHAR(20) NOT NULL,
  `quantite_piece` INTEGER NULL,
   PRIMARY KEY (`id_piece2`, `numero_commande2`),
   INDEX `F_comm_piece1_idx` (`id_piece2` ASC),
   INDEX `F_comm_piece2_idx` (`numero_commande2` ASC) );   
--
-- insertion dans la table liste_assemblage 
INSERT INTO `veloMax`.`liste_Assemblage` (`id_liste_assemblage`,`nom_liste_assemblage`,`grandeur`,`cadre`,`guidon`,`freins`,`selle`,`derailleur_avant`,`derailleur_arriere`,`roue_avant`,`roue_arriere`,`reflecteurs`,`pedalier`,`ordinateur`,`panier`) VALUES ('1','Kilimandjaro','Adultes','C32','G7','F3','S88','DV133','DR56','R45','R46',null,'P12','O2',null);
INSERT INTO `veloMax`.`liste_Assemblage` (`id_liste_assemblage`,`nom_liste_assemblage`,`grandeur`,`cadre`,`guidon`,`freins`,`selle`,`derailleur_avant`,`derailleur_arriere`,`roue_avant`,`roue_arriere`,`reflecteurs`,`pedalier`,`ordinateur`,`panier`) VALUES ('2','NorthPole','Adultes','C34','G7','F3','S88','DV17','DR87','R48','R47',null,'P12',null,null);
INSERT INTO `veloMax`.`liste_Assemblage` (`id_liste_assemblage`,`nom_liste_assemblage`,`grandeur`,`cadre`,`guidon`,`freins`,`selle`,`derailleur_avant`,`derailleur_arriere`,`roue_avant`,`roue_arriere`,`reflecteurs`,`pedalier`,`ordinateur`,`panier`) VALUES ('3','MontBlanc','Jeunes','C76','G7','F3','S88','DV17','DR87','R48','R47',null,'P12','O2',null);
INSERT INTO `veloMax`.`liste_Assemblage` (`id_liste_assemblage`,`nom_liste_assemblage`,`grandeur`,`cadre`,`guidon`,`freins`,`selle`,`derailleur_avant`,`derailleur_arriere`,`roue_avant`,`roue_arriere`,`reflecteurs`,`pedalier`,`ordinateur`,`panier`) VALUES ('4','Hooligan','Jeunes','C76','G7','F3','S88','DV87','DR86','R12','R32',null,'P12',null,null);
INSERT INTO `veloMax`.`liste_Assemblage` (`id_liste_assemblage`,`nom_liste_assemblage`,`grandeur`,`cadre`,`guidon`,`freins`,`selle`,`derailleur_avant`,`derailleur_arriere`,`roue_avant`,`roue_arriere`,`reflecteurs`,`pedalier`,`ordinateur`,`panier`) VALUES ('5','Orleans','Hommes','C43','G9','F9','S37','DV57','DR86','R19','R18','R02','P34',null,null);
INSERT INTO `veloMax`.`liste_Assemblage` (`id_liste_assemblage`,`nom_liste_assemblage`,`grandeur`,`cadre`,`guidon`,`freins`,`selle`,`derailleur_avant`,`derailleur_arriere`,`roue_avant`,`roue_arriere`,`reflecteurs`,`pedalier`,`ordinateur`,`panier`) VALUES ('6','Orleans','Dames','C44f','G9','F9','S35','DV57','DR86','R19','R18','R02','P34',null,null);
INSERT INTO `veloMax`.`liste_Assemblage` (`id_liste_assemblage`,`nom_liste_assemblage`,`grandeur`,`cadre`,`guidon`,`freins`,`selle`,`derailleur_avant`,`derailleur_arriere`,`roue_avant`,`roue_arriere`,`reflecteurs`,`pedalier`,`ordinateur`,`panier`) VALUES ('7','BlueJay','Hommes','C43','G9','F9','S37','DV57','DR87','R19','R18','R02','P34','O4',null);
INSERT INTO `veloMax`.`liste_Assemblage` (`id_liste_assemblage`,`nom_liste_assemblage`,`grandeur`,`cadre`,`guidon`,`freins`,`selle`,`derailleur_avant`,`derailleur_arriere`,`roue_avant`,`roue_arriere`,`reflecteurs`,`pedalier`,`ordinateur`,`panier`) VALUES ('8','BlueJay','Dames','C43f','G9','F9','S35','DV57','DR87','R19','R18','R02','P34','O4',null);
INSERT INTO `veloMax`.`liste_Assemblage` (`id_liste_assemblage`,`nom_liste_assemblage`,`grandeur`,`cadre`,`guidon`,`freins`,`selle`,`derailleur_avant`,`derailleur_arriere`,`roue_avant`,`roue_arriere`,`reflecteurs`,`pedalier`,`ordinateur`,`panier`) VALUES ('9','Trail Explorer','Filles','C01','G12',null,'S02',null,null,'R1','R2','R09','P1',null,'S01');
INSERT INTO `veloMax`.`liste_Assemblage` (`id_liste_assemblage`,`nom_liste_assemblage`,`grandeur`,`cadre`,`guidon`,`freins`,`selle`,`derailleur_avant`,`derailleur_arriere`,`roue_avant`,`roue_arriere`,`reflecteurs`,`pedalier`,`ordinateur`,`panier`) VALUES ('10','Trail Explorer','Garçons','C02','G12',null,'S03',null,null,'R1','R2','R09','P1',null,'S05');
INSERT INTO `veloMax`.`liste_Assemblage` (`id_liste_assemblage`,`nom_liste_assemblage`,`grandeur`,`cadre`,`guidon`,`freins`,`selle`,`derailleur_avant`,`derailleur_arriere`,`roue_avant`,`roue_arriere`,`reflecteurs`,`pedalier`,`ordinateur`,`panier`) VALUES ('11','Night Hawk','Jeunes','C15','G12','F9','S36','DV15','DR23','R11','R12','R10','P15',null,'S74');
INSERT INTO `veloMax`.`liste_Assemblage` (`id_liste_assemblage`,`nom_liste_assemblage`,`grandeur`,`cadre`,`guidon`,`freins`,`selle`,`derailleur_avant`,`derailleur_arriere`,`roue_avant`,`roue_arriere`,`reflecteurs`,`pedalier`,`ordinateur`,`panier`) VALUES ('12','Tierra Verde','Hommes','C87','G12','F9','S36','DV41','DR76','R11','R12','R10','P15',null,'S74');
INSERT INTO `veloMax`.`liste_Assemblage` (`id_liste_assemblage`,`nom_liste_assemblage`,`grandeur`,`cadre`,`guidon`,`freins`,`selle`,`derailleur_avant`,`derailleur_arriere`,`roue_avant`,`roue_arriere`,`reflecteurs`,`pedalier`,`ordinateur`,`panier`) VALUES ('13','Tierra Verde','Hommes','C87f','G12','F9','S34','DV41','DR76','R11','R12','R10','P15',null,'S73');
INSERT INTO `veloMax`.`liste_Assemblage` (`id_liste_assemblage`,`nom_liste_assemblage`,`grandeur`,`cadre`,`guidon`,`freins`,`selle`,`derailleur_avant`,`derailleur_arriere`,`roue_avant`,`roue_arriere`,`reflecteurs`,`pedalier`,`ordinateur`,`panier`) VALUES ('14','Mud Zinger I','Jeunes','C25','G7','F3','S87','DV132','DR52','R44','R47',null,'P12',null,null);
INSERT INTO `veloMax`.`liste_Assemblage` (`id_liste_assemblage`,`nom_liste_assemblage`,`grandeur`,`cadre`,`guidon`,`freins`,`selle`,`derailleur_avant`,`derailleur_arriere`,`roue_avant`,`roue_arriere`,`reflecteurs`,`pedalier`,`ordinateur`,`panier`) VALUES ('15','Mud Zinger II','Adultes','C26','G7','F3','S87','DV133','DR52','R44','R47',null,'P12',null,null);
--
-- insertion dans la table piece
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1000','C32','Cadre','2012-03-17','2024-03-17',2);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1001','G7','Guidon','2018-03-17','2029-03-17',4);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1002','F3','Frein','2020-03-17','2022-03-17',0);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1003','S88','Selle','2002-03-17','2023-03-17',4);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1004','DV133','Derailleur avant','2015-03-17','2025-03-17',4);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1005','DR56','Derailleur arriere','2012-09-17','2021-12-17',10);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1006','R45','Roue avant','2017-04-17','2026-03-17',0);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1007','R46','Roue arriere','2014-03-14','2026-03-17',11);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1008','P12','Pedalier','2006-03-07','2024-03-17',15);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1009','O2','Ordinateur','2014-03-17','2022-03-17',4);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1010','C34','Cadre','2017-03-17','2028-03-17',1);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1011','DV17','Derailleur avant','2011-03-17','2030-03-17',4);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1012','DR87','Derailleur arriere','2012-03-17','2024-03-17',8);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1013','R48','Roue avant','2014-08-17','2026-03-17',1);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1014','R47','Roue arriere','2012-05-17','2024-03-17',6);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1015','C76','Cadre','2016-11-17','2030-03-17',5);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1016','DV87','Derailleur avant','2012-12-17','2022-03-17',9);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1017','DR86','Derailleur arriere','2009-03-17','2022-03-17',1);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1018','R12','Roue avant','2007-03-17','2028-03-17',0);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1019','R32','Roue arriere','2012-01-17','2026-03-17',9);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1020','C43','Cadre','2007-01-14','2024-03-17',4);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1021','G9','Guidon','2005-03-17','2021-12-17',3);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1022','F9','Freins','2012-03-17','2026-03-17',2);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1023','S37','Selle','2010-03-17','2024-03-17',5);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1024','DV57','Derailleur avant','2002-03-17','2022-03-17',6);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1025','R19','Roue avant','2009-03-17','2024-03-17',0);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1026','R18','Roue arriere','2012-11-17','2022-03-17',0);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1027','R02','Reflecteurs','2015-07-17','2023-03-17',6);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1028','P34','Pedalier','2015-04-17','2025-03-17',9);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1029','C44f','Cadre','2012-03-17','2024-03-17',10);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1030','S35','Selle','2017-03-17','2023-03-17',5);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1031','C43','Cadre','2018-03-17','2026-03-17',50);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1032','O4','Ordinateur','2015-03-17','2028-03-17',20);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1033','C43f','Cadre','2012-04-17','2022-03-17',25);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1034','C01','Cadre','2012-08-17','2022-03-17',26);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1035','G12','Guidon','2017-03-17','2023-03-17',40);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1036','S02','Selle','2014-03-17','2023-12-17',0);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1037','R1','Roue avant','2011-03-17','2027-03-17',4);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1038','R2','Roue arriere','2002-03-17','2024-12-17',8);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1039','R09','Reflecteurs','2012-07-17','2025-07-28',65);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1040','P1','Pedalier','2017-03-17','2024-07-28',12);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1041','S01','Panier','2005-03-17','2022-07-28',5);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1042','C02','Cadre','2018-03-17','2023-07-28',9);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1043','S03','Selle','2018-07-17','2025-07-28',0);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1044','S05','Panier','2011-11-17','2026-07-28',15);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1045','C15','Cadre','2011-12-19','2025-04-28',14);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1046','S36','Selle','2005-03-17','2025-02-28',2);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1047','DV15','Derailleur avant','2007-03-17','2025-08-28',0);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1048','DR23','Derailleur arriere','2009-03-17','2025-09-28',56);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1049','R11','Roue avant','2010-03-17','2022-07-28',14);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1050','R12','Roue arriere','2013-03-17','2023-07-28',12);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1051','R10','Reflecteurs','2016-03-17','2022-07-28',10);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1052','P15','Pedalier','2009-03-17','2024-07-28',12);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1053','S74','Panier','2012-03-17','2028-07-28',13);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1054','C87','Selle','2013-03-17','2023-07-24',5);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1055','DV41','Derailleur avant','2014-03-17','2027-07-28',4);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1056','DR76','Derailleur arriere','2008-03-17','2028-07-28',3);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1057','C87f','Cadre','2006-03-17','2029-07-28',0);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1058','S34','Selle','2007-03-17','2026-07-28',2);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1059','S73','Panier','2010-03-17','2022-07-28',45);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1060','C25','Cadre','2015-03-17','2023-07-28',74);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1061','S87','Selle','2019-03-17','2028-07-28',18);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1062','DV132','Derailleur avant','2020-03-17','2029-07-28',5);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1063','DR52','Derailleur arriere','2020-11-17','2021-12-28',0);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1064','R44','Roue avant','2015-03-17','2025-07-28',56);
 INSERT INTO `veloMax`.`piece` (`id_piece`,`numero_produit_piece`,`description_piece`,`date_introduction_marche_piece`,`date_discontinuation_production_piece`,`quantite_en_stock`) VALUES ('1065','C26','Cadre','2018-07-14','2024-07-28',0);
 --
 -- insertion dans la table fournisseur 
INSERT INTO `veloMax`.`fournisseur` (`siret`,`nom_fournisseur`,`contact_fournisseur`,`rue_fournisseur`,`ville_fournisseur`,`code_postal_fournisseur`,`province_fournisseur`,`libelle`) VALUES ('15798648197548','Maxifournisseur','maxifournisseur@gmail.com','rue beaubourg','Paris',75001,'Ile-De-France', 1);
INSERT INTO `veloMax`.`fournisseur` (`siret`,`nom_fournisseur`,`contact_fournisseur`,`rue_fournisseur`,`ville_fournisseur`,`code_postal_fournisseur`,`province_fournisseur`,`libelle`) VALUES ('16854879154286','Preparateur2000','preparateur2000@gmail.com','rue dauxonne','Dijon',21000,'Bourgogne', 2);
INSERT INTO `veloMax`.`fournisseur` (`siret`,`nom_fournisseur`,`contact_fournisseur`,`rue_fournisseur`,`ville_fournisseur`,`code_postal_fournisseur`,`province_fournisseur`,`libelle`) VALUES ('87549754618725','Eureka','eureka@hotmail.com','cours lafayette','Lyon',69003,'Rhone-Alpes', 3);
INSERT INTO `veloMax`.`fournisseur` (`siret`,`nom_fournisseur`,`contact_fournisseur`,`rue_fournisseur`,`ville_fournisseur`,`code_postal_fournisseur`,`province_fournisseur`,`libelle`) VALUES ('35648794817598','Fabuloux','fabuloux@yahoo.fr','rue de strasbourg','Nantes',74000,'Pays-De-La-Loire', 4);
INSERT INTO `veloMax`.`fournisseur` (`siret`,`nom_fournisseur`,`contact_fournisseur`,`rue_fournisseur`,`ville_fournisseur`,`code_postal_fournisseur`,`province_fournisseur`,`libelle`) VALUES ('34279485682417','Venturefurniture','venturefurniture@tropien.com','rue de glasgow','Brest',29200,'Bretagne', 4);
INSERT INTO `veloMax`.`fournisseur` (`siret`,`nom_fournisseur`,`contact_fournisseur`,`rue_fournisseur`,`ville_fournisseur`,`code_postal_fournisseur`,`province_fournisseur`,`libelle`) VALUES ('29784586495826','Miniprix','miniprix@free.net','avenue des vosges','Strasbourg',67000,'Alsace', 3);
INSERT INTO `veloMax`.`fournisseur` (`siret`,`nom_fournisseur`,`contact_fournisseur`,`rue_fournisseur`,`ville_fournisseur`,`code_postal_fournisseur`,`province_fournisseur`,`libelle`) VALUES ('64572891845722','Topqualite','topqualite@rien.xyz','promenade des anglais','Nice',06000,'Rhone-Alpes', 2);
INSERT INTO `veloMax`.`fournisseur` (`siret`,`nom_fournisseur`,`contact_fournisseur`,`rue_fournisseur`,`ville_fournisseur`,`code_postal_fournisseur`,`province_fournisseur`,`libelle`) VALUES ('12435679485928','Yesfournisseur','yesfournisseur@pro.com','cours victor hugo','Bordeaux',33000,'Aquitaine', 1);
INSERT INTO `veloMax`.`fournisseur` (`siret`,`nom_fournisseur`,`contact_fournisseur`,`rue_fournisseur`,`ville_fournisseur`,`code_postal_fournisseur`,`province_fournisseur`,`libelle`) VALUES ('94875491875461','Fournitout','fournitout@france.fr','boulevard carnot','Limoges',87000,'Limousin', 4);
INSERT INTO `veloMax`.`fournisseur` (`siret`,`nom_fournisseur`,`contact_fournisseur`,`rue_fournisseur`,`ville_fournisseur`,`code_postal_fournisseur`,`province_fournisseur`,`libelle`) VALUES ('78491572831879','Myfourniture','myfourniture@hotmail.com','rue de bayard','Toulouse',31000,'Midi-Pyrenees', 2);
INSERT INTO `veloMax`.`fournisseur` (`siret`,`nom_fournisseur`,`contact_fournisseur`,`rue_fournisseur`,`ville_fournisseur`,`code_postal_fournisseur`,`province_fournisseur`,`libelle`) VALUES ('36894875861227','Gogogo','gogogo@go.go','rue fourier','Vierzon',18100,'Centre', 3);
INSERT INTO `veloMax`.`fournisseur` (`siret`,`nom_fournisseur`,`contact_fournisseur`,`rue_fournisseur`,`ville_fournisseur`,`code_postal_fournisseur`,`province_fournisseur`,`libelle`) VALUES ('95879121879457','Choixplus','choixplus@gmail.com','rue parmentier','Courbevoie',92400,'Ile-De-France', 1);
INSERT INTO `veloMax`.`fournisseur` (`siret`,`nom_fournisseur`,`contact_fournisseur`,`rue_fournisseur`,`ville_fournisseur`,`code_postal_fournisseur`,`province_fournisseur`,`libelle`) VALUES ('84975519875481','Supermag','supermag@rien.xyz','avenue de la liberation','Caen',14000,'Normandie', 2);
INSERT INTO `veloMax`.`fournisseur` (`siret`,`nom_fournisseur`,`contact_fournisseur`,`rue_fournisseur`,`ville_fournisseur`,`code_postal_fournisseur`,`province_fournisseur`,`libelle`) VALUES ('78491527589818','Genialfourni','genialfourni@genial.fr','rue bujaud','La Rochelle',17000,'Pays-De-La-Loire', 2);
INSERT INTO `veloMax`.`fournisseur` (`siret`,`nom_fournisseur`,`contact_fournisseur`,`rue_fournisseur`,`ville_fournisseur`,`code_postal_fournisseur`,`province_fournisseur`,`libelle`) VALUES ('33333549766452','Fournimax','fournimax@gmail.com','rue malpart','Lille',59800,'Nord-Pas-De-Calais', 4);
INSERT INTO `veloMax`.`fournisseur` (`siret`,`nom_fournisseur`,`contact_fournisseur`,`rue_fournisseur`,`ville_fournisseur`,`code_postal_fournisseur`,`province_fournisseur`,`libelle`) VALUES ('45612789187521','Fournidepot','fournidepot@free.net','rue des chasseurs','Hendaye',64700,'Aquitaine', 3);
--
-- insertion dans la table boutique_entreprise
INSERT INTO `veloMax`.`boutique_Entreprise` (`nom_compagnie`,`rue_entreprise`,`ville_entreprise`,`code_postal_entreprise`,`province_entreprise`,`telephone_entreprise`,`courriel_entreprise`,`nom_personne_contact`,`volume_total_achat`,`remise`) VALUES ('Decathlon','boulevard de sebastopol','Paris',75001,'Ile-De-France','0102030405','decathlon@decathlon.com','Martin',0,0.0);
INSERT INTO `veloMax`.`boutique_Entreprise` (`nom_compagnie`,`rue_entreprise`,`ville_entreprise`,`code_postal_entreprise`,`province_entreprise`,`telephone_entreprise`,`courriel_entreprise`,`nom_personne_contact`,`volume_total_achat`,`remise`) VALUES ('Gosport','rue libergier','Reims',51100,'Champagne-Ardennes','0196574895','gosport@gosport.net','Bernard',0,0.0);
INSERT INTO `veloMax`.`boutique_Entreprise` (`nom_compagnie`,`rue_entreprise`,`ville_entreprise`,`code_postal_entreprise`,`province_entreprise`,`telephone_entreprise`,`courriel_entreprise`,`nom_personne_contact`,`volume_total_achat`,`remise`) VALUES ('Sport2000','rue voltaire','Angers',49000,'Pays-De-La-Loire','0145789412','sport2000@sport2000.fr','Petit',0,0.0);
INSERT INTO `veloMax`.`boutique_Entreprise` (`nom_compagnie`,`rue_entreprise`,`ville_entreprise`,`code_postal_entreprise`,`province_entreprise`,`telephone_entreprise`,`courriel_entreprise`,`nom_personne_contact`,`volume_total_achat`,`remise`) VALUES ('Veloafond','place de la bourse','Bordeaux',33000,'Aquitaine','0125478945','veloafond@veloafond.de','Dubois',0,0.0);
INSERT INTO `veloMax`.`boutique_Entreprise` (`nom_compagnie`,`rue_entreprise`,`ville_entreprise`,`code_postal_entreprise`,`province_entreprise`,`telephone_entreprise`,`courriel_entreprise`,`nom_personne_contact`,`volume_total_achat`,`remise`) VALUES ('Provelo','rue ledru','Clermont-Ferrand',63000,'Auvergne','0196324789','provelo@provelo.co.uk','Roux',0,0.0);
INSERT INTO `veloMax`.`boutique_Entreprise` (`nom_compagnie`,`rue_entreprise`,`ville_entreprise`,`code_postal_entreprise`,`province_entreprise`,`telephone_entreprise`,`courriel_entreprise`,`nom_personne_contact`,`volume_total_achat`,`remise`) VALUES ('Sportsystem','cours bayard','Lyon',69002,'Rhone-Alpes','0169854172','sportsystem@sportsystem.es','Durand',0,0.0);
INSERT INTO `veloMax`.`boutique_Entreprise` (`nom_compagnie`,`rue_entreprise`,`ville_entreprise`,`code_postal_entreprise`,`province_entreprise`,`telephone_entreprise`,`courriel_entreprise`,`nom_personne_contact`,`volume_total_achat`,`remise`) VALUES ('Prosport','rue de la prison','Marseille',13002,'PACA','0136521112','prosport@prosport.it','Moreau',0,0.0);
INSERT INTO `veloMax`.`boutique_Entreprise` (`nom_compagnie`,`rue_entreprise`,`ville_entreprise`,`code_postal_entreprise`,`province_entreprise`,`telephone_entreprise`,`courriel_entreprise`,`nom_personne_contact`,`volume_total_achat`,`remise`) VALUES ('Discountsport','rue du sachet','Toulouse',31400,'Midi-Pyrenees','0196521479','discountsport@discountsport.xyz','Faure',0,0.0);
INSERT INTO `veloMax`.`boutique_Entreprise` (`nom_compagnie`,`rue_entreprise`,`ville_entreprise`,`code_postal_entreprise`,`province_entreprise`,`telephone_entreprise`,`courriel_entreprise`,`nom_personne_contact`,`volume_total_achat`,`remise`) VALUES ('Endurance','boulevard dupleix','Quimper',29000,'Bretagne','0164587140','endurance@endurance.pro','Rousseau',0,0.0);
INSERT INTO `veloMax`.`boutique_Entreprise` (`nom_compagnie`,`rue_entreprise`,`ville_entreprise`,`code_postal_entreprise`,`province_entreprise`,`telephone_entreprise`,`courriel_entreprise`,`nom_personne_contact`,`volume_total_achat`,`remise`) VALUES ('Adidas','rue leverrier','Caen',14000,'Normandie','0196858788','adidas@adidas.us','Fournier',0,0.0);
--
-- insertion dans la table programme_fidelio
INSERT INTO `veloMax`.`programme_fidelio` (`id_programme`,`description_programme`,`cout_programme`,`duree_programme`,`rabais_programme`) VALUES ('1001','Fidelio','15','1','5');
INSERT INTO `veloMax`.`programme_fidelio` (`id_programme`,`description_programme`,`cout_programme`,`duree_programme`,`rabais_programme`) VALUES ('1002','Fidelio or','25','2','8');
INSERT INTO `veloMax`.`programme_fidelio` (`id_programme`,`description_programme`,`cout_programme`,`duree_programme`,`rabais_programme`) VALUES ('1003','Fidelio platine','60','2','10');
INSERT INTO `veloMax`.`programme_fidelio` (`id_programme`,`description_programme`,`cout_programme`,`duree_programme`,`rabais_programme`) VALUES ('1004','Fidelio max','100','3','12');
--
-- insertion dans la table bicyclette
INSERT INTO `veloMax`.`bicyclette` (`numero_produit_bicyclette`,`nom_modele`,`grandeur_modele`,`prix_unitaire`,`ligne_produit`,`date_introduction_bicyclette`,`date_discontinuation_bicyclette`,`id_liste_assemblage`,`quantite_velo_en_stock`) VALUES ('101','Kilimandjaro','Adultes',569,'VTT','2007-03-17','2024-03-17','1',3);
INSERT INTO `veloMax`.`bicyclette` (`numero_produit_bicyclette`,`nom_modele`,`grandeur_modele`,`prix_unitaire`,`ligne_produit`,`date_introduction_bicyclette`,`date_discontinuation_bicyclette`,`id_liste_assemblage`,`quantite_velo_en_stock`) VALUES ('102','NorthPole','Adultes',329,'VTT','2011-03-17','2028-03-17','2',0);
INSERT INTO `veloMax`.`bicyclette` (`numero_produit_bicyclette`,`nom_modele`,`grandeur_modele`,`prix_unitaire`,`ligne_produit`,`date_introduction_bicyclette`,`date_discontinuation_bicyclette`,`id_liste_assemblage`,`quantite_velo_en_stock`) VALUES ('103','MontBlanc','Jeunes',399,'VTT','2015-03-17','2030-03-17','3',2);
INSERT INTO `veloMax`.`bicyclette` (`numero_produit_bicyclette`,`nom_modele`,`grandeur_modele`,`prix_unitaire`,`ligne_produit`,`date_introduction_bicyclette`,`date_discontinuation_bicyclette`,`id_liste_assemblage`,`quantite_velo_en_stock`) VALUES ('104','Hooligan','Jeunes',199,'VTT','2001-03-17','2022-03-17','4',1);
INSERT INTO `veloMax`.`bicyclette` (`numero_produit_bicyclette`,`nom_modele`,`grandeur_modele`,`prix_unitaire`,`ligne_produit`,`date_introduction_bicyclette`,`date_discontinuation_bicyclette`,`id_liste_assemblage`,`quantite_velo_en_stock`) VALUES ('105','Orléans','Hommes',229,'Vélo de course','2005-03-17','2025-03-17','5',4);
INSERT INTO `veloMax`.`bicyclette` (`numero_produit_bicyclette`,`nom_modele`,`grandeur_modele`,`prix_unitaire`,`ligne_produit`,`date_introduction_bicyclette`,`date_discontinuation_bicyclette`,`id_liste_assemblage`,`quantite_velo_en_stock`) VALUES ('106','Orléans','Dames',229,'Vélo de course','2019-03-17','2040-03-17','6',0);
INSERT INTO `veloMax`.`bicyclette` (`numero_produit_bicyclette`,`nom_modele`,`grandeur_modele`,`prix_unitaire`,`ligne_produit`,`date_introduction_bicyclette`,`date_discontinuation_bicyclette`,`id_liste_assemblage`,`quantite_velo_en_stock`) VALUES ('107','BlueJay','Hommes',349,'Vélo de course','2021-03-17','2039-03-17','7',10);
INSERT INTO `veloMax`.`bicyclette` (`numero_produit_bicyclette`,`nom_modele`,`grandeur_modele`,`prix_unitaire`,`ligne_produit`,`date_introduction_bicyclette`,`date_discontinuation_bicyclette`,`id_liste_assemblage`,`quantite_velo_en_stock`) VALUES ('108','BlueJay','Dames',349,'Vélo de course','2017-03-17','2036-03-17','8',1);
INSERT INTO `veloMax`.`bicyclette` (`numero_produit_bicyclette`,`nom_modele`,`grandeur_modele`,`prix_unitaire`,`ligne_produit`,`date_introduction_bicyclette`,`date_discontinuation_bicyclette`,`id_liste_assemblage`,`quantite_velo_en_stock`) VALUES ('109','Trail Explorer','Filles',129,'Classique','2004-03-17','2023-03-17','9',3);
INSERT INTO `veloMax`.`bicyclette` (`numero_produit_bicyclette`,`nom_modele`,`grandeur_modele`,`prix_unitaire`,`ligne_produit`,`date_introduction_bicyclette`,`date_discontinuation_bicyclette`,`id_liste_assemblage`,`quantite_velo_en_stock`) VALUES ('110','Trail Explorer','Garçons',129,'Classique','2008-03-17','2024-03-17','10',2);
INSERT INTO `veloMax`.`bicyclette` (`numero_produit_bicyclette`,`nom_modele`,`grandeur_modele`,`prix_unitaire`,`ligne_produit`,`date_introduction_bicyclette`,`date_discontinuation_bicyclette`,`id_liste_assemblage`,`quantite_velo_en_stock`) VALUES ('111','Night Hawk','Jeunes',189,'Classique','2007-03-17','2027-03-17','11',1);
INSERT INTO `veloMax`.`bicyclette` (`numero_produit_bicyclette`,`nom_modele`,`grandeur_modele`,`prix_unitaire`,`ligne_produit`,`date_introduction_bicyclette`,`date_discontinuation_bicyclette`,`id_liste_assemblage`,`quantite_velo_en_stock`) VALUES ('112','Tierra Verde','Hommes',199,'Classique','2012-03-17','2027-03-17','12',1);
INSERT INTO `veloMax`.`bicyclette` (`numero_produit_bicyclette`,`nom_modele`,`grandeur_modele`,`prix_unitaire`,`ligne_produit`,`date_introduction_bicyclette`,`date_discontinuation_bicyclette`,`id_liste_assemblage`,`quantite_velo_en_stock`) VALUES ('113','Tierra Verde','Dames',199,'Classique','2011-03-17','2023-03-17','13',0);
INSERT INTO `veloMax`.`bicyclette` (`numero_produit_bicyclette`,`nom_modele`,`grandeur_modele`,`prix_unitaire`,`ligne_produit`,`date_introduction_bicyclette`,`date_discontinuation_bicyclette`,`id_liste_assemblage`,`quantite_velo_en_stock`) VALUES ('114','Mud Zinger I','Jeunes',279,'BMX','2007-03-17','2029-03-17','14',3);
INSERT INTO `veloMax`.`bicyclette` (`numero_produit_bicyclette`,`nom_modele`,`grandeur_modele`,`prix_unitaire`,`ligne_produit`,`date_introduction_bicyclette`,`date_discontinuation_bicyclette`,`id_liste_assemblage`,`quantite_velo_en_stock`) VALUES ('115','Mud Zinger II','Adultes',359,'BMX','2000-03-17','2022-03-17','15',4);
--
-- insertion dans la table approvisionnement
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1000','45612789187521',14.99,3,'FT2763',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1001','33333549766452',12.99,4,'FX5233',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1002','15798648197548',19.99,7,'MR5366',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1002','45612789187521',18.50,6,'MRHS66',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1002','84975519875481',20.99,7,'MHSHS6',3);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1003','16854879154286',14.99,8,'P03457',4);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1004','78491527589818',17.99,4,'GI1953',10);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1005','87549754618725',18.99,6,'EA2840',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1006','84975519875481',16.99,3,'SG6812',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1007','95879121879457',14.99,7,'CS0935',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1008','12435679485928',19.99,5,'YR5387',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1009','29784586495826',13.99,5,'MX6527',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1010','35648794817598',12.99,6,'FX2345',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1011','29784586495826',11.99,4,'MX8729',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1012','29784586495826',10.99,7,'MX5723',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1013','84975519875481',19.99,8,'SG1542',3);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1014','15798648197548',18.99,1,'MR4879',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1015','45612789187521',17.99,2,'FT0235',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1016','33333549766452',16.99,5,'FX4897',3);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1017','16854879154286',15.99,6,'P04589',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1018','78491527589818',14.99,7,'GI4578',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1019','87549754618725',13.99,8,'EA1545',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1020','95879121879457',12.99,4,'CS4578',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1021','12435679485928',11.99,4,'YR4592',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1022','36894875861227',10.99,8,'GO1975',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1023','29784586495826',9.99,2,'MX1902',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1024','45612789187521',8.99,2,'FT4915',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1025','45612789187521',7.99,5,'FT7315',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1026','45612789187521',14.99,6,'FT1842',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1027','36894875861227',15.99,7,'GO0831',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1028','35648794817598',17.99,8,'FX4109',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1029','16854879154286',19.99,9,'P01492',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1030','45612789187521',21.99,1,'FT7201',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1031','33333549766452',23.99,3,'FX4510',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1032','15798648197548',25.99,5,'MR6510',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1033','78491527589818',27.99,7,'GI8610',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1034','87549754618725',29.99,9,'EA5610',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1035','84975519875481',15.99,10,'SG6103',4);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1036','95879121879457',16.99,12,'CS5610',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1037','64572891845722',17.99,2,'TE6781',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1038','64572891845722',18.99,3,'TE9015',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1039','12435679485928',5.99,8,'YR5610',3);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1040','36894875861227',6.99,6,'GO5103',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1041','36894875861227',7.99,5,'GO9103',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1042','12435679485928',8.99,4,'YR7107',5);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1043','35648794817598',9.99,7,'FX4610',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1044','15798648197548',14.99,8,'MR5710',9);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1045','45612789187521',13.99,9,'FT4178',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1046','33333549766452',12.99,4,'FX5132',3);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1047','16854879154286',11.99,8,'P04519',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1048','78491527589818',19.99,5,'GI1673',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1049','87549754618725',20.99,5,'EA4103',5);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1050','84975519875481',30.99,9,'SG0172',3);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1051','95879121879457',40.99,4,'CS0951',4);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1052','29784586495826',50.99,7,'MX6810',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1053','12435679485928',31.99,5,'YR1293',3);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1054','29784586495826',32.99,6,'MX7810',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1055','64572891845722',33.99,7,'TE7610',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1056','64572891845722',34.99,1,'TE4517',6);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1057','34279485682417',35.99,1,'VE4519',7);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1058','84975519875481',36.99,2,'SG4519',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1059','35648794817598',37.99,6,'FX5566',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1060','16854879154286',38.99,7,'P05511',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1061','45612789187521',25.99,5,'FT1108',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1062','33333549766452',24.99,4,'FX5510',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1063','15798648197548',23.99,2,'MR5188',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1064','78491527589818',22.99,3,'GI9910',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1065','87549754618725',21.99,7,'EA4177',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1064','87549754618725',24.99,10,'AG1273',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1065','45612789187521',21.99,7,'DS7299',9);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1057','87549754618725',21.99,7,'GE5328',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1065','16854879154286',20.99,5,'KS2810',3);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1030','87549754618725',19.99,6,'SD1930',1);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1007','33333549766452',16.99,4,'ID8222',2);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1020','84975519875481',8.99,10,'HJ2719',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1049','15798648197548',21.99,7,'SK2628',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1065','84975519875481',19.99,8,'TD2626',0);
INSERT INTO `veloMax`.`approvisionnement` (`id_piece`,`siret`,`prix_unitaire_piece`,`delai_approvisionnement_piece`,`numero_produit_catalogue_fournisseur`,`quantite_appro`) VALUES ('1065','34279485682417',23.99,5,'TB6518',0);
--
-- insertion dans la table client_particulier
INSERT INTO `veloMax`.`client_particulier` (`id_client`,`nom_client`,`prenom_client`,`courriel_client`,`telephone_client`,`rue_client`,`ville_client`,`code_postal_client`,`province_client`,`date_adhesion`,`id_programme`) VALUES ('1A','Mbappe','Kylian','mbappe@gmail.com','0645564558','Avenue Charles de gaulle','Neuilly-sur-Seine',92200,'Ile-De-France','2021-03-12','1001');
INSERT INTO `veloMax`.`client_particulier` (`id_client`,`nom_client`,`prenom_client`,`courriel_client`,`telephone_client`,`rue_client`,`ville_client`,`code_postal_client`,`province_client`,`date_adhesion`,`id_programme`) VALUES ('2A','Federer','Roger','federer@gmail.com','0678954556','Avenue Victor Hugo','Paris',75016,'Ile-De-France',null,null);
INSERT INTO `veloMax`.`client_particulier` (`id_client`,`nom_client`,`prenom_client`,`courriel_client`,`telephone_client`,`rue_client`,`ville_client`,`code_postal_client`,`province_client`,`date_adhesion`,`id_programme`) VALUES ('3A','Nadal','Rafael','nadal@sfr.fr','0145562123','Quai Charles de gaulle','Lyon',69006,'Rhone-Alpes','2020-12-04','1002');
INSERT INTO `veloMax`.`client_particulier` (`id_client`,`nom_client`,`prenom_client`,`courriel_client`,`telephone_client`,`rue_client`,`ville_client`,`code_postal_client`,`province_client`,`date_adhesion`,`id_programme`) VALUES ('4A','Jackson','Michael','jackson@outlook.fr','0621233221','Boulevard Jean Jaurès','Boulogne Billancourt',92100,'Ile-De-France','2019-05-22','1003');
INSERT INTO `veloMax`.`client_particulier` (`id_client`,`nom_client`,`prenom_client`,`courriel_client`,`telephone_client`,`rue_client`,`ville_client`,`code_postal_client`,`province_client`,`date_adhesion`,`id_programme`) VALUES ('5A','Dupond','Leon','dupond@gmail.com','0121312185','Avenue Jean Jaurès','Neuilly-sur-Marne',93330,'Ile-De-France','2020-03-30','1004');
INSERT INTO `veloMax`.`client_particulier` (`id_client`,`nom_client`,`prenom_client`,`courriel_client`,`telephone_client`,`rue_client`,`ville_client`,`code_postal_client`,`province_client`,`date_adhesion`,`id_programme`) VALUES ('6A','Lewandowski','Robert','leandowski@outlook.fr','0645587889','Léon gambetta','Montrouge',92120,'Ile-De-France','2021-06-12','1002');
INSERT INTO `veloMax`.`client_particulier` (`id_client`,`nom_client`,`prenom_client`,`courriel_client`,`telephone_client`,`rue_client`,`ville_client`,`code_postal_client`,`province_client`,`date_adhesion`,`id_programme`) VALUES ('7A','Monfils','Gael','monfils@free.fr','0741236545','Avenue Georges Clemenceau','Rueil-Malmaison',92500,'Ile-De-France','2020-12-13','1003');
INSERT INTO `veloMax`.`client_particulier` (`id_client`,`nom_client`,`prenom_client`,`courriel_client`,`telephone_client`,`rue_client`,`ville_client`,`code_postal_client`,`province_client`,`date_adhesion`,`id_programme`) VALUES ('8A','Denizot','Roland','denizot@gmail.com','0789125654','Avenue des Champs-Élysées','Paris',75008,'Ile-De-France','2020-01-07','1001');
INSERT INTO `veloMax`.`client_particulier` (`id_client`,`nom_client`,`prenom_client`,`courriel_client`,`telephone_client`,`rue_client`,`ville_client`,`code_postal_client`,`province_client`,`date_adhesion`,`id_programme`) VALUES ('9A','Lambert','Rafael','lambert@sfr.fr','0778122545','Avenue du prado','Marseille',13006,'PACA','2019-08-25','1004');
INSERT INTO `veloMax`.`client_particulier` (`id_client`,`nom_client`,`prenom_client`,`courriel_client`,`telephone_client`,`rue_client`,`ville_client`,`code_postal_client`,`province_client`,`date_adhesion`,`id_programme`) VALUES ('10A','Lesur','Aurelien','lesur@gmail.com','0699442354','Rue Yves Collet','Brest',29200,'Bretagne','2020-05-04','1001');
INSERT INTO `veloMax`.`client_particulier` (`id_client`,`nom_client`,`prenom_client`,`courriel_client`,`telephone_client`,`rue_client`,`ville_client`,`code_postal_client`,`province_client`,`date_adhesion`,`id_programme`) VALUES ('11A','Dennery','Maxime','dennery@outlook.fr','0689452321','Rue Tupin','Lyon',69002,'Rhone-Alpes','2021-01-01','1001');
INSERT INTO `veloMax`.`client_particulier` (`id_client`,`nom_client`,`prenom_client`,`courriel_client`,`telephone_client`,`rue_client`,`ville_client`,`code_postal_client`,`province_client`,`date_adhesion`,`id_programme`) VALUES ('12A','Santos','Neymar','santos@free.fr','0154568987','Cours Sablon','Clermont-Ferrand',63000,'Auvergne','2020-09-10','1002');
INSERT INTO `veloMax`.`client_particulier` (`id_client`,`nom_client`,`prenom_client`,`courriel_client`,`telephone_client`,`rue_client`,`ville_client`,`code_postal_client`,`province_client`,`date_adhesion`,`id_programme`) VALUES ('13A','Thiem','Dominic','thiem@sfr.fr','0689744552','Rue Pasteur','Caen',14000,'Normandie','2020-07-14','1004');
INSERT INTO `veloMax`.`client_particulier` (`id_client`,`nom_client`,`prenom_client`,`courriel_client`,`telephone_client`,`rue_client`,`ville_client`,`code_postal_client`,`province_client`,`date_adhesion`,`id_programme`) VALUES ('14A','Gomez','Selena','gomez@gmail.com','0756124778','Rue Labirat','Bordeaux',33000,'Aquitaine','2021-01-27','1003');
INSERT INTO `veloMax`.`client_particulier` (`id_client`,`nom_client`,`prenom_client`,`courriel_client`,`telephone_client`,`rue_client`,`ville_client`,`code_postal_client`,`province_client`,`date_adhesion`,`id_programme`) VALUES ('15A','Leroi','Adrien','leroi@outlook.fr','0621237889','Rue de Nomeny','Strasbourg',67100,'Alsace','2020-03-20','1003');
--
-- insertion dans la table commande
INSERT INTO `veloMax`.`commande` (`numero_commande`,`date_commande`,`rue_comm`,`ville_comm`,`code_postal_com`,`province_com`,`date_livraison`,`nom_compagnie`,`id_client`) VALUES ('ADS55','2021-03-17','Avenue Victor Hugo','Paris',75016,'Ile-De-France','2021-08-14',null,'2A');
INSERT INTO `veloMax`.`commande` (`numero_commande`,`date_commande`,`rue_comm`,`ville_comm`,`code_postal_com`,`province_com`,`date_livraison`,`nom_compagnie`,`id_client`) VALUES ('S5DD8','2021-01-17','Rue Yves Collet','Brest',29200,'Bretagne','2021-05-07',null,'10A');
INSERT INTO `veloMax`.`commande` (`numero_commande`,`date_commande`,`rue_comm`,`ville_comm`,`code_postal_com`,`province_com`,`date_livraison`,`nom_compagnie`,`id_client`) VALUES ('QS45F','2020-12-17','boulevard de sebastopol','Paris',75001,'Ile-De-France','2021-06-12','Decathlon',null);
INSERT INTO `veloMax`.`commande` (`numero_commande`,`date_commande`,`rue_comm`,`ville_comm`,`code_postal_com`,`province_com`,`date_livraison`,`nom_compagnie`,`id_client`) VALUES ('ER71F','2021-02-17','rue voltaire','Angers',49000,'Pays-De-La-Loire','2021-07-11','Sport2000',null);
INSERT INTO `veloMax`.`commande` (`numero_commande`,`date_commande`,`rue_comm`,`ville_comm`,`code_postal_com`,`province_com`,`date_livraison`,`nom_compagnie`,`id_client`) VALUES ('4SDF5','2021-02-27','Avenue Victor Hugo','Paris',75016,'Ile-De-France','2021-09-17',null,'2A');
INSERT INTO `veloMax`.`commande` (`numero_commande`,`date_commande`,`rue_comm`,`ville_comm`,`code_postal_com`,`province_com`,`date_livraison`,`nom_compagnie`,`id_client`) VALUES ('AZ8F9','2021-04-01','Cours Sablon','Clermont-Ferrand',63000,'Auvergne','2021-12-25',null,'12A');
INSERT INTO `veloMax`.`commande` (`numero_commande`,`date_commande`,`rue_comm`,`ville_comm`,`code_postal_com`,`province_com`,`date_livraison`,`nom_compagnie`,`id_client`) VALUES ('ER41F','2021-03-17','Avenue des Champs-Élysées','Paris',75008,'Ile-De-France','2022-02-17',null,'8A');
INSERT INTO `veloMax`.`commande` (`numero_commande`,`date_commande`,`rue_comm`,`ville_comm`,`code_postal_com`,`province_com`,`date_livraison`,`nom_compagnie`,`id_client`) VALUES ('ERT8F','2020-11-17','place de la bourse','Bordeaux',33000,'Aquitaine','2022-03-06','Veloafond',null);
INSERT INTO `veloMax`.`commande` (`numero_commande`,`date_commande`,`rue_comm`,`ville_comm`,`code_postal_com`,`province_com`,`date_livraison`,`nom_compagnie`,`id_client`) VALUES ('HQ41D','2021-03-07','rue leverrier','Caen',14000,'Normandie','2021-06-28','Adidas',null);
INSERT INTO `veloMax`.`commande` (`numero_commande`,`date_commande`,`rue_comm`,`ville_comm`,`code_postal_com`,`province_com`,`date_livraison`,`nom_compagnie`,`id_client`) VALUES ('AZ1D4','2020-12-22','rue libergier','Reims',51100,'Champagne-Ardennes','2021-09-22','Gosport',null);
INSERT INTO `veloMax`.`commande` (`numero_commande`,`date_commande`,`rue_comm`,`ville_comm`,`code_postal_com`,`province_com`,`date_livraison`,`nom_compagnie`,`id_client`) VALUES ('AZ85F','2021-03-04','Quai Charles de gaulle','Lyon',69006,'Rhone-Alpes','2021-05-26',null,'3A');
INSERT INTO `veloMax`.`commande` (`numero_commande`,`date_commande`,`rue_comm`,`ville_comm`,`code_postal_com`,`province_com`,`date_livraison`,`nom_compagnie`,`id_client`) VALUES ('AE45D','2020-09-17','rue voltaire','Angers',49000,'Pays-De-La-Loire','2021-10-16','Sport2000',null);
INSERT INTO `veloMax`.`commande` (`numero_commande`,`date_commande`,`rue_comm`,`ville_comm`,`code_postal_com`,`province_com`,`date_livraison`,`nom_compagnie`,`id_client`) VALUES ('FJF45','2021-03-09','Rue Labirat','Bordeaux',33000,'Aquitaine','2021-07-13',null,'14A');
INSERT INTO `veloMax`.`commande` (`numero_commande`,`date_commande`,`rue_comm`,`ville_comm`,`code_postal_com`,`province_com`,`date_livraison`,`nom_compagnie`,`id_client`) VALUES ('AZ51D','2021-01-12','Léon gambetta','Montrouge',92120,'Ile-De-France','2021-09-15',null,'6A');
INSERT INTO `veloMax`.`commande` (`numero_commande`,`date_commande`,`rue_comm`,`ville_comm`,`code_postal_com`,`province_com`,`date_livraison`,`nom_compagnie`,`id_client`) VALUES ('RGG45','2021-01-15','boulevard de sebastopol','Paris',75001,'Ile-De-France','2022-02-14','Decathlon',null);
--
-- insertion dans la table commande_velo
INSERT INTO `veloMax`.`commande_velo` (`numero_produit_bicyclette`,`numero_commande`,`quantite_velo`) VALUES ('101','ADS55',1);
INSERT INTO `veloMax`.`commande_velo` (`numero_produit_bicyclette`,`numero_commande`,`quantite_velo`) VALUES ('110','ADS55',2);
INSERT INTO `veloMax`.`commande_velo` (`numero_produit_bicyclette`,`numero_commande`,`quantite_velo`) VALUES ('115','S5DD8',1);
INSERT INTO `veloMax`.`commande_velo` (`numero_produit_bicyclette`,`numero_commande`,`quantite_velo`) VALUES ('115','QS45F',1);
INSERT INTO `veloMax`.`commande_velo` (`numero_produit_bicyclette`,`numero_commande`,`quantite_velo`) VALUES ('114','ER71F',5);
INSERT INTO `veloMax`.`commande_velo` (`numero_produit_bicyclette`,`numero_commande`,`quantite_velo`) VALUES ('112','ER71F',3);
INSERT INTO `veloMax`.`commande_velo` (`numero_produit_bicyclette`,`numero_commande`,`quantite_velo`) VALUES ('105','ER71F',2);
INSERT INTO `veloMax`.`commande_velo` (`numero_produit_bicyclette`,`numero_commande`,`quantite_velo`) VALUES ('103','4SDF5',1);
INSERT INTO `veloMax`.`commande_velo` (`numero_produit_bicyclette`,`numero_commande`,`quantite_velo`) VALUES ('106','AZ8F9',1);
INSERT INTO `veloMax`.`commande_velo` (`numero_produit_bicyclette`,`numero_commande`,`quantite_velo`) VALUES ('106','ER41F',1);
INSERT INTO `veloMax`.`commande_velo` (`numero_produit_bicyclette`,`numero_commande`,`quantite_velo`) VALUES ('108','ERT8F',2);
INSERT INTO `veloMax`.`commande_velo` (`numero_produit_bicyclette`,`numero_commande`,`quantite_velo`) VALUES ('101','HQ41D',4);
INSERT INTO `veloMax`.`commande_velo` (`numero_produit_bicyclette`,`numero_commande`,`quantite_velo`) VALUES ('103','AZ1D4',3);
INSERT INTO `veloMax`.`commande_velo` (`numero_produit_bicyclette`,`numero_commande`,`quantite_velo`) VALUES ('106','AZ85F',2);
INSERT INTO `veloMax`.`commande_velo` (`numero_produit_bicyclette`,`numero_commande`,`quantite_velo`) VALUES ('109','AZ85F',3);
--
-- insertion dans la table commande_piece
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1025','AE45D','2');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1043','FJF45','2');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1043','AE45D','2');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1014','ADS55','2');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1023','ER71F','1');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1026','ER71F','12');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1049','AZ85F','6');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1054','ER41F','4');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1025','AZ85F','1');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1034','AZ85F','3');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1007','ER71F','2');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1031','AE45D','1');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1000','AE45D','3');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1034','FJF45','5');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1056','AE45D','6');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1056','AZ51D','11');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1028','FJF45','3');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1045','RGG45','6');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1065','RGG45','6');
INSERT INTO `veloMax`.`commande_piece` (`id_piece2`,`numero_commande2`,`quantite_piece`) VALUES ('1000','AZ1D4','6');
--
-- insertion dans la table constitution
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('1','C32');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('1','G7');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('1','F3');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('1','S88');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('1','DV133');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('1','DR56');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('1','R45');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('1','R46');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('1','P12');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('1','O2');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('2','C34');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('2','G7');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('2','F3');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('2','S88');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('2','DV17');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('2','DR87');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('2','R48');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('2','R47');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('2','P12');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('3','C76');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('3','G7');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('3','F3');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('3','S88');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('3','DV17');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('3','DR87');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('3','R48');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('3','R47');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('3','P12');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('3','O2');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('4','C76');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('4','G7');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('4','F3');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('4','S88');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('4','DV87');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('4','DR86');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('4','R12');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('4','R32');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('4','P12');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('5','C43');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('5','G9');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('5','F9');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('5','S37');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('5','DV57');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('5','DR86');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('5','R19');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('5','R18');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('5','R02');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('5','P34');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('6','C44f');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('6','G9');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('6','F9');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('6','S35');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('6','DV57');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('6','DR86');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('6','R19');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('6','R18');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('6','R02');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('6','P34');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('7','C43');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('7','G9');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('7','F9');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('7','S37');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('7','DV57');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('7','DR87');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('7','R19');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('7','R18');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('7','R02');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('7','P34');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('7','04');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('8','C43f');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('8','G9');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('8','F9');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('8','S35');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('8','DV57');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('8','DR87');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('8','R19');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('8','R18');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('8','R02');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('8','P34');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('8','04');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('9','C01');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('9','G12');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('9','S02');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('9','R1');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('9','R2');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('9','R09');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('9','P1');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('9','S01');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('10','C02');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('10','G12');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('10','S03');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('10','R1');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('10','R2');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('10','R09');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('10','P1');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('10','S05');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('11','C15');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('11','G12');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('11','F9');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('11','S36');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('11','DV15');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('11','DR23');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('11','R11');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('11','R12');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('11','R10');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('11','P15');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('11','S74');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('12','C87');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('12','G12');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('12','F9');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('12','S36');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('12','DV41');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('12','DR76');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('12','R11');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('12','R12');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('12','R10');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('12','P15');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('12','S74');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('13','C87f');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('13','G12');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('13','F9');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('13','S34');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('13','DV41');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('13','DR76');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('13','R11');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('13','R12');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('13','R10');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('13','P15');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('13','S73');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('14','C25');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('14','G7');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('14','F3');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('14','S87');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('14','DV132');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('14','DR52');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('14','R44');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('14','R47');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('14','P12');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('15','C26');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('15','G7');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('15','F3');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('15','S87');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('15','DV133');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('15','DR52');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('15','R44');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('15','R47');
INSERT INTO `veloMax`.`constitution` (`id_liste_assemblage2`,`id_piece3`) VALUES ('15','P12');