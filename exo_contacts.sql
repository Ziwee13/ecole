-- Create database and tables
CREATE DATABASE IF NOT EXISTS `exo_contacts` CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
USE `exo_contacts`;

  COLLATE = utf8mb4_unicode_ci;

USE `exo_contacts`;

CREATE TABLE IF NOT EXISTS `pays` (
  `iso_3` CHAR(3) NOT NULL,
  `nom` VARCHAR(200) NOT NULL,
  `iso_2` CHAR(2) NOT NULL,
  `nationalite` VARCHAR(200) DEFAULT NULL,
  PRIMARY KEY (`iso_3`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `contacts` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(100) NOT NULL,
  `prenom` VARCHAR(100) NOT NULL,
  `date_de_naissance` DATE DEFAULT NULL,
  `sexe` ENUM('M','F','O') DEFAULT 'O',
  `adresse` VARCHAR(255) DEFAULT NULL,
  `cp` VARCHAR(20) DEFAULT NULL,
  `ville` VARCHAR(100) DEFAULT NULL,
  `pays_iso_3` CHAR(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_contacts_pays` FOREIGN KEY (`pays_iso_3`) REFERENCES `pays`(`iso_3`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `telephone` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_contact` BIGINT UNSIGNED NOT NULL,
  `numero` VARCHAR(30) NOT NULL,
  `type` VARCHAR(30) DEFAULT 'mobile',
  PRIMARY KEY (`id`),
  INDEX `idx_tel_contact` (`id_contact`),
  CONSTRAINT `fk_telephone_contact` FOREIGN KEY (`id_contact`) REFERENCES `contacts`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `contacts` ADD INDEX `idx_contacts_pays` (`pays_iso_3`);
ALTER TABLE `contacts` ADD INDEX `idx_contacts_nom` (`nom`);


-- Peuplement des tables (au moins 10 enregistrements par table)

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE `telephone`;
TRUNCATE TABLE `contacts`;
TRUNCATE TABLE `pays`;
SET FOREIGN_KEY_CHECKS = 1;


START TRANSACTION;
INSERT INTO `pays` (`iso_3`,`nom`,`iso_2`,`nationalite`) VALUES
('FRA','France','FR','Française'),
('USA','United States','US','American'),
('ESP','Espagne','ES','Espagnole'),
('ITA','Italie','IT','Italienne'),
('DEU','Allemagne','DE','Allemande'),
('GBR','Royaume-Uni','GB','Britannique'),
('PRT','Portugal','PT','Portugaise'),
('BEL','Belgique','BE','Belge'),
('CHE','Suisse','CH','Suisse'),
('CAN','Canada','CA','Canadienne');


INSERT INTO `contacts` (`nom`,`prenom`,`date_de_naissance`,`sexe`,`adresse`,`cp`,`ville`,`pays_iso_3`) VALUES
('VARLET','Evan','2006-12-04','M','12 rue des Acacias','13110','Port-de-Bouc','FRA'),
('DUPONT','Marie','1998-05-20','F','4 avenue Victor Hugo','75016','Paris','FRA'),
('SMITH','John','1992-08-15','M','22 5th Ave','10001','New York','USA'),
('GARCIA','Ana','1995-11-02','F','Calle Mayor 3','28013','Madrid','ESP'),
('ROSSI','Luca','1990-03-12','M','Via Roma 10','00100','Rome','ITA'),
('MULLER','Anna','1988-07-07','F','Hauptstrasse 5','10115','Berlin','DEU'),
('BROWN','Oliver','1994-09-30','M','10 Downing St','SW1A','London','GBR'),
('SILVA','Rui','1996-02-18','M','Rua das Flores 8','1100','Lisbon','PRT'),
('DUPUIS','Luc','1985-04-22','M','Rue de la Loi 1','1000','Bruxelles','BEL'),
('LAVOIE','Sophie','1993-06-10','F','123 Maple St','H2X1Y4','Montreal','CAN');


INSERT INTO `telephone` (`id_contact`,`numero`,`type`) VALUES
(1,'+33 6 35 39 99 94','mobile'),
(1,'+33 4 90 00 11 22','fixe'),
(2,'+33 6 11 22 33 44','mobile'),
(3,'+1 212 555 0187','mobile'),
(4,'+34 91 555 0101','fixe'),
(5,'+39 06 5555 010','mobile'),
(6,'+49 30 5555 010','fixe'),
(7,'+44 20 7946 0000','fixe'),
(8,'+351 21 555 0101','mobile'),
(9,'+32 2 555 0101','fixe'),
(10,'+1 514 555 0199','mobile'),
(3,'+1 646 555 0133','travail');


COMMIT;

-- Vérification rapide :
-- SELECT COUNT(*) FROM pays;       -- doit renvoyer 10
-- SELECT COUNT(*) FROM contacts;   -- doit renvoyer 10
-- SELECT COUNT(*) FROM telephone;  -- doit renvoyer >= 10

-- Fin du script
