-- -----------------------------------------------------
-- Drop Database
-- -----------------------------------------------------
DROP DATABASE IF EXISTS sigh;

-- -----------------------------------------------------
-- Create Database
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS sigh;

-- -----------------------------------------------------
-- Use Database
-- -----------------------------------------------------
USE sigh;

-- -----------------------------------------------------
-- Table   `enderecos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS   `enderecos` (
  `id_endereco` INT NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `numero` INT NULL,
  PRIMARY KEY (`id_endereco`));


-- -----------------------------------------------------
-- Table   `hospedes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS   `hospedes` (
  `id_hospede` INT NOT NULL,
  `primeiro_nome` VARCHAR(45) NOT NULL,
  `sobrenome` VARCHAR(100) NOT NULL,
  `nome_social` VARCHAR(45) NULL,
  `genero` VARCHAR(45) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `nacionalidade` VARCHAR(45) NOT NULL,
  `cpf` INT NULL,
  `passaporte` VARCHAR(8) NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefone` INT NOT NULL,
  `id_endereco` INT NOT NULL,
  `id_responsavel` INT NULL,
  PRIMARY KEY (`id_hospede`),
  CONSTRAINT `fk_hospedes_enderecos`
    FOREIGN KEY (`id_endereco`)
    REFERENCES   `enderecos` (`id_endereco`),
  CONSTRAINT `fk_hospedes_hospedes1`
    FOREIGN KEY (`id_responsavel`)
    REFERENCES   `hospedes` (`id_hospede`));


-- -----------------------------------------------------
-- Table   `necessidades_especiais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS   `necessidades_especiais` (
  `id_necessidade` INT NOT NULL,
  `necessidade_especial` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_necessidade`));


-- -----------------------------------------------------
-- Table   `hospedagens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS   `hospedagens` (
  `id_hospedagem` INT NOT NULL,
  `data_saida` DATETIME NOT NULL,
  `data_entrada` DATETIME NOT NULL,
  PRIMARY KEY (`id_hospedagem`));


-- -----------------------------------------------------
-- Table   `quartos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS   `quartos` (
  `id_quarto` INT NOT NULL,
  `conserto` TINYINT NOT NULL,
  `limpeza` TINYINT NOT NULL,
  `acessibilidade` VARCHAR(45) NOT NULL,
  `banheira` TINYINT NOT NULL,
  `frigobar` TINYINT NOT NULL,
  `ar_condicionado` TINYINT NOT NULL,
  `preco` FLOAT NOT NULL,
  `nummax_hospedes` INT NOT NULL,
  `num_cama_solteiro` INT NOT NULL,
  `num_cama_casal` INT NOT NULL,
  PRIMARY KEY (`id_quarto`));


-- -----------------------------------------------------
-- Table   `hospede_hospedagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS   `hospede_hospedagem` (
  `id_hospede_hospedagem` INT NOT NULL,
  `id_hospedagem` INT NOT NULL,
  `id_hospede` INT NOT NULL,
  `id_quarto` INT NOT NULL,
  PRIMARY KEY (`id_hospede_hospedagem`),
  CONSTRAINT `fk_hospede_hospedagem_hospedagens1`
    FOREIGN KEY (`id_hospedagem`)
    REFERENCES   `hospedagens` (`id_hospedagem`),
  CONSTRAINT `fk_hospede_hospedagem_hospedes1`
    FOREIGN KEY (`id_hospede`)
    REFERENCES   `hospedes` (`id_hospede`),
  CONSTRAINT `fk_hospede_hospedagem_quartos1`
    FOREIGN KEY (`id_quarto`)
    REFERENCES   `quartos` (`id_quarto`));

-- -----------------------------------------------------
-- Table   `departamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS   `departamentos` (
  `id_departamento` INT NOT NULL,
  `nome_departamernto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_departamento`));

-- -----------------------------------------------------
-- Table   `pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS   `pedidos` (
  `id_pedidos` INT NOT NULL,
  `data_horario` DATETIME NOT NULL,
  `descricao` VARCHAR(45) NULL,
  `quantidade` INT NOT NULL,
  `preco` FLOAT NULL,
  `pronto` TINYINT NOT NULL,
  `entregue` TINYINT NOT NULL,
  `pago` TINYINT NULL,
  `id_hospedagem` INT NOT NULL,
  `id_quarto` INT NOT NULL,
  `id_departamento` INT NOT NULL,
  PRIMARY KEY (`id_pedidos`),
  CONSTRAINT `fk_pedidos_hospedagens1`
    FOREIGN KEY (`id_hospedagem`)
    REFERENCES   `hospedagens` (`id_hospedagem`),
  CONSTRAINT `fk_pedidos_quartos1`
    FOREIGN KEY (`id_quarto`)
    REFERENCES   `quartos` (`id_quarto`),
  CONSTRAINT `fk_pedidos_departamentos1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES `departamentos` (`id_departamento`));


-- -----------------------------------------------------
-- Table   `necessidades_hospede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS   `necessidades_hospede` (
  `id_necessidade_hospede` INT NOT NULL,
  `id_hospede` INT NOT NULL,
  `id_necessidade` INT NOT NULL,
  PRIMARY KEY (`id_necessidade_hospede`),
  CONSTRAINT `fk_hospedes_has_necessidades_especiais_hospedes1`
    FOREIGN KEY (`id_hospede`)
    REFERENCES   `hospedes` (`id_endereco`),
  CONSTRAINT `fk_hospedes_has_necessidades_especiais_necessidades_especiais1`
    FOREIGN KEY (`id_necessidade`)
    REFERENCES   `necessidades_especiais` (`id_necessidade`));




-- -----------------------------------------------------
-- Table   `cargos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS   `cargos` (
  `id_cargo` INT NOT NULL,
  `nome_cargo` VARCHAR(45) NOT NULL,
  `id_departamento` INT NOT NULL,
  PRIMARY KEY (`id_cargo`),
  CONSTRAINT `fk_cargos_departamentos1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES   `departamentos` (`id_departamento`));

-- -----------------------------------------------------
-- Table   `usuarios_senhas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS   `usuarios_senhas` (
  `id_usuario` INT NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `tipo_acesso` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_usuario`));
  
-- -----------------------------------------------------
-- Table   `funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS   `funcionarios` (
  `id_funcionario` INT NOT NULL,
  `primeiro_nome` VARCHAR(45) NOT NULL,
  `sobrenome` VARCHAR(45) NOT NULL,
  `nome_social` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `id_cargo` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_funcionario`),
   CONSTRAINT `fk_id_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES   `usuarios_senhas` (`id_usuario`),
  CONSTRAINT `fk_funcionarios_cargos1`
    FOREIGN KEY (`id_cargo`)
    REFERENCES   `cargos` (`id_cargo`)
    );
    
-- -----------------------------------------------------
-- Alter table: criar coluna id_chefe_departamento
-- -----------------------------------------------------   
ALTER TABLE `departamentos` ADD `id_chefe_departamento` int;

-- -----------------------------------------------------
-- Alter table: adicionar chave estrangeira
-- -----------------------------------------------------  
ALTER TABLE `departamentos` ADD FOREIGN KEY (id_chefe_departamento) REFERENCES `funcionarios` (`id_funcionario`);      