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
    REFERENCES   `hospedes` (`id_hospede`),
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

-- inserts enderecos 
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (321, 'Geórgia', 'San Jose', 'PO Box 40575', 'Casa', 7253);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (716, 'Santa Catarina', 'Whittier', 'Suite 1', 'Casa', 3768);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (859, 'California', 'Palmdale', 'Room 206', 'Casa', 9351);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (756, 'Parana', 'San Diego', 'Room 152', 'Casa', 8368);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (117, 'São Paulo', 'Whittier', 'PO Box 59348', 'Casa', 8200);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (710, 'California', 'Santa Ana', 'PO Box 9725', 'Casa', 8770);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (937, 'Rio Grande do Sul', 'Santa Rosa', 'PO Box 92409', 'Casa', 7858);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (677, 'Texas', 'Los Angeles', 'PO Box 92328', 'Casa', 3735);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (194, 'Flórida', 'Van Nuys', 'PO Box 65611', 'Casa', 8670);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (779, 'California', 'Fresno', '2nd Floor', 'Casa', 6076);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (911, 'Rio de Janeiro', 'Corona', '3rd Floor', 'Casa', 9156);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (525, 'Rio de Janeiro', 'Santa Cruz', 'Apt 1345', 'Casa', 9909);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (498, 'California', 'Long Beach', 'Apt 1009', 'Casa', 7464);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (892, 'São Paulo', 'Garden Grove', '9th Floor', 'Casa', 9056);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (366, 'São Paulo', 'San Rafael', 'PO Box 18784', 'Casa', 8144);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (873, 'Minas Gerais', 'Garden Grove', 'Suite 22', 'Casa', 5413);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (510, 'Colorado', 'Santa Barbara', 'Suite 8', 'Casa', 8627);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (642, 'Havaí', 'Richmond', 'Suite 39', 'Casa', 6414);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (324, 'Virgínia', 'Simi Valley', 'Room 240', 'Casa', 2097);
insert into enderecos (id_endereco, estado, cidade, endereco, complemento, numero) values (166, 'California', 'Long Beach', 'PO Box 73200', 'Casa', 2920);   

-- inserts hospedes
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (1, 'Bee', 'Wetter', 'Phyllys', 'Female', '2022-11-10', 'United States', 450363329, 'us038789', 'pwetter0@irs.gov', 477748784, 321, null);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (2, 'Josefina', 'Canby', 'Wyn', 'Genderfluid', '2023-02-25', 'Brazil', 875492836, 'ws637030', 'wcanby1@exblog.jp', 085921159, 716, null);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (3, 'Addie', 'Garretts', 'Del', 'Female', '2023-01-14', 'Canada', 552996495, 'hg403564', 'dgarretts2@vk.com', 732425848, 859, 1);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (4, 'Hesther', 'Meletti', 'Gilles', 'Genderqueer', '2023-02-08', 'Dominican Republic', 036594392, 'kl267763', 'gmeletti3@indiatimes.com', 368262143, 756, 2);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (5, 'Aldwin', 'Peltzer', 'Abbe', 'Male', '2023-05-07', 'Canada', 324687718, 'ki635763', 'apeltzer4@ebay.com', 489161905, 117, null);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (6, 'Israel', 'Trotman', 'Janina', 'Genderfluid', '2023-05-02', 'United States', 698814385, 'lo316878', 'jtrotman5@mlb.com', 450432754, 710, 5);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (7, 'Fredra', 'Kliemann', 'Lorianne', 'Female', '2023-04-24', 'Brazil', 581063453, 'hu895685', 'lkliemann6@sun.com', 189156511, 937, null);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (8, 'Zitella', 'Masarrat', 'Sylvia', 'Female', '2022-09-12', 'Brazil', 511874202, 'mk667060', 'smasarrat7@umich.edu', 891477005, 677, null);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (9, 'Byram', 'Turland', 'Georgia', 'Polygender', '2022-06-28', 'Germany', 132364595, 'ki645682', 'gturland8@mozilla.com', 864143915, 194, 7);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (10, 'Hildagard', 'Blethin', 'Leontine', 'Female', '2023-02-04', 'Portugal', 274895374, 'ol172005', 'lblethin9@bbb.org', 965583221, 779, 8);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (11, 'Berkley', 'Fishlee', 'Stillmann', 'Male', '2023-02-01', 'Brazil', 896846771, 'ft089792', 'sfishleea@tuttocitta.it', 716970713, 911, null);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (12, 'Dukey', 'Craigs', 'Early', 'Male', '2022-06-03', 'Brazil', 418376975, 'gt874996', 'ecraigsb@pinterest.com', 329735772, 525, null);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (13, 'Carolyne', 'Hrishchenko', 'Alene', 'Female', '2023-02-12', 'Brazil', 317234416,'ji598213', 'ahrishchenkoc@hp.com', 832475583, 498, 11);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (14, 'Arabel', 'Heugle', 'Nixie', 'Female', '2023-11-06', 'United States', 638404550, 'ko401110', 'nheugled@sakura.ne.jp', 649333207, 892, 12);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (15, 'Kayley', 'Cawsy', 'Annecorinne', 'Female', '2023-02-07', 'Germany', 520304363, 'ki985030', 'acawsye@prlog.org', 288564037, 366, 12);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (16, 'Carmella', 'Houliston', 'Karilynn', 'Female', '2023-06-03', 'Portugal', 418628632, 'ju270959', 'khoulistonf@foxnews.com', 121032215, 873, null);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (17, 'Fabian', 'Poupard', 'Ervin', 'Male', '2023-06-03', 'Brazil', 745065736, 'hu319453', 'epoupardg@reverbnation.com', 796711112, 510, 16);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (18, 'Alexandra', 'Rochelle', 'Caye', 'Female', '2023-09-10', 'Uruguay', 360582163, 'dr428661', 'crochelleh@wsj.com', 319674200, 642, null);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (19, 'Aundrea', 'Bonicelli', 'Nicole', 'Female', '2023-12-03', 'Portugal', 873361330, 'sw043537', 'nbonicellii@ask.com', 128297256, 324, 18);
insert into hospedes (id_hospede, primeiro_nome, sobrenome, nome_social, genero, data_nascimento, nacionalidade, cpf, passaporte, email, telefone, id_endereco, id_responsavel) values (20, 'Quinlan', 'Tregensoe', 'Clayborn', 'Male', '2023-05-19', 'Brazil', 764965966, 'se327774', 'ctregensoej@mac.com', 519622918, 166, null);

-- inserts quartos 
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

-- inserts hospedagens 
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (60675, '2023/08/27', '2023/08/15');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (90243, '2022/03/17', '2023/03/14');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (43481, '2022/01/23', '2023/01/14');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (89929, '2022/09/30', '2022/09/28');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (59521, '2023/06/19', '2023/06/17');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (35170, '2023/08/05', '2023/08/04');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (33210, '2022/04/21', '2022/04/19');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (72549, '2022/04/18', '2023/04/16');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (67875, '2022/09/01', '2022/08/27');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (56426, '2022/12/08', '2022/12/06');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (10693, '2022/08/02', '2022/08/30');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (14828, '2023/01/05', '2022/01/03');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (31300, '2022/08/12', '2023/08/10');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (26277, '2022/10/08', '2023/10/05');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (14853, '2022/03/09', '2022/03/05');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (89355, '2022/07/25', '2022/07/21');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (86296, '2023/03/16', '2022/03/10');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (34519, '2023/02/03', '2023/02/02');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (30734, '2022/05/20', '2023/05/15');
insert into hospedagens (id_hospedagem, data_saida, data_entrada) values (74872, '2023/10/13', '2022/10/02');

-- inserts hospede_hospedagem
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (1, 60675, 1, 980);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (2, 90243, 2, 378);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (3, 43481, 3, 554);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (4, 89929, 4, 178);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (5, 59521, 5, 869);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (6, 35170, 6, 278);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (7, 33210, 7, 924);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (8, 72549, 8, 894);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (9, 67875, 9, 609);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (10, 56426, 10, 606);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (11, 10693, 11, 681);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (12, 14828, 12, 857);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (13, 31300, 13, 610);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (14, 26277, 14, 301);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (15, 14853, 15, 978);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (16, 89355, 16, 129);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (17, 86296, 17, 864);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (18, 34519, 18, 685);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (19, 30734, 19, 183);
insert into hospede_hospedagem (id_hospede_hospedagem, id_hospedagem, id_hospede, id_quarto) values (20, 74872, 20, 533);


-- inserts necessidades_especiais 
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




insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (20, 1, 1);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (19, 2, 2);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (18, 3, 3);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (17, 4, 4);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (16, 5, 5);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (15, 6, 6);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (14, 7, 7);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (13, 8, 8);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (12, 9, 9);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (11, 10, 10);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (10, 11, 11);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (9, 12, 12);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (8, 13, 13);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (7, 14, 14);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (6, 15, 15);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (5, 16, 16);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (4, 17, 17);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (3, 18, 18);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (2, 19, 19);
insert into necessidades_hospede (id_necessidade_hospede, id_hospede, id_necessidade) values (1, 20, 20);


-- select count 

SELECT COUNT(*) FROM enderecos;

SELECT COUNT(*) FROM hospedes;

SELECT COUNT(*) FROM hospede_hospedagem;

SELECT COUNT(*) FROM quartos;

SELECT COUNT(*) FROM necessidades_especiais;

SELECT COUNT(*) FROM hospedagens ;


-- select all

SELECT * FROM enderecos ORDER BY id_endereco;

SELECT * FROM hospedes ORDER BY id_hospede;

SELECT * FROM hospede_hospedagem ORDER BY id_hospede_hospedagem;

SELECT * FROM quartos ORDER BY id_quarto;

SELECT * FROM necessidades_especiais ORDER BY id_necessidade;

SELECT * FROM hospedagens ORDER BY id_hospedagem;

-- updates enderecos
SET SQL_SAFE_UPDATES = 0;
UPDATE enderecos SET id_endereco = 302 WHERE id_endereco = 321;
UPDATE enderecos SET estado = 'California' WHERE estado = 'Geórgia';
UPDATE enderecos SET cidade = 'Rio Preto' WHERE cidade = 'San Jose';
UPDATE enderecos SET endereco = 'Ap 100' WHERE endereco = 'PO Box 40575';
UPDATE enderecos SET complemento = 'casa' WHERE complemento = 'Casa';
UPDATE enderecos SET numero = 7345 WHERE numero = 7253;
UPDATE enderecos SET cidade = 'Santa Clara' WHERE cidade = 'Santa Ana';
UPDATE enderecos SET id_endereco = 11789145 WHERE id_endereco = 11789160;
UPDATE enderecos SET estado = 'Mato Grosso' WHERE estado = 'Minas Gerais';
UPDATE enderecos SET endereco = 'Ap BA 100' WHERE endereco = 'Apt 1345';
SET SQL_SAFE_UPDATES = 1;


-- updates hospedes
SET SQL_SAFE_UPDATES = 0;
UPDATE hospedes SET id_hospede = 2 WHERE id_hospede = 1;
UPDATE hospedes SET sobrenome = 'Klyemen' WHERE sobrenome = 'Kliemann';
UPDATE hospedes SET email = 'europadg@revernation.com' WHERE email = 'epoupardg@reverbnation.com';
UPDATE hospedes SET genero = 'Fem' WHERE genero = 'Female';
UPDATE hospedes SET primeiro_nome = 'Ester' WHERE primeiro_nome = 'Hesther';
UPDATE hospedes SET nome_social = 'Nicie' WHERE nome_social = 'Nixie';
UPDATE hospedes SET data_nascimento = '2022-11-11' WHERE data_nascimento = '2022-11-10';
UPDATE hospedes SET id_responsavel = 3 WHERE id_responsavel = 2;
UPDATE hospedes SET cpf = 428628633 WHERE cpf = 418628632;
UPDATE hospedes SET nacionalidade = 'Brasil' WHERE nacionalidade = 'Brazil';
SET SQL_SAFE_UPDATES = 1;

-- updates quartos 
SET SQL_SAFE_UPDATES = 0;
UPDATE quartos SET num_cama_casal = 2 WHERE num_cama_casal = 1;
UPDATE quartos SET num_cama_solteiro = 3 WHERE num_cama_solteiro = 4;
UPDATE quartos SET nummax_hospedes = 2 WHERE nummax_hospedes = 1;
UPDATE quartos SET preco = 200.00 WHERE preco = 194.64;
UPDATE quartos SET id_quarto = 766 WHERE id_quarto = 980;
UPDATE quartos SET id_quarto = 179 WHERE num_cama_casal = 178;
UPDATE quartos SET nummax_hospedes  = 1 WHERE nummax_hospedes = 5;
UPDATE quartos SET num_cama_casal = 2 WHERE num_cama_casal = 9;
UPDATE quartos SET num_cama_casal = 4 WHERE num_cama_casal = 7;
UPDATE quartos SET num_cama_solteiro = 2 WHERE num_cama_solteiro = 1; 
SET SQL_SAFE_UPDATES = 1;

-- updates hospedagens 
SET SQL_SAFE_UPDATES = 0;
UPDATE hospedagens SET data_saida = '2023/10/12' WHERE data_saida = '2023/10/13';
UPDATE hospedagens SET data_saida = '2022/03/10' WHERE data_saida = '2022/03/09';
UPDATE hospedagens SET data_saida = '2023/08/26' WHERE data_saida = '2023/08/27';
UPDATE hospedagens SET id_hospedagem = 74873 WHERE id_hospedagem = 74872;
UPDATE hospedagens SET id_hospedagem = 31308 WHERE id_hospedagem = 31300;
UPDATE hospedagens SET id_hospedagem = 73451 WHERE id_hospedagem = 86296;
UPDATE hospedagens SET data_entrada = '2022/07/22' WHERE data_entrada = '2022/07/21';
UPDATE hospedagens SET data_entrada = '2022/08/25' WHERE data_entrada = '2022/08/27';
UPDATE hospedagens SET id_hospedagem = 08284 WHERE id_hospedagem = 59521;
UPDATE hospedagens SET data_entrada = '2023/08/14' WHERE data_entrada = '2023/08/15';
SET SQL_SAFE_UPDATES = 1;

-- updates hospede_hospedagem
SET SQL_SAFE_UPDATES = 0;
UPDATE hospede_hospedagem SET id_hospede_hospedagem = 2 WHERE id_hospede_hospedagem = 3;
UPDATE hospede_hospedagem SET id_hospedagem = 26070 WHERE id_hospedagem = 35170;
UPDATE hospede_hospedagem SET id_hospede = 3 WHERE id_hospede = 9;
UPDATE hospede_hospedagem SET id_hospede_hospedagem = 1 WHERE id_hospede_hospedagem = 11;
UPDATE hospede_hospedagem SET id_quarto = 553 WHERE id_quarto = 533;
UPDATE hospede_hospedagem SET id_quarto = 222 WHERE id_quarto = 864;
UPDATE hospede_hospedagem SET id_quarto = 849 WHERE id_quarto = 978;
UPDATE hospede_hospedagem SET id_hospedagem = 26399 WHERE id_hospedagem = 26277;
UPDATE hospede_hospedagem SET id_hospedagem = 33485 WHERE id_hospedagem = 33210;
UPDATE hospede_hospedagem SET id_hospede_hospedagem = 6 WHERE id_hospede_hospedagem = 7;
SET SQL_SAFE_UPDATES = 1;

-- updates necessidades_especiais
SET SQL_SAFE_UPDATES = 0;
UPDATE necessidades_especiais SET id_necessidade = 21 WHERE id_necessidade = 1;
UPDATE necessidades_especiais SET id_necessidade =30 WHERE id_necessidade = 7;
UPDATE necessidades_especiais SET necessidade_especial = 'Deficiente visual' WHERE necessidade_especial = 'Deficiência visual';
UPDATE necessidades_especiais SET id_necessidade = 1 WHERE id_necessidade = 20;
UPDATE necessidades_especiais SET id_necessidade = 22 WHERE id_necessidade = 6;
UPDATE necessidades_especiais SET necessidade_especial = 'Síndrome de Down' WHERE necessidade_especial = 'síndrome de down';
UPDATE necessidades_especiais SET id_necessidade = 24 WHERE id_necessidade = 8;
UPDATE necessidades_especiais SET necessidade_especial= 'Alergia á medicamento Talidomida' WHERE necessidade_especial = 'Talidomia';
UPDATE necessidades_especiais SET id_necessidade = 25 WHERE id_necessidade = 9;
UPDATE necessidades_especiais SET necessidade_especial = 'Bipolaridade' WHERE necessidade_especial = 'Transtorno Bipolar';
SET SQL_SAFE_UPDATES = 1;

-- delete enderecos
SET SQL_SAFE_UPDATES = 0;
DELETE FROM enderecos WHERE id_endereco = 321;
DELETE FROM enderecos WHERE estado = 'Geórgia';
DELETE FROM enderecos WHERE cidade = 'San Jose';
DELETE FROM enderecos WHERE endereco = 'PO Box 40575';
DELETE FROM enderecos WHERE complemento = 'Casa';
SET SQL_SAFE_UPDATES = 1;

-- delete hospedes
SET SQL_SAFE_UPDATES = 0;
DELETE FROM hospedes WHERE id_hospede = 1;
DELETE FROM hospedes WHERE primeiro_nome = 'Bee';
DELETE FROM hospedes WHERE sobrenome = 'Wetter';
DELETE FROM hospedes WHERE genero = 'Female';
DELETE FROM hospedes WHERE data_nasciemento = '2022-11-10';
SET SQL_SAFE_UPDATES = 1;

-- delete hospede_hospedagem
SET SQL_SAFE_UPDATES = 0;
DELETE FROM hospede_hospedagem WHERE id_hospede_hospedagem = 6;
DELETE FROM hospede_hospedagem WHERE id_hospedagem = 60675;
DELETE FROM hospede_hospedagem WHERE id_hospede = 1;
DELETE FROM hospede_hospedagem WHERE id_quarto = 980;
DELETE FROM hospede_hospedagem WHERE id_quarto = 533;
SET SQL_SAFE_UPDATES = 1;

-- delete quartos
SET SQL_SAFE_UPDATES = 0;
DELETE FROM quartos WHERE id_quarto = 980;
DELETE FROM quartos WHERE nummax_hospedes = 8;
DELETE FROM quartos WHERE preco = '194.75';
DELETE FROM quartos WHERE num_cama_casal = 9;
DELETE FROM quartos WHERE num_cama_solteiro = 5;
SET SQL_SAFE_UPDATES = 1;

-- delete necessidades_especiais
SET SQL_SAFE_UPDATES = 0;
DELETE FROM necessidades_especiais WHERE necessidade_especial = 'Intolerância ao milho';
DELETE FROM necessidades_especiais WHERE id_necessidade = 13;
DELETE FROM necessidades_especiais WHERE id_necessidade = 19;
DELETE FROM necessidades_especiais WHERE id_necessidade = 9;
DELETE FROM necessidades_especiais WHERE necessidade_especial = 'Esquizofrinia';
SET SQL_SAFE_UPDATES =  1;


-- delete hospedagens
SET SQL_SAFE_UPDATES = 0; 
DELETE FROM hospedagens WHERE id_hospedagem = 74872;
DELETE FROM hospedagens WHERE id_hospedagem = 60675;
DELETE FROM hospedagens WHERE data_saida = '2022/09/30';
DELETE FROM hospedagens WHERE data_entrada = '2023/02/02';
DELETE FROM hospedagens WHERE data_saida = 2022/04/18;
SET SQL_SAFE_UPDATES = 1;
