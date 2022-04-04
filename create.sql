-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema clinicas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema clinicas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clinicas` DEFAULT CHARACTER SET utf8 ;
USE `clinicas` ;

-- -----------------------------------------------------
-- Table `clinicas`.`Moradas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Moradas` (
  `idMorada` INT NOT NULL,
  `Rua` VARCHAR(45) NULL,
  `Andar` VARCHAR(45) NULL,
  `Porta` VARCHAR(45) NULL,
  `CodPostal` VARCHAR(45) NULL,
  PRIMARY KEY (`idMorada`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Paciente` (
  `idPaciente` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `DataNascimento` DATE NULL,
  `Sexo` VARCHAR(45) NULL,
  `Contribuinte` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Telemovel` VARCHAR(45) NULL,
  `Moradas_idMorada` INT NOT NULL,
  PRIMARY KEY (`idPaciente`),
  INDEX `fk_Paciente_Moradas1_idx` (`Moradas_idMorada` ASC) VISIBLE,
  CONSTRAINT `fk_Paciente_Moradas1`
    FOREIGN KEY (`Moradas_idMorada`)
    REFERENCES `clinicas`.`Moradas` (`idMorada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Prescricao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Prescricao` (
  `idPrescricao` INT NOT NULL,
  `Paciente_idPaciente1` INT NOT NULL,
  `Data Prescricao` VARCHAR(45) NOT NULL,
  `DataValidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPrescricao`, `Paciente_idPaciente1`),
  INDEX `fk_Prescricao_Paciente1_idx` (`Paciente_idPaciente1` ASC) VISIBLE,
  CONSTRAINT `fk_Prescricao_Paciente1`
    FOREIGN KEY (`Paciente_idPaciente1`)
    REFERENCES `clinicas`.`Paciente` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Analises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Analises` (
  `codAnalise` INT NOT NULL,
  `Descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`codAnalise`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Prescricao_has_Analises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Prescricao_has_Analises` (
  `Prescricao_idPrescricao` INT NOT NULL,
  `Prescricao_Paciente_idPaciente` INT NOT NULL,
  `Analises_codAnalise` INT NOT NULL,
  PRIMARY KEY (`Prescricao_idPrescricao`, `Prescricao_Paciente_idPaciente`, `Analises_codAnalise`),
  INDEX `fk_Prescricao_has_Analises_Analises1_idx` (`Analises_codAnalise` ASC) VISIBLE,
  INDEX `fk_Prescricao_has_Analises_Prescricao1_idx` (`Prescricao_idPrescricao` ASC, `Prescricao_Paciente_idPaciente` ASC) VISIBLE,
  CONSTRAINT `fk_Prescricao_has_Analises_Prescricao1`
    FOREIGN KEY (`Prescricao_idPrescricao`)
    REFERENCES `clinicas`.`Prescricao` (`idPrescricao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prescricao_has_Analises_Analises1`
    FOREIGN KEY (`Analises_codAnalise`)
    REFERENCES `clinicas`.`Analises` (`codAnalise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Clinica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Clinica` (
  `idClinica` INT NOT NULL,
  `Moradas_idMorada` INT NOT NULL,
  `Moradas_Paciente_idPaciente` INT NOT NULL,
  `DataInicio` DATE NULL,
  PRIMARY KEY (`idClinica`, `Moradas_idMorada`, `Moradas_Paciente_idPaciente`),
  INDEX `fk_Clinica_Moradas1_idx` (`Moradas_idMorada` ASC, `Moradas_Paciente_idPaciente` ASC) VISIBLE,
  CONSTRAINT `fk_Clinica_Moradas1`
    FOREIGN KEY (`Moradas_idMorada`)
    REFERENCES `clinicas`.`Moradas` (`idMorada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Sala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Sala` (
  `codSala` INT NOT NULL,
  `Clinica_idClinica` INT NOT NULL,
  `Estado` BINARY(1) NULL,
  `Nome` VARCHAR(45) NULL,
  PRIMARY KEY (`codSala`, `Clinica_idClinica`),
  INDEX `fk_Sala_Clinica1_idx` (`Clinica_idClinica` ASC) VISIBLE,
  CONSTRAINT `fk_Sala_Clinica1`
    FOREIGN KEY (`Clinica_idClinica`)
    REFERENCES `clinicas`.`Clinica` (`idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Colheita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Colheita` (
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
  PRIMARY KEY (`Prescricao_idPrescricao`, `Prescricao_Paciente_idPaciente1`, `Sala_codSala`, `Sala_Clinica_idClinica`, `Funcionario_has_Clinica1_Funcionario_numMecanografico`, `Funcionario_has_Clinica1_Clinica_idClinica`, `Analises_has_Material_Analises_codAnalise`, `Analises_has_Material_Material_idMaterial`, `Analises_has_Material_Material_Clinica_idClinica1`),
  INDEX `fk_Prescricao_has_Analises1_Prescricao2_idx` (`Prescricao_idPrescricao` ASC, `Prescricao_Paciente_idPaciente1` ASC) VISIBLE,
  INDEX `fk_Colheita_Sala2_idx` (`Sala_codSala` ASC, `Sala_Clinica_idClinica` ASC) VISIBLE,
  INDEX `fk_Colheita_Funcionario_has_Clinica11_idx` (`Funcionario_has_Clinica1_Funcionario_numMecanografico` ASC, `Funcionario_has_Clinica1_Clinica_idClinica` ASC) VISIBLE,
  INDEX `fk_Colheita_Analises_has_Material1_idx` (`Analises_has_Material_Analises_codAnalise` ASC, `Analises_has_Material_Material_idMaterial` ASC, `Analises_has_Material_Material_Clinica_idClinica1` ASC) VISIBLE,
  CONSTRAINT `fk_Prescricao_has_Analises1_Prescricao2`
    FOREIGN KEY (`Prescricao_idPrescricao` , `Prescricao_Paciente_idPaciente1`)
    REFERENCES `clinicas`.`Prescricao` (`idPrescricao` , `Paciente_idPaciente1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Colheita_Sala2`
    FOREIGN KEY (`Sala_codSala` , `Sala_Clinica_idClinica`)
    REFERENCES `clinicas`.`Sala` (`codSala` , `Clinica_idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Colheita_Funcionario_has_Clinica11`
    FOREIGN KEY (`Funcionario_has_Clinica1_Funcionario_numMecanografico` , `Funcionario_has_Clinica1_Clinica_idClinica`)
    REFERENCES `clinicas`.`Associado_a` (`Funcionario_numMecanografico` , `Clinica_idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Colheita_Analises_has_Material1`
    FOREIGN KEY (`Analises_has_Material_Analises_codAnalise` , `Analises_has_Material_Material_idMaterial` , `Analises_has_Material_Material_Clinica_idClinica1`)
    REFERENCES `clinicas`.`Necessita` (`Analises_codAnalise` , `Material_idMaterial` , `Material_Clinica_idClinica1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Prescricao_has_Colheita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Prescricao_has_Colheita` (
  `Prescricao_idPrescricao` INT NOT NULL,
  `Prescricao_Paciente_idPaciente` INT NOT NULL,
  `Colheita_idColheita` INT NOT NULL,
  PRIMARY KEY (`Prescricao_idPrescricao`, `Prescricao_Paciente_idPaciente`, `Colheita_idColheita`),
  INDEX `fk_Prescricao_has_Colheita_Colheita1_idx` (`Colheita_idColheita` ASC) VISIBLE,
  INDEX `fk_Prescricao_has_Colheita_Prescricao1_idx` (`Prescricao_idPrescricao` ASC, `Prescricao_Paciente_idPaciente` ASC) VISIBLE,
  CONSTRAINT `fk_Prescricao_has_Colheita_Prescricao1`
    FOREIGN KEY (`Prescricao_idPrescricao`)
    REFERENCES `clinicas`.`Prescricao` (`idPrescricao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prescricao_has_Colheita_Colheita1`
    FOREIGN KEY (`Colheita_idColheita`)
    REFERENCES `clinicas`.`Colheita` (`idColheita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Material` (
  `idMaterial` INT NOT NULL,
  `Clinica_idClinica1` INT NOT NULL,
  `Stock` VARCHAR(45) NULL,
  `Descricao` VARCHAR(45) NULL,
  `PrecoCompra` VARCHAR(45) NULL,
  PRIMARY KEY (`idMaterial`, `Clinica_idClinica1`),
  INDEX `fk_Material_Clinica1_idx` (`Clinica_idClinica1` ASC) VISIBLE,
  CONSTRAINT `fk_Material_Clinica1`
    FOREIGN KEY (`Clinica_idClinica1`)
    REFERENCES `clinicas`.`Clinica` (`idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Funcionario` (
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
-- Table `clinicas`.`Colheita_has_Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Colheita_has_Funcionario` (
  `Colheita_idColheita` INT NOT NULL,
  `Colheita_Sala_codSala` INT NOT NULL,
  `Funcionario_numMecanografico` INT NOT NULL,
  PRIMARY KEY (`Colheita_idColheita`, `Colheita_Sala_codSala`, `Funcionario_numMecanografico`),
  INDEX `fk_Colheita_has_Funcionario_Funcionario1_idx` (`Funcionario_numMecanografico` ASC) VISIBLE,
  INDEX `fk_Colheita_has_Funcionario_Colheita1_idx` (`Colheita_idColheita` ASC, `Colheita_Sala_codSala` ASC) VISIBLE,
  CONSTRAINT `fk_Colheita_has_Funcionario_Colheita1`
    FOREIGN KEY (`Colheita_idColheita` , `Colheita_Sala_codSala`)
    REFERENCES `clinicas`.`Colheita` (`idColheita` , `Sala_codSala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Colheita_has_Funcionario_Funcionario1`
    FOREIGN KEY (`Funcionario_numMecanografico`)
    REFERENCES `clinicas`.`Funcionario` (`numMecanografico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Funcionario_has_Clinica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Funcionario_has_Clinica` (
  `Funcionario_numMecanografico` INT NOT NULL,
  `Clinica_idClinica` INT NOT NULL,
  PRIMARY KEY (`Funcionario_numMecanografico`, `Clinica_idClinica`),
  INDEX `fk_Funcionario_has_Clinica_Clinica1_idx` (`Clinica_idClinica` ASC) VISIBLE,
  INDEX `fk_Funcionario_has_Clinica_Funcionario1_idx` (`Funcionario_numMecanografico` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_has_Clinica_Funcionario1`
    FOREIGN KEY (`Funcionario_numMecanografico`)
    REFERENCES `clinicas`.`Funcionario` (`numMecanografico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionario_has_Clinica_Clinica1`
    FOREIGN KEY (`Clinica_idClinica`)
    REFERENCES `clinicas`.`Clinica` (`idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Funcao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Funcao` (
  `idFuncao` INT NOT NULL,
  `Funcionario_numMecanografico` INT NOT NULL,
  `Descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFuncao`, `Funcionario_numMecanografico`),
  INDEX `fk_Funcao_Funcionario1_idx` (`Funcionario_numMecanografico` ASC) VISIBLE,
  CONSTRAINT `fk_Funcao_Funcionario1`
    FOREIGN KEY (`Funcionario_numMecanografico`)
    REFERENCES `clinicas`.`Funcionario` (`numMecanografico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Registo_Horas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Registo_Horas` (
  `idRegisto` INT NOT NULL,
  `dataInicio` DATETIME NOT NULL,
  `dataFim` DATETIME NULL,
  PRIMARY KEY (`idRegisto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Registo_Horas_has_Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Registo_Horas_has_Funcionario` (
  `Registo_Horas_idRegisto` INT NOT NULL,
  `Funcionario_numMecanografico` INT NOT NULL,
  PRIMARY KEY (`Registo_Horas_idRegisto`, `Funcionario_numMecanografico`),
  INDEX `fk_Registo_Horas_has_Funcionario_Funcionario1_idx` (`Funcionario_numMecanografico` ASC) VISIBLE,
  INDEX `fk_Registo_Horas_has_Funcionario_Registo_Horas1_idx` (`Registo_Horas_idRegisto` ASC) VISIBLE,
  CONSTRAINT `fk_Registo_Horas_has_Funcionario_Registo_Horas1`
    FOREIGN KEY (`Registo_Horas_idRegisto`)
    REFERENCES `clinicas`.`Registo_Horas` (`idRegisto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registo_Horas_has_Funcionario_Funcionario1`
    FOREIGN KEY (`Funcionario_numMecanografico`)
    REFERENCES `clinicas`.`Funcionario` (`numMecanografico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Funcionario_has_Registo_Horas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Funcionario_has_Registo_Horas` (
  `Funcionario_numMecanografico` INT NOT NULL,
  `Registo_Horas_idRegisto` INT NOT NULL,
  PRIMARY KEY (`Funcionario_numMecanografico`, `Registo_Horas_idRegisto`),
  INDEX `fk_Funcionario_has_Registo_Horas_Registo_Horas1_idx` (`Registo_Horas_idRegisto` ASC) VISIBLE,
  INDEX `fk_Funcionario_has_Registo_Horas_Funcionario1_idx` (`Funcionario_numMecanografico` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_has_Registo_Horas_Funcionario1`
    FOREIGN KEY (`Funcionario_numMecanografico`)
    REFERENCES `clinicas`.`Funcionario` (`numMecanografico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionario_has_Registo_Horas_Registo_Horas1`
    FOREIGN KEY (`Registo_Horas_idRegisto`)
    REFERENCES `clinicas`.`Registo_Horas` (`idRegisto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Analises_has_Colheita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Analises_has_Colheita` (
  `Analises_codAnalise` INT NOT NULL,
  `Colheita_idColheita` INT NOT NULL,
  `Colheita_Sala_codSala` INT NOT NULL,
  PRIMARY KEY (`Analises_codAnalise`, `Colheita_idColheita`, `Colheita_Sala_codSala`),
  INDEX `fk_Analises_has_Colheita_Colheita1_idx` (`Colheita_idColheita` ASC, `Colheita_Sala_codSala` ASC) VISIBLE,
  INDEX `fk_Analises_has_Colheita_Analises1_idx` (`Analises_codAnalise` ASC) VISIBLE,
  CONSTRAINT `fk_Analises_has_Colheita_Analises1`
    FOREIGN KEY (`Analises_codAnalise`)
    REFERENCES `clinicas`.`Analises` (`codAnalise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Analises_has_Colheita_Colheita1`
    FOREIGN KEY (`Colheita_idColheita` , `Colheita_Sala_codSala`)
    REFERENCES `clinicas`.`Colheita` (`idColheita` , `Sala_codSala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`COLHEITAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`COLHEITAS` (
  `Prescricao_idPrescricao` INT NOT NULL,
  `Prescricao_Paciente_idPaciente` INT NOT NULL,
  `Analises_codAnalise` INT NOT NULL,
  `Funcionario_has_Clinica_Funcionario_numMecanografico` INT NOT NULL,
  `Funcionario_has_Clinica_Clinica_idClinica` INT NOT NULL,
  PRIMARY KEY (`Prescricao_idPrescricao`, `Prescricao_Paciente_idPaciente`, `Analises_codAnalise`, `Funcionario_has_Clinica_Funcionario_numMecanografico`, `Funcionario_has_Clinica_Clinica_idClinica`),
  INDEX `fk_Prescricao_has_Analises1_Analises1_idx` (`Analises_codAnalise` ASC) VISIBLE,
  INDEX `fk_Prescricao_has_Analises1_Prescricao1_idx` (`Prescricao_idPrescricao` ASC, `Prescricao_Paciente_idPaciente` ASC) VISIBLE,
  INDEX `fk_COLHEITAS_Funcionario_has_Clinica1_idx` (`Funcionario_has_Clinica_Funcionario_numMecanografico` ASC, `Funcionario_has_Clinica_Clinica_idClinica` ASC) VISIBLE,
  CONSTRAINT `fk_Prescricao_has_Analises1_Prescricao1`
    FOREIGN KEY (`Prescricao_idPrescricao`)
    REFERENCES `clinicas`.`Prescricao` (`idPrescricao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prescricao_has_Analises1_Analises1`
    FOREIGN KEY (`Analises_codAnalise`)
    REFERENCES `clinicas`.`Analises` (`codAnalise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COLHEITAS_Funcionario_has_Clinica1`
    FOREIGN KEY (`Funcionario_has_Clinica_Funcionario_numMecanografico` , `Funcionario_has_Clinica_Clinica_idClinica`)
    REFERENCES `clinicas`.`Funcionario_has_Clinica` (`Funcionario_numMecanografico` , `Clinica_idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`COLHEITAS_has_Funcionario_has_Clinica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`COLHEITAS_has_Funcionario_has_Clinica` (
  `COLHEITAS_Prescricao_idPrescricao` INT NOT NULL,
  `COLHEITAS_Prescricao_Paciente_idPaciente` INT NOT NULL,
  `COLHEITAS_Analises_codAnalise` INT NOT NULL,
  `Funcionario_has_Clinica_Funcionario_numMecanografico` INT NOT NULL,
  `Funcionario_has_Clinica_Clinica_idClinica` INT NOT NULL,
  PRIMARY KEY (`COLHEITAS_Prescricao_idPrescricao`, `COLHEITAS_Prescricao_Paciente_idPaciente`, `COLHEITAS_Analises_codAnalise`, `Funcionario_has_Clinica_Funcionario_numMecanografico`, `Funcionario_has_Clinica_Clinica_idClinica`),
  INDEX `fk_COLHEITAS_has_Funcionario_has_Clinica_Funcionario_has_Cl_idx` (`Funcionario_has_Clinica_Funcionario_numMecanografico` ASC, `Funcionario_has_Clinica_Clinica_idClinica` ASC) VISIBLE,
  INDEX `fk_COLHEITAS_has_Funcionario_has_Clinica_COLHEITAS1_idx` (`COLHEITAS_Prescricao_idPrescricao` ASC, `COLHEITAS_Prescricao_Paciente_idPaciente` ASC, `COLHEITAS_Analises_codAnalise` ASC) VISIBLE,
  CONSTRAINT `fk_COLHEITAS_has_Funcionario_has_Clinica_COLHEITAS1`
    FOREIGN KEY (`COLHEITAS_Prescricao_idPrescricao` , `COLHEITAS_Prescricao_Paciente_idPaciente` , `COLHEITAS_Analises_codAnalise`)
    REFERENCES `clinicas`.`COLHEITAS` (`Prescricao_idPrescricao` , `Prescricao_Paciente_idPaciente` , `Analises_codAnalise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COLHEITAS_has_Funcionario_has_Clinica_Funcionario_has_Clin1`
    FOREIGN KEY (`Funcionario_has_Clinica_Funcionario_numMecanografico` , `Funcionario_has_Clinica_Clinica_idClinica`)
    REFERENCES `clinicas`.`Funcionario_has_Clinica` (`Funcionario_numMecanografico` , `Clinica_idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`COLHEITA_HAS_MATERIAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`COLHEITA_HAS_MATERIAL` (
  `Material_idMaterial` INT NOT NULL,
  `COLHEITAS_Prescricao_idPrescricao` INT NOT NULL,
  `COLHEITAS_Prescricao_Paciente_idPaciente` INT NOT NULL,
  `COLHEITAS_Analises_codAnalise` INT NOT NULL,
  PRIMARY KEY (`Material_idMaterial`, `COLHEITAS_Prescricao_idPrescricao`, `COLHEITAS_Prescricao_Paciente_idPaciente`, `COLHEITAS_Analises_codAnalise`),
  INDEX `fk_Material_has_COLHEITAS_COLHEITAS1_idx` (`COLHEITAS_Prescricao_idPrescricao` ASC, `COLHEITAS_Prescricao_Paciente_idPaciente` ASC, `COLHEITAS_Analises_codAnalise` ASC) VISIBLE,
  INDEX `fk_Material_has_COLHEITAS_Material1_idx` (`Material_idMaterial` ASC) VISIBLE,
  CONSTRAINT `fk_Material_has_COLHEITAS_Material1`
    FOREIGN KEY (`Material_idMaterial`)
    REFERENCES `clinicas`.`Material` (`idMaterial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Material_has_COLHEITAS_COLHEITAS1`
    FOREIGN KEY (`COLHEITAS_Prescricao_idPrescricao` , `COLHEITAS_Prescricao_Paciente_idPaciente` , `COLHEITAS_Analises_codAnalise`)
    REFERENCES `clinicas`.`COLHEITAS` (`Prescricao_idPrescricao` , `Prescricao_Paciente_idPaciente` , `Analises_codAnalise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Associado_a`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Associado_a` (
  `Funcionario_numMecanografico` INT NOT NULL,
  `Clinica_idClinica` INT NOT NULL,
  `DataInicio` DATE NULL,
  `DataFim` DATE NULL,
  PRIMARY KEY (`Funcionario_numMecanografico`, `Clinica_idClinica`),
  INDEX `fk_Funcionario_has_Clinica1_Clinica1_idx` (`Clinica_idClinica` ASC) VISIBLE,
  INDEX `fk_Funcionario_has_Clinica1_Funcionario1_idx` (`Funcionario_numMecanografico` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_has_Clinica1_Funcionario1`
    FOREIGN KEY (`Funcionario_numMecanografico`)
    REFERENCES `clinicas`.`Funcionario` (`numMecanografico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionario_has_Clinica1_Clinica1`
    FOREIGN KEY (`Clinica_idClinica`)
    REFERENCES `clinicas`.`Clinica` (`idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Necessita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Necessita` (
  `Analises_codAnalise` INT NOT NULL,
  `Material_idMaterial` INT NOT NULL,
  `Material_Clinica_idClinica1` INT NOT NULL,
  `QuantidadeNecessaria` VARCHAR(45) NULL,
  PRIMARY KEY (`Analises_codAnalise`, `Material_idMaterial`, `Material_Clinica_idClinica1`),
  INDEX `fk_Analises_has_Material_Material1_idx` (`Material_idMaterial` ASC, `Material_Clinica_idClinica1` ASC) VISIBLE,
  INDEX `fk_Analises_has_Material_Analises1_idx` (`Analises_codAnalise` ASC) VISIBLE,
  CONSTRAINT `fk_Analises_has_Material_Analises1`
    FOREIGN KEY (`Analises_codAnalise`)
    REFERENCES `clinicas`.`Analises` (`codAnalise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Analises_has_Material_Material1`
    FOREIGN KEY (`Material_idMaterial` , `Material_Clinica_idClinica1`)
    REFERENCES `clinicas`.`Material` (`idMaterial` , `Clinica_idClinica1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinicas`.`Colheita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinicas`.`Colheita` (
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
  PRIMARY KEY (`Prescricao_idPrescricao`, `Prescricao_Paciente_idPaciente1`, `Sala_codSala`, `Sala_Clinica_idClinica`, `Funcionario_has_Clinica1_Funcionario_numMecanografico`, `Funcionario_has_Clinica1_Clinica_idClinica`, `Analises_has_Material_Analises_codAnalise`, `Analises_has_Material_Material_idMaterial`, `Analises_has_Material_Material_Clinica_idClinica1`),
  INDEX `fk_Prescricao_has_Analises1_Prescricao2_idx` (`Prescricao_idPrescricao` ASC, `Prescricao_Paciente_idPaciente1` ASC) VISIBLE,
  INDEX `fk_Colheita_Sala2_idx` (`Sala_codSala` ASC, `Sala_Clinica_idClinica` ASC) VISIBLE,
  INDEX `fk_Colheita_Funcionario_has_Clinica11_idx` (`Funcionario_has_Clinica1_Funcionario_numMecanografico` ASC, `Funcionario_has_Clinica1_Clinica_idClinica` ASC) VISIBLE,
  INDEX `fk_Colheita_Analises_has_Material1_idx` (`Analises_has_Material_Analises_codAnalise` ASC, `Analises_has_Material_Material_idMaterial` ASC, `Analises_has_Material_Material_Clinica_idClinica1` ASC) VISIBLE,
  CONSTRAINT `fk_Prescricao_has_Analises1_Prescricao2`
    FOREIGN KEY (`Prescricao_idPrescricao` , `Prescricao_Paciente_idPaciente1`)
    REFERENCES `clinicas`.`Prescricao` (`idPrescricao` , `Paciente_idPaciente1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Colheita_Sala2`
    FOREIGN KEY (`Sala_codSala` , `Sala_Clinica_idClinica`)
    REFERENCES `clinicas`.`Sala` (`codSala` , `Clinica_idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Colheita_Funcionario_has_Clinica11`
    FOREIGN KEY (`Funcionario_has_Clinica1_Funcionario_numMecanografico` , `Funcionario_has_Clinica1_Clinica_idClinica`)
    REFERENCES `clinicas`.`Associado_a` (`Funcionario_numMecanografico` , `Clinica_idClinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Colheita_Analises_has_Material1`
    FOREIGN KEY (`Analises_has_Material_Analises_codAnalise` , `Analises_has_Material_Material_idMaterial` , `Analises_has_Material_Material_Clinica_idClinica1`)
    REFERENCES `mydb`.`Necessita` (`Analises_codAnalise` , `Material_idMaterial` , `Material_Clinica_idClinica1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
