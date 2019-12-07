-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Schema lifeexpdw
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lifeexpdw` DEFAULT CHARACTER SET utf16 ;
USE `lifeexpdw` ;

-- -----------------------------------------------------
-- Table `lifeexpdw`.`dim_year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lifeexpdw`.`dim_year` (
  `year` INT(10) NOT NULL,
  PRIMARY KEY (`year`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf16;


-- -----------------------------------------------------
-- Table `lifeexpdw`.`dim_state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lifeexpdw`.`dim_state` (
  `stateid` INT(2) NOT NULL COMMENT 'State ID (FIPS Code)',
  `state_abbrv` VARCHAR(2) NOT NULL COMMENT 'State Abbreviation',
  `statename` VARCHAR(20) NOT NULL COMMENT 'State Name: 01	Alabama, 02	Alaska, 04	Arizona, 05	Arkansas, 06	California, 08	Colorado, 09	Connecticut, 10	Delaware, 11	District of Columbia, 12	Florida, 13	Georgia, 15	Hawaii, 16	Idaho, 17	Illinois, 18	Indiana, 19	Iowa, 20	Kansas, 21	Kentucky, 22	Louisiana, 23	Maine, 24	Maryland, 25	Massachusetts, 26	Michigan, 27	Minnesota, 28	Mississippi, 29	Missouri, 30	Montana, 31	Nebraska, 32	Nevada, 33	New Hampshire, 34	New Jersey, 35	New Mexico, 36	New York, 37	North Carolina, 38	North Dakota, 39	Ohio, 40	Oklahoma, 41	Oregon, 42	Pennsylvania, 44	Rhode Island, 45	South Carolina, 46	South Dakota, 47	Tennessee, 48	Texas, 49	Utah, 50	Vermont, 51	Virginia, 53	Washington, 54	West Virginia, 55	Wisconsin, 56	Wyoming',
  `population` INT(9) NULL DEFAULT NULL COMMENT 'State Population',
  `hospitals` INT(4) NULL DEFAULT NULL COMMENT 'Total hospitals by state',
  `expenditure` BIGINT(30) NULL DEFAULT NULL COMMENT 'Total expenditure by state',
  `state_lifeexp` DECIMAL(5,2) NULL DEFAULT NULL COMMENT 'State specific life expectancy',
  `uninsuredrate` DECIMAL(5,2) NULL DEFAULT NULL COMMENT 'Uninsured rate by state',
  `year` INT(10) NOT NULL,
  `expend_per_cap` DECIMAL(10,2) NULL DEFAULT NULL COMMENT 'Expenditure per capita',
  `hospitals_per_100K` DECIMAL(5,2) NULL DEFAULT NULL COMMENT 'Number of hopsital per 100,000 residents',
  PRIMARY KEY (`stateid`, `year`),
  INDEX `fk_dim_state_dim_year1_idx` (`year` ASC),
  CONSTRAINT `fk_dim_state_dim_year1`
    FOREIGN KEY (`year`)
    REFERENCES `lifeexpdw`.`dim_year` (`year`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lifeexpdw`.`dim_gender`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lifeexpdw`.`dim_gender` (
  `genderid` INT(2) NOT NULL COMMENT 'Gender ID (1 or 2)',
  `gendername` VARCHAR(10) NOT NULL COMMENT 'Gender Name (Male or Female)',
  `gender_lifeexp` DECIMAL(5,2) NULL COMMENT 'Gender specific life expectancy',
  `mortality` DECIMAL(5,2) NULL DEFAULT NULL COMMENT 'Mortality risk',
  `year` INT(10) NOT NULL,
  `stateid` INT(2) NOT NULL,
  PRIMARY KEY (`genderid`, `year`, `stateid`),
  INDEX `fk_dim_gender_dim_year1_idx` (`year` ASC),
  INDEX `fk_dim_gender_dim_state1_idx` (`stateid` ASC),
  CONSTRAINT `fk_dim_gender_dim_state1`
    FOREIGN KEY (`stateid`)
    REFERENCES `lifeexpdw`.`dim_state` (`stateid`),
  CONSTRAINT `fk_dim_gender_dim_year1`
    FOREIGN KEY (`year`)
    REFERENCES `lifeexpdw`.`dim_year` (`year`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lifeexpdw`.`dim_income`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lifeexpdw`.`dim_income` (
  `incomeid` INT(2) NOT NULL COMMENT 'Income Bracket ID',
  `incomebracket` VARCHAR(20) NOT NULL COMMENT 'Income bracket: 1 = 1to25000, 2 = 25001to50000, 3 = 50001to75000, 4 = 75001andmore',
  `income_lifeexp` DECIMAL(5,2) NULL DEFAULT NULL COMMENT 'Income bracket specific life expectancy',
  `percentagepopulation` DECIMAL(5,2) NULL DEFAULT NULL COMMENT 'Population percentage for each income bracket',
  `year` INT(10) NOT NULL,
  `stateid` INT(2) NOT NULL,
  PRIMARY KEY (`incomeid`, `year`, `stateid`),
  INDEX `fk_dim_income_dim_year1_idx` (`year` ASC),
  INDEX `fk_dim_income_dim_state1_idx` (`stateid` ASC),
  CONSTRAINT `fk_dim_income_dim_state1`
    FOREIGN KEY (`stateid`)
    REFERENCES `lifeexpdw`.`dim_state` (`stateid`),
  CONSTRAINT `fk_dim_income_dim_year1`
    FOREIGN KEY (`year`)
    REFERENCES `lifeexpdw`.`dim_year` (`year`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lifeexpdw`.`dim_race`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lifeexpdw`.`dim_race` (
  `raceid` INT(2) NOT NULL COMMENT 'Race id (1 through 4)',
  `racename` VARCHAR(10) NOT NULL COMMENT 'Race name: 1 = White, 2 = Black, 3 = Hispanic, 4 = Asian',
  `race_lifeexp` DECIMAL(5,2) NULL DEFAULT NULL COMMENT 'Race specific life expectancy',
  `year` INT(10) NOT NULL,
  `genderid` INT(2) NOT NULL,
  PRIMARY KEY (`raceid`, `year`, `genderid`),
  INDEX `fk_dim_race_dim_year1_idx` (`year` ASC),
  INDEX `fk_dim_race_dim_gender1_idx` (`genderid` ASC),
  CONSTRAINT `fk_dim_race_dim_gender1`
    FOREIGN KEY (`genderid`)
    REFERENCES `lifeexpdw`.`dim_gender` (`genderid`),
  CONSTRAINT `fk_dim_race_dim_year1`
    FOREIGN KEY (`year`)
    REFERENCES `lifeexpdw`.`dim_year` (`year`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lifeexpdw`.`fact_personlifeexp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lifeexpdw`.`fact_personlifeexp` (
  `personid` INT(10) NOT NULL AUTO_INCREMENT,
  `genderid` INT(2) NOT NULL,
  `raceid` INT(2) NOT NULL,
  `stateid` INT(2) NOT NULL,
  `incomeid` INT(2) NOT NULL,
  `uninsuredrate` INT(1) NULL DEFAULT NULL,
  `person_lifeexp` FLOAT NULL DEFAULT NULL,
  `year` INT(10) NOT NULL,
  PRIMARY KEY (`personid`),
  INDEX `fk_personlifeexp_dim_gender_idx` (`genderid` ASC),
  INDEX `fk_personlifeexp_dim_race_idx` (`raceid` ASC),
  INDEX `fk_personlifeexp_dim_state_idx` (`stateid` ASC),
  INDEX `fk_personlifeexp_dim_income_idx` (`incomeid` ASC),
  INDEX `fk_personlifeexp_dim_year_idx` (`year` ASC),
  CONSTRAINT `fk_personlifeexp_dim_gender_idx`
    FOREIGN KEY (`genderid`)
    REFERENCES `lifeexpdw`.`dim_gender` (`genderid`),
  CONSTRAINT `fk_personlifeexp_dim_income_idx`
    FOREIGN KEY (`incomeid`)
    REFERENCES `lifeexpdw`.`dim_income` (`incomeid`),
  CONSTRAINT `fk_personlifeexp_dim_race_idx`
    FOREIGN KEY (`raceid`)
    REFERENCES `lifeexpdw`.`dim_race` (`raceid`),
  CONSTRAINT `fk_personlifeexp_dim_state_idx`
    FOREIGN KEY (`stateid`)
    REFERENCES `lifeexpdw`.`dim_state` (`stateid`),
  CONSTRAINT `fk_personlifeexp_dim_year_idx`
    FOREIGN KEY (`year`)
    REFERENCES `lifeexpdw`.`dim_year` (`year`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
