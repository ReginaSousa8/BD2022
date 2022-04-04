-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Moradas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Moradas` (
  `idMorada` INT NOT NULL,
  `Rua` VARCHAR(45) NULL,
  `Andar` VARCHAR(45) NULL,
  `Porta` VARCHAR(45) NULL,
  `CodPostal` VARCHAR(45) NULL,
  PRIMARY KEY (`idMorada`));


-- -----------------------------------------------------
-- Table `mydb`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Paciente` (
  `idPaciente` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `DataNascimento` DATE NULL,
  `Sexo` VARCHAR(45) NULL,
  `Contribuinte` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Telemovel` VARCHAR(45) NULL,
  `Moradas_idMorada` INT NOT NULL,
  PRIMARY KEY (`idPaciente`),
  CONSTRAINT `fk_Paciente_Moradas1`
    FOREIGN KEY (`Moradas_idMorada`)
    REFERENCES `mydb`.`Moradas` (`idMorada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Paciente_Moradas1_idx` ON `mydb`.`Paciente` (`Moradas_idMorada` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Prescricao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Prescricao` (
  `idPrescricao` INT NOT NULL,
  `Paciente_idPaciente1` INT NOT NULL,
  `Data Prescricao` VARCHAR(45) NOT NULL,
  `DataValidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPrescricao`, `Paciente_idPaciente1`),
  CONSTRAINT `fk_Prescricao_Paciente1`
    FOREIGN KEY (`Paciente_idPaciente1`)
    REFERENCES `mydb`.`Paciente` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Prescricao_Paciente1_idx` ON `mydb`.`Prescricao` (`Paciente_idPaciente1` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Analises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Analises` (
  `codAnalise` INT NOT NULL,
  `Descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`codAnalise`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prescricao_has_Analises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Prescricao_has_Analises` (
  `Prescricao_idPrescricao` INT NOT NULL,
  `Prescricao_Paciente_idPaciente` INT NOT NULL,
  `Analises_codAnalise` INT NOT NULL,
  PRIMARY KEY (`Prescricao_idPrescricao`, `Prescricao_Paciente_idPaciente`, `Analises_codAnalise`),
  CONSTRAINT `fk_Prescricao_has_Analises_Prescricao1`
    FOREIGN KEY (`Prescricao_idPrescricao`)
    REFERENCES `mydb`.`Prescricao` (`idPrescricao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prescricao_has_Analises_Analises1`
    FOREIGN KEY (`Analises_codAnalise`)
    REFERENCES `mydb`.`Analises` (`codAnalise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Prescricao_has_Analises_Analises1_idx` ON `mydb`.`Prescricao_has_Analises` (`Analises_codAnalise` ASC) VISIBLE;

CREATE INDEX `fk_Prescricao_has_Analises_Prescricao1_idx` ON `mydb`.`Prescricao_has_Analises` (`Prescricao_idPrescricao` ASC, `Prescricao_Paciente_idPaciente` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Clinica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clinica` (
  `idClinica` INT NOT NULL,
  `Moradas_idMorada` INT NOT NULL,
  `Moradas_Paciente_idPaciente` INT NOT NULL,
  `DataInicio` DATE NULL,
  PRIMARY KEY (`idClinica`, `Moradas_idMorada`, `Moradas_Paciente_idPaciente`),
  CONSTRAINT `fk_Clinica_Moradas1`
    FOREIGN KEY (`Moradas_idMorada`)
    REFERENCES `mydb`.`Moradas` (`idMorada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Clinica_Moradas1_idx` ON `mydb`.`Clinica` (`Moradas_idMorada` ASC, `Moradas_Paciente_idPaciente` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Sala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sala` (
  `codSala` INT NOT NULL,
  `Clinica_idClinica` INT NOT NULL,
  `Estado` BINARY(1) NULL,
  `Nome` VARCHAR(45) NULL,
  PRIMARY KEY (`codSala`, `Clinica_idClinica`),
  CONSTRAINT `fk_Sala_Clinica1`
    FOREIGN KEY (`Clinica_idClinica`)
    REFERENCES `mydb`.`Clinica` (`idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Sala_Clinica1_idx` ON `mydb`.`Sala` (`Clinica_idClinica` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Colheita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Colheita` (
  `Prescricao_idPrescricao` INT NOT NULL,
  `Prescricao_Paciente_idPaciente1` INT NOT NULL,
  `Sala_codSala` INT NOT NULL,
  `Sala_Clinica_idClinica` INT NOT NULL,
  `Funcionario_has_Clinica1_Funcionario_numMecanografico` INT NOT NULL,
  `Funcionario_has_Clinica1_Clinica_idClinica` INT NOT NULL,
  `Analises_has_Material_Analises_codAnalise` INT NOT NULL,
  `Analises_has_Material_Material_idMaterial` INT NOT NULL,
  `Analises_has_Material_Material_Clinica_idClinica1` INT NOT NULL,
  `Resultado` BLOB NULL,
  `idColheita` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Prescricao_idPrescricao`, `Prescricao_Paciente_idPaciente1`, `Sala_codSala`, `Sala_Clinica_idClinica`, `Funcionario_has_Clinica1_Funcionario_numMecanografico`, `Funcionario_has_Clinica1_Clinica_idClinica`, `Analises_has_Material_Analises_codAnalise`, `Analises_has_Material_Material_idMaterial`, `Analises_has_Material_Material_Clinica_idClinica1`, `idColheita`),
  CONSTRAINT `fk_Prescricao_has_Analises1_Prescricao2`
    FOREIGN KEY (`Prescricao_idPrescricao` , `Prescricao_Paciente_idPaciente1`)
    REFERENCES `mydb`.`Prescricao` (`idPrescricao` , `Paciente_idPaciente1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Colheita_Sala2`
    FOREIGN KEY (`Sala_codSala` , `Sala_Clinica_idClinica`)
    REFERENCES `mydb`.`Sala` (`codSala` , `Clinica_idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Colheita_Funcionario_has_Clinica11`
    FOREIGN KEY (`Funcionario_has_Clinica1_Funcionario_numMecanografico` , `Funcionario_has_Clinica1_Clinica_idClinica`)
    REFERENCES `mydb`.`Associado_a` (`Funcionario_numMecanografico` , `Clinica_idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Colheita_Analises_has_Material1`
    FOREIGN KEY (`Analises_has_Material_Analises_codAnalise` , `Analises_has_Material_Material_idMaterial` , `Analises_has_Material_Material_Clinica_idClinica1`)
    REFERENCES `mydb`.`Necessita` (`Analises_codAnalise` , `Material_idMaterial` , `Material_Clinica_idClinica1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Colheita_Sala1_idx` ON `mydb`.`Colheita` (`Sala_codSala` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Prescricao_has_Colheita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Prescricao_has_Colheita` (
  `Prescricao_idPrescricao` INT NOT NULL,
  `Prescricao_Paciente_idPaciente` INT NOT NULL,
  `Colheita_idColheita` INT NOT NULL,
  PRIMARY KEY (`Prescricao_idPrescricao`, `Prescricao_Paciente_idPaciente`, `Colheita_idColheita`),
  CONSTRAINT `fk_Prescricao_has_Colheita_Prescricao1`
    FOREIGN KEY (`Prescricao_idPrescricao`)
    REFERENCES `mydb`.`Prescricao` (`idPrescricao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_Prescricao_has_Colheita_Colheita1_idx` ON `mydb`.`Prescricao_has_Colheita` (`Colheita_idColheita` ASC) VISIBLE;

CREATE INDEX `fk_Prescricao_has_Colheita_Prescricao1_idx` ON `mydb`.`Prescricao_has_Colheita` (`Prescricao_idPrescricao` ASC, `Prescricao_Paciente_idPaciente` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Material` (
  `idMaterial` INT NOT NULL,
  `Clinica_idClinica1` INT NOT NULL,
  `Stock` VARCHAR(45) NULL,
  `Descricao` VARCHAR(45) NULL,
  `PrecoCompra` VARCHAR(45) NULL,
  PRIMARY KEY (`idMaterial`, `Clinica_idClinica1`),
  CONSTRAINT `fk_Material_Clinica1`
    FOREIGN KEY (`Clinica_idClinica1`)
    REFERENCES `mydb`.`Clinica` (`idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Material_Clinica1_idx` ON `mydb`.`Material` (`Clinica_idClinica1` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Funcionario` (
  `numMecanografico` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Estado` VARCHAR(45) NULL,
  `Telemovel` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Username` VARCHAR(45) NULL,
  `Password` VARCHAR(45) NULL,
  PRIMARY KEY (`numMecanografico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Colheita_has_Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Colheita_has_Funcionario` (
  `Colheita_idColheita` INT NOT NULL,
  `Colheita_Sala_codSala` INT NOT NULL,
  `Funcionario_numMecanografico` INT NOT NULL,
  PRIMARY KEY (`Colheita_idColheita`, `Colheita_Sala_codSala`, `Funcionario_numMecanografico`),
  CONSTRAINT `fk_Colheita_has_Funcionario_Funcionario1`
    FOREIGN KEY (`Funcionario_numMecanografico`)
    REFERENCES `mydb`.`Funcionario` (`numMecanografico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Colheita_has_Funcionario_Funcionario1_idx` ON `mydb`.`Colheita_has_Funcionario` (`Funcionario_numMecanografico` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `mydb`.`Funcionario_has_Clinica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Funcionario_has_Clinica` (
  `Funcionario_numMecanografico` INT NOT NULL,
  `Clinica_idClinica` INT NOT NULL,
  PRIMARY KEY (`Funcionario_numMecanografico`, `Clinica_idClinica`),
  CONSTRAINT `fk_Funcionario_has_Clinica_Funcionario1`
    FOREIGN KEY (`Funcionario_numMecanografico`)
    REFERENCES `mydb`.`Funcionario` (`numMecanografico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionario_has_Clinica_Clinica1`
    FOREIGN KEY (`Clinica_idClinica`)
    REFERENCES `mydb`.`Clinica` (`idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Funcionario_has_Clinica_Clinica1_idx` ON `mydb`.`Funcionario_has_Clinica` (`Clinica_idClinica` ASC) VISIBLE;

CREATE INDEX `fk_Funcionario_has_Clinica_Funcionario1_idx` ON `mydb`.`Funcionario_has_Clinica` (`Funcionario_numMecanografico` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Funcao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Funcao` (
  `idFuncao` INT NOT NULL,
  `Funcionario_numMecanografico` INT NOT NULL,
  `Descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFuncao`, `Funcionario_numMecanografico`),
  CONSTRAINT `fk_Funcao_Funcionario1`
    FOREIGN KEY (`Funcionario_numMecanografico`)
    REFERENCES `mydb`.`Funcionario` (`numMecanografico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Funcao_Funcionario1_idx` ON `mydb`.`Funcao` (`Funcionario_numMecanografico` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Registo_Horas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Registo_Horas` (
  `idRegisto` INT NOT NULL,
  `dataInicio` DATETIME NOT NULL,
  `dataFim` DATETIME NULL,
  PRIMARY KEY (`idRegisto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Registo_Horas_has_Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Registo_Horas_has_Funcionario` (
  `Registo_Horas_idRegisto` INT NOT NULL,
  `Funcionario_numMecanografico` INT NOT NULL,
  PRIMARY KEY (`Registo_Horas_idRegisto`, `Funcionario_numMecanografico`),
  CONSTRAINT `fk_Registo_Horas_has_Funcionario_Registo_Horas1`
    FOREIGN KEY (`Registo_Horas_idRegisto`)
    REFERENCES `mydb`.`Registo_Horas` (`idRegisto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registo_Horas_has_Funcionario_Funcionario1`
    FOREIGN KEY (`Funcionario_numMecanografico`)
    REFERENCES `mydb`.`Funcionario` (`numMecanografico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Registo_Horas_has_Funcionario_Funcionario1_idx` ON `mydb`.`Registo_Horas_has_Funcionario` (`Funcionario_numMecanografico` ASC) VISIBLE;

CREATE INDEX `fk_Registo_Horas_has_Funcionario_Registo_Horas1_idx` ON `mydb`.`Registo_Horas_has_Funcionario` (`Registo_Horas_idRegisto` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Funcionario_has_Registo_Horas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Funcionario_has_Registo_Horas` (
  `Funcionario_numMecanografico` INT NOT NULL,
  `Registo_Horas_idRegisto` INT NOT NULL,
  PRIMARY KEY (`Funcionario_numMecanografico`, `Registo_Horas_idRegisto`),
  CONSTRAINT `fk_Funcionario_has_Registo_Horas_Funcionario1`
    FOREIGN KEY (`Funcionario_numMecanografico`)
    REFERENCES `mydb`.`Funcionario` (`numMecanografico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionario_has_Registo_Horas_Registo_Horas1`
    FOREIGN KEY (`Registo_Horas_idRegisto`)
    REFERENCES `mydb`.`Registo_Horas` (`idRegisto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Funcionario_has_Registo_Horas_Registo_Horas1_idx` ON `mydb`.`Funcionario_has_Registo_Horas` (`Registo_Horas_idRegisto` ASC) VISIBLE;

CREATE INDEX `fk_Funcionario_has_Registo_Horas_Funcionario1_idx` ON `mydb`.`Funcionario_has_Registo_Horas` (`Funcionario_numMecanografico` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Analises_has_Colheita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Analises_has_Colheita` (
  `Analises_codAnalise` INT NOT NULL,
  `Colheita_idColheita` INT NOT NULL,
  `Colheita_Sala_codSala` INT NOT NULL,
  PRIMARY KEY (`Analises_codAnalise`, `Colheita_idColheita`, `Colheita_Sala_codSala`),
  CONSTRAINT `fk_Analises_has_Colheita_Analises1`
    FOREIGN KEY (`Analises_codAnalise`)
    REFERENCES `mydb`.`Analises` (`codAnalise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE INDEX `fk_Analises_has_Colheita_Analises1_idx` ON `mydb`.`Analises_has_Colheita` (`Analises_codAnalise` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`COLHEITAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`COLHEITAS` (
  `Prescricao_idPrescricao` INT NOT NULL,
  `Prescricao_Paciente_idPaciente` INT NOT NULL,
  `Analises_codAnalise` INT NOT NULL,
  `Funcionario_has_Clinica_Funcionario_numMecanografico` INT NOT NULL,
  `Funcionario_has_Clinica_Clinica_idClinica` INT NOT NULL,
  PRIMARY KEY (`Prescricao_idPrescricao`, `Prescricao_Paciente_idPaciente`, `Analises_codAnalise`, `Funcionario_has_Clinica_Funcionario_numMecanografico`, `Funcionario_has_Clinica_Clinica_idClinica`),
  CONSTRAINT `fk_Prescricao_has_Analises1_Prescricao1`
    FOREIGN KEY (`Prescricao_idPrescricao`)
    REFERENCES `mydb`.`Prescricao` (`idPrescricao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prescricao_has_Analises1_Analises1`
    FOREIGN KEY (`Analises_codAnalise`)
    REFERENCES `mydb`.`Analises` (`codAnalise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COLHEITAS_Funcionario_has_Clinica1`
    FOREIGN KEY (`Funcionario_has_Clinica_Funcionario_numMecanografico` , `Funcionario_has_Clinica_Clinica_idClinica`)
    REFERENCES `mydb`.`Funcionario_has_Clinica` (`Funcionario_numMecanografico` , `Clinica_idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Prescricao_has_Analises1_Analises1_idx` ON `mydb`.`COLHEITAS` (`Analises_codAnalise` ASC) VISIBLE;

CREATE INDEX `fk_Prescricao_has_Analises1_Prescricao1_idx` ON `mydb`.`COLHEITAS` (`Prescricao_idPrescricao` ASC, `Prescricao_Paciente_idPaciente` ASC) VISIBLE;

CREATE INDEX `fk_COLHEITAS_Funcionario_has_Clinica1_idx` ON `mydb`.`COLHEITAS` (`Funcionario_has_Clinica_Funcionario_numMecanografico` ASC, `Funcionario_has_Clinica_Clinica_idClinica` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`COLHEITAS_has_Funcionario_has_Clinica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`COLHEITAS_has_Funcionario_has_Clinica` (
  `COLHEITAS_Prescricao_idPrescricao` INT NOT NULL,
  `COLHEITAS_Prescricao_Paciente_idPaciente` INT NOT NULL,
  `COLHEITAS_Analises_codAnalise` INT NOT NULL,
  `Funcionario_has_Clinica_Funcionario_numMecanografico` INT NOT NULL,
  `Funcionario_has_Clinica_Clinica_idClinica` INT NOT NULL,
  PRIMARY KEY (`COLHEITAS_Prescricao_idPrescricao`, `COLHEITAS_Prescricao_Paciente_idPaciente`, `COLHEITAS_Analises_codAnalise`, `Funcionario_has_Clinica_Funcionario_numMecanografico`, `Funcionario_has_Clinica_Clinica_idClinica`),
  CONSTRAINT `fk_COLHEITAS_has_Funcionario_has_Clinica_COLHEITAS1`
    FOREIGN KEY (`COLHEITAS_Prescricao_idPrescricao` , `COLHEITAS_Prescricao_Paciente_idPaciente` , `COLHEITAS_Analises_codAnalise`)
    REFERENCES `mydb`.`COLHEITAS` (`Prescricao_idPrescricao` , `Prescricao_Paciente_idPaciente` , `Analises_codAnalise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COLHEITAS_has_Funcionario_has_Clinica_Funcionario_has_Clin1`
    FOREIGN KEY (`Funcionario_has_Clinica_Funcionario_numMecanografico` , `Funcionario_has_Clinica_Clinica_idClinica`)
    REFERENCES `mydb`.`Funcionario_has_Clinica` (`Funcionario_numMecanografico` , `Clinica_idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_COLHEITAS_has_Funcionario_has_Clinica_Funcionario_has_Cl_idx` ON `mydb`.`COLHEITAS_has_Funcionario_has_Clinica` (`Funcionario_has_Clinica_Funcionario_numMecanografico` ASC, `Funcionario_has_Clinica_Clinica_idClinica` ASC) VISIBLE;

CREATE INDEX `fk_COLHEITAS_has_Funcionario_has_Clinica_COLHEITAS1_idx` ON `mydb`.`COLHEITAS_has_Funcionario_has_Clinica` (`COLHEITAS_Prescricao_idPrescricao` ASC, `COLHEITAS_Prescricao_Paciente_idPaciente` ASC, `COLHEITAS_Analises_codAnalise` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`COLHEITA_HAS_MATERIAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`COLHEITA_HAS_MATERIAL` (
  `Material_idMaterial` INT NOT NULL,
  `COLHEITAS_Prescricao_idPrescricao` INT NOT NULL,
  `COLHEITAS_Prescricao_Paciente_idPaciente` INT NOT NULL,
  `COLHEITAS_Analises_codAnalise` INT NOT NULL,
  PRIMARY KEY (`Material_idMaterial`, `COLHEITAS_Prescricao_idPrescricao`, `COLHEITAS_Prescricao_Paciente_idPaciente`, `COLHEITAS_Analises_codAnalise`),
  CONSTRAINT `fk_Material_has_COLHEITAS_Material1`
    FOREIGN KEY (`Material_idMaterial`)
    REFERENCES `mydb`.`Material` (`idMaterial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Material_has_COLHEITAS_COLHEITAS1`
    FOREIGN KEY (`COLHEITAS_Prescricao_idPrescricao` , `COLHEITAS_Prescricao_Paciente_idPaciente` , `COLHEITAS_Analises_codAnalise`)
    REFERENCES `mydb`.`COLHEITAS` (`Prescricao_idPrescricao` , `Prescricao_Paciente_idPaciente` , `Analises_codAnalise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Material_has_COLHEITAS_COLHEITAS1_idx` ON `mydb`.`COLHEITA_HAS_MATERIAL` (`COLHEITAS_Prescricao_idPrescricao` ASC, `COLHEITAS_Prescricao_Paciente_idPaciente` ASC, `COLHEITAS_Analises_codAnalise` ASC) VISIBLE;

CREATE INDEX `fk_Material_has_COLHEITAS_Material1_idx` ON `mydb`.`COLHEITA_HAS_MATERIAL` (`Material_idMaterial` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Associado_a`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Associado_a` (
  `Funcionario_numMecanografico` INT NOT NULL,
  `Clinica_idClinica` INT NOT NULL,
  `DataInicio` DATE NULL,
  `DataFim` DATE NULL,
  PRIMARY KEY (`Funcionario_numMecanografico`, `Clinica_idClinica`),
  CONSTRAINT `fk_Funcionario_has_Clinica1_Funcionario1`
    FOREIGN KEY (`Funcionario_numMecanografico`)
    REFERENCES `mydb`.`Funcionario` (`numMecanografico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionario_has_Clinica1_Clinica1`
    FOREIGN KEY (`Clinica_idClinica`)
    REFERENCES `mydb`.`Clinica` (`idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Funcionario_has_Clinica1_Clinica1_idx` ON `mydb`.`Associado_a` (`Clinica_idClinica` ASC) VISIBLE;

CREATE INDEX `fk_Funcionario_has_Clinica1_Funcionario1_idx` ON `mydb`.`Associado_a` (`Funcionario_numMecanografico` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Necessita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Necessita` (
  `Analises_codAnalise` INT NOT NULL,
  `Material_idMaterial` INT NOT NULL,
  `Material_Clinica_idClinica1` INT NOT NULL,
  `QuantidadeNecessaria` VARCHAR(45) NULL,
  PRIMARY KEY (`Analises_codAnalise`, `Material_idMaterial`, `Material_Clinica_idClinica1`),
  CONSTRAINT `fk_Analises_has_Material_Analises1`
    FOREIGN KEY (`Analises_codAnalise`)
    REFERENCES `mydb`.`Analises` (`codAnalise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Analises_has_Material_Material1`
    FOREIGN KEY (`Material_idMaterial` , `Material_Clinica_idClinica1`)
    REFERENCES `mydb`.`Material` (`idMaterial` , `Clinica_idClinica1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Analises_has_Material_Material1_idx` ON `mydb`.`Necessita` (`Material_idMaterial` ASC, `Material_Clinica_idClinica1` ASC) VISIBLE;

CREATE INDEX `fk_Analises_has_Material_Analises1_idx` ON `mydb`.`Necessita` (`Analises_codAnalise` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Colheita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Colheita` (
  `Prescricao_idPrescricao` INT NOT NULL,
  `Prescricao_Paciente_idPaciente1` INT NOT NULL,
  `Sala_codSala` INT NOT NULL,
  `Sala_Clinica_idClinica` INT NOT NULL,
  `Funcionario_has_Clinica1_Funcionario_numMecanografico` INT NOT NULL,
  `Funcionario_has_Clinica1_Clinica_idClinica` INT NOT NULL,
  `Analises_has_Material_Analises_codAnalise` INT NOT NULL,
  `Analises_has_Material_Material_idMaterial` INT NOT NULL,
  `Analises_has_Material_Material_Clinica_idClinica1` INT NOT NULL,
  `Resultado` BLOB NULL,
  `idColheita` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Prescricao_idPrescricao`, `Prescricao_Paciente_idPaciente1`, `Sala_codSala`, `Sala_Clinica_idClinica`, `Funcionario_has_Clinica1_Funcionario_numMecanografico`, `Funcionario_has_Clinica1_Clinica_idClinica`, `Analises_has_Material_Analises_codAnalise`, `Analises_has_Material_Material_idMaterial`, `Analises_has_Material_Material_Clinica_idClinica1`, `idColheita`),
  CONSTRAINT `fk_Prescricao_has_Analises1_Prescricao2`
    FOREIGN KEY (`Prescricao_idPrescricao` , `Prescricao_Paciente_idPaciente1`)
    REFERENCES `mydb`.`Prescricao` (`idPrescricao` , `Paciente_idPaciente1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Colheita_Sala2`
    FOREIGN KEY (`Sala_codSala` , `Sala_Clinica_idClinica`)
    REFERENCES `mydb`.`Sala` (`codSala` , `Clinica_idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Colheita_Funcionario_has_Clinica11`
    FOREIGN KEY (`Funcionario_has_Clinica1_Funcionario_numMecanografico` , `Funcionario_has_Clinica1_Clinica_idClinica`)
    REFERENCES `mydb`.`Associado_a` (`Funcionario_numMecanografico` , `Clinica_idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Colheita_Analises_has_Material1`
    FOREIGN KEY (`Analises_has_Material_Analises_codAnalise` , `Analises_has_Material_Material_idMaterial` , `Analises_has_Material_Material_Clinica_idClinica1`)
    REFERENCES `mydb`.`Necessita` (`Analises_codAnalise` , `Material_idMaterial` , `Material_Clinica_idClinica1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Prescricao_has_Analises1_Prescricao2_idx` ON `mydb`.`Colheita` (`Prescricao_idPrescricao` ASC, `Prescricao_Paciente_idPaciente1` ASC) VISIBLE;

CREATE INDEX `fk_Colheita_Sala2_idx` ON `mydb`.`Colheita` (`Sala_codSala` ASC, `Sala_Clinica_idClinica` ASC) VISIBLE;

CREATE INDEX `fk_Colheita_Funcionario_has_Clinica11_idx` ON `mydb`.`Colheita` (`Funcionario_has_Clinica1_Funcionario_numMecanografico` ASC, `Funcionario_has_Clinica1_Clinica_idClinica` ASC) VISIBLE;

CREATE INDEX `fk_Colheita_Analises_has_Material1_idx` ON `mydb`.`Colheita` (`Analises_has_Material_Analises_codAnalise` ASC, `Analises_has_Material_Material_idMaterial` ASC, `Analises_has_Material_Material_Clinica_idClinica1` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
