-- MySQL Script generated by MySQL Workbench
-- Tue May 21 17:31:37 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema STOCAKIBD
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema STOCAKIBD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `STOCAKIBD` DEFAULT CHARACTER SET utf8 ;
USE `STOCAKIBD` ;

-- -----------------------------------------------------
-- Table `STOCAKIBD`.`ESTOQUE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `STOCAKIBD`.`ESTOQUE` ;

CREATE TABLE IF NOT EXISTS `STOCAKIBD`.`ESTOQUE` (
  `ID_ESTOQUE` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`ID_ESTOQUE`),
  UNIQUE INDEX `ID_ESTOQUE_UNIQUE` (`ID_ESTOQUE` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STOCAKIBD`.`ARMAZEM`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `STOCAKIBD`.`ARMAZEM` ;

CREATE TABLE IF NOT EXISTS `STOCAKIBD`.`ARMAZEM` (
  `ID_ARMAZEM` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(25) NOT NULL,
  `ID_ESTOQUE` INT NOT NULL,
  PRIMARY KEY (`ID_ARMAZEM`),
  INDEX `fk_Armazem_Estoque1_idx` (`ID_ESTOQUE` ASC) ,
  UNIQUE INDEX `ID_ARMAZEM_UNIQUE` (`ID_ARMAZEM` ASC) ,
  CONSTRAINT `fk_Armazem_Estoque1`
    FOREIGN KEY (`ID_ESTOQUE`)
    REFERENCES `STOCAKIBD`.`ESTOQUE` (`ID_ESTOQUE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STOCAKIBD`.`PRODUTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `STOCAKIBD`.`PRODUTO` ;

CREATE TABLE IF NOT EXISTS `STOCAKIBD`.`PRODUTO` (
  `ID_PRODUTO` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(25) NOT NULL,
  `MODELO` VARCHAR(25) NOT NULL,
  `DESCRICAO` VARCHAR(100) NULL,
  `CLASSIFICACAO` VARCHAR(15) NULL,
  `LOTE` VARCHAR(15) NULL,
  `COR` VARCHAR(15) NULL,
  `SALDO` INT NOT NULL,
  `ID_ARMAZEM` INT NOT NULL,
  PRIMARY KEY (`ID_PRODUTO`),
  INDEX `fk_Produto_Armazem_idx` (`ID_ARMAZEM` ASC) ,
  UNIQUE INDEX `ID_PRODUTO_UNIQUE` (`ID_PRODUTO` ASC) ,
  CONSTRAINT `fk_Produto_Armazem`
    FOREIGN KEY (`ID_ARMAZEM`)
    REFERENCES `STOCAKIBD`.`ARMAZEM` (`ID_ARMAZEM`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STOCAKIBD`.`FUNCIONARIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `STOCAKIBD`.`FUNCIONARIO` ;

CREATE TABLE IF NOT EXISTS `STOCAKIBD`.`FUNCIONARIO` (
  `ID_FUNCIONARIO` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(45) NOT NULL,
  `CPF` INT NOT NULL,
  `CARGO` VARCHAR(15) NOT NULL,
  `CEP` INT NOT NULL,
  `NIVEL_ACESSO` VARCHAR(1) NOT NULL DEFAULT 'O',
  `TELEFONE` INT NULL,
  `EMAIL` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_FUNCIONARIO`),
  UNIQUE INDEX `cpf_UNIQUE` (`CPF` ASC) ,
  UNIQUE INDEX `ID_FUNCIONARIO_UNIQUE` (`ID_FUNCIONARIO` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STOCAKIBD`.`MOVIMENTACAO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `STOCAKIBD`.`MOVIMENTACAO` ;

CREATE TABLE IF NOT EXISTS `STOCAKIBD`.`MOVIMENTACAO` (
  `ID_MOVIMENTACAO` INT NOT NULL AUTO_INCREMENT,
  `DATAEHORA` DATETIME NOT NULL,
  `MOVIMENTACAOTYPE` VARCHAR(1) NOT NULL,
  `SALDO` INT NOT NULL,
  `ID_PRODUTO` INT NOT NULL,
  `ID_FUNCIONARIO` INT NOT NULL,
  PRIMARY KEY (`ID_MOVIMENTACAO`),
  INDEX `fk_Movimentacao_Produto1_idx` (`ID_PRODUTO` ASC) ,
  INDEX `fk_Movimentacao_Funcionario1_idx` (`ID_FUNCIONARIO` ASC) ,
  UNIQUE INDEX `ID_MOVIMENTACAO_UNIQUE` (`ID_MOVIMENTACAO` ASC) ,
  CONSTRAINT `fk_Movimentacao_Produto1`
    FOREIGN KEY (`ID_PRODUTO`)
    REFERENCES `STOCAKIBD`.`PRODUTO` (`ID_PRODUTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movimentacao_Funcionario1`
    FOREIGN KEY (`ID_FUNCIONARIO`)
    REFERENCES `STOCAKIBD`.`FUNCIONARIO` (`ID_FUNCIONARIO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STOCAKIBD`.`REQUISICAO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `STOCAKIBD`.`REQUISICAO` ;

CREATE TABLE IF NOT EXISTS `STOCAKIBD`.`REQUISICAO` (
  `ID_REQUISICAO` INT NOT NULL AUTO_INCREMENT,
  `STATUS_APROVACAO` VARCHAR(1) NOT NULL DEFAULT 'E',
  `NOME` VARCHAR(25) NOT NULL,
  `MODELO` VARCHAR(25) NOT NULL,
  `DESCRICAO` VARCHAR(100) NULL,
  `CLASSIFICACAO` VARCHAR(15) NULL,
  `LOTE` VARCHAR(15) NULL,
  `COR` VARCHAR(15) NULL,
  `SALDO` INT NOT NULL,
  `ID_FUNCIONARIO` INT NOT NULL,
  PRIMARY KEY (`ID_REQUISICAO`),
  INDEX `fk_Requisicao_Funcionario1_idx` (`ID_FUNCIONARIO` ASC) ,
  UNIQUE INDEX `ID_REQUISICAO_UNIQUE` (`ID_REQUISICAO` ASC) ,
  CONSTRAINT `fk_Requisicao_Funcionario1`
    FOREIGN KEY (`ID_FUNCIONARIO`)
    REFERENCES `STOCAKIBD`.`FUNCIONARIO` (`ID_FUNCIONARIO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO ESTOQUE (NOME) VALUES('DEFAULT');
INSERT INTO ARMAZEM (NOME, ID_ESTOQUE) VALUES('DEFAULT', 1);
INSERT INTO FUNCIONARIO (NOME, CPF, CARGO, CEP, NIVEL_ACESSO, TELEFONE, EMAIL) VALUES('teste',1,'teste',1,'A',1,'teste@teste.com');
INSERT INTO FUNCIONARIO (NOME, CPF, CARGO, CEP, NIVEL_ACESSO, TELEFONE, EMAIL) VALUES('teste',2,'teste',1,'O',1,'teste@teste.com');

INSERT INTO REQUISICAO (NOME, MODELO, DESCRICAO, CLASSIFICACAO, LOTE, COR, SALDO, ID_FUNCIONARIO) VALUES ('brastemp', 'm1', 'teste teste teste teste', 'c3', 'l1', 'vermelha', 7, 2);
INSERT INTO REQUISICAO (NOME, MODELO, DESCRICAO, CLASSIFICACAO, LOTE, COR, SALDO, ID_FUNCIONARIO) VALUES ('nao brastemp', 'm3', 'teste teste teste', 'c2', 'l1', 'branca', 5, 2);
INSERT INTO REQUISICAO (NOME, MODELO, DESCRICAO, CLASSIFICACAO, LOTE, COR, SALDO, ID_FUNCIONARIO) VALUES ('eletrolux', 'm2', 'teste teste', 'c2', 'l1', 'branca', 5, 2);

SELECT * FROM FUNCIONARIO;
SELECT * FROM REQUISICAO;
SELECT * FROM PRODUTO;
