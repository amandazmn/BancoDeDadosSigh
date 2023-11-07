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

insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (32146584, 'California', 'San Jose', 'PO Box 40575', 'Casa', 7253);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (71654091, 'California', 'Whittier', 'Suite 1', 'Casa', 3768);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (85928123, 'California', 'Palmdale', 'Room 206', 'Casa', 9351);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (75623921, 'California', 'San Diego', 'Room 152', 'Casa', 8368);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (11789160, 'California', 'Whittier', 'PO Box 59348', 'Casa', 8200);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (71654926, 'California', 'Santa Ana', 'PO Box 9725', 'Casa', 8770);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (93728656, 'California', 'Santa Rosa', 'PO Box 92409', 'Casa', 7858);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (67746963, 'California', 'Los Angeles', 'PO Box 92328', 'Casa', 3735);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (19460487, 'California', 'Van Nuys', 'PO Box 65611', 'Casa', 8670);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (77939486, 'California', 'Fresno', '2nd Floor', 'Casa', 6076);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (91175224, 'California', 'Corona', '3rd Floor', 'Casa', 9156);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (52528621, 'California', 'Santa Cruz', 'Apt 1345', 'Casa', 9909);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (49836154, 'California', 'Long Beach', 'Apt 1009', 'Casa', 7464);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (89202607, 'California', 'Garden Grove', '9th Floor', 'Casa', 9056);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (36645029, 'California', 'San Rafael', 'PO Box 18784', 'Casa', 8144);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (87310992, 'Cplifornia', 'Garden Grove', 'Suite 22', 'Casa', 5413);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (5103495, 'California', 'Santa Barbara', 'Suite 8', 'Casa', 8627);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (642669, 'California', 'Richmond', 'Suite 39', 'Casa', 6414);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (3202746, 'California', 'Simi Valley', 'Room 240', 'Casa', 2097);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (16648129, 'California', 'Long Beach', 'PO Box 73200', 'Casa', 2920);   


insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (980, '1', '1', 'SIM', '1', '1', '1', '194.64', 4, 3, 4);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (378, '1', '0', 'NÃO', '1', '1', '0', '271.49', 3, 2, 2);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (554, '0', '0', 'SIM', '1', '0', '1', '142.93', 6, 3, 3);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (178, '1', '0', 'SIM', '1', '0', '0', '175.98', 3, 4, 4);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (869, '0', '0', 'SIM', '1', '0', '1', '139.01', 5, 5, 5);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (278, '1', '0', 'NÃO', '1', '0', '0', '269.66', 6, 6, 6);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (924, '0', '1', 'SIM', '1', '0', '1', '168.32', 7, 7, 7);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (894, '1', '0', 'SIM', '1', '0', '1', '171.11', 8, 8, 8);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (609, '1', '0', 'NÃO', '0', '1', '1', '211.21', 9, 9, 9);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (606, '0', '1', 'NÃO', '0', '1', '0', '147.53', 5, 5, 5);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (681, '0', '1', 'SIM', '0', '1', '1', '156.86', 1, 1, 1);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (857, '0', '1', 'SIM', '0', '1', '1', '225.53', 4, 1, 1);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (610, '0', '1', 'SIM', '0', '1', '1', '168.31', 3, 2, 2);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (301, '0', '1', 'SIM', '0', '1', '0', '126.79', 1, 1, 1);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (978, '0', '1', 'SIM', '0', '1', '0', '218.80', 4, 3, 4);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (129, '0', '1', 'SIM', '0', '1', '1', '226.83', 3, 2, 2);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (864, '1', '1', 'SIM', '0', '1', '1', '187.76', 5, 5, 5);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (685, '1', '0', 'NÃO', '0', '1', '0', '245.93', 4, 2, 4);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (183, '1', '0', 'NÃO', '0', '1', '0', '108.83', 3, 2, 2);
insert into quartos (id_quarto , conserto, limpeza, acessibilidade, banheira, frigobar, ar_condicionado , preco, nummax_hospedes, num_cama_solteiro, num_cama_casal) values (533, '0', '1', 'SIM', '1', '0', '1', '194.75', 4, 3, 4);



-- inserts necessidades_especiais Gabriely 
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (1, 'Intolerância a Lactose');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (2, 'Deficiência visual');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (3, 'Deficiência Auditiva');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (4, 'Deficiência Motora');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (5, 'Paralisia cerebral ');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (6, 'Transtorno Bipolar');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (7, 'Esquizofrinia');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (8, 'Síndrome de down');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (9, 'Doença Celíaca');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (10, 'Intolerância ao gluten');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (11, 'Intolerância a Sacarose');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (12, 'Intolerância ao milho');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (13, 'Intolerância a castanhas');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (14, 'Paraplegia');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (15, 'Monoplegia');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (16, 'Amputação');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (17, 'Tatraplegia');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (18, 'Triplegia');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (19, 'Hemiplegia');
insert into necessidades_especiais (id_necessidade, necessidade_especial) values (20, 'Talidomida');
