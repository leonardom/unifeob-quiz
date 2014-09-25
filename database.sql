use unifeobquiz;

DROP TABLE IF EXISTS `jogadores`;

CREATE TABLE `jogadores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `sessoes`;

CREATE TABLE `sessoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inicio` TIMESTAMP NULL,
  `fim` TIMESTAMP NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `sessoes_jogadores`;

CREATE TABLE `sessoes_jogadores` (
  `sessao_id` int(11) NOT NULL,
  `jogador_id` int(11) NOT NULL,
  PRIMARY KEY (`sessao_id`, `jogador_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `sessoes_perguntas`;

CREATE TABLE `sessoes_perguntas` (
  `sessao_id` int(11) NOT NULL,
  `pergunta_id` int(11) NOT NULL,
  PRIMARY KEY (`sessao_id`, `pergunta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `perguntas`;

CREATE TABLE `perguntas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `perguntas` (`id`, `descricao`)
VALUES
	(1,'Em que ano o Brasil conquistou a última copa do munda de futebol?'),
	(2,'Como e composta a Molécula da agua?'),
	(3,'O que é a Via Lactea?'),
	(4,'Quem era o homem mais sedutor do mundo?'),
	(5,'De quantos anos é constituido um século?'),
	(6,'Qual o coletivo de cães?'),
	(7,'Qual a maior floresta no planeta?'),
	(8,'Qual casal foi expulso do Paraiso?'),
	(9,'Na literatura, quem foi o criado da boneca Emilia?'),
	(10,'Quem é o primeiro substituto do Presidente?'),
	(11,'Qual é o clube brasileiro que ganhou o último mundial inter clubes?'),
	(12,'Quem descobriu o Brazil?');


DROP TABLE IF EXISTS `opcoes_resposta`;

CREATE TABLE `opcoes_resposta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `correta` bit(1) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `pergunta_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`pergunta_id`) REFERENCES `perguntas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `opcoes_resposta` (`id`, `correta`, `descricao`, `pergunta_id`)
VALUES
	(1,00000000,'1998',1),
	(2,00000001,'2002',1),
	(3,00000000,'2006',1),
	(4,00000001,'H2O',2),
	(5,00000000,'HO2',2),
	(6,00000000,'C2O',2),
	(7,00000000,'Civilização Antiga',3),
	(8,00000000,'Marca de Leite',3),
	(9,00000001,'Galaxia',3),
	(10,00000001,'Don Juan',4),
	(11,00000000,'Don Antonio',4),
	(12,00000000,'Don Marco',4),
	(13,00000000,'10',5),
	(14,00000000,'50',5),
	(15,00000001,'100',5),
	(16,00000000,'Bando',6),
	(17,00000001,'Matilha',6),
	(18,00000000,'Rebanho',6),
	(19,00000001,'Amazonica',7),
	(20,00000000,'Negra',7),
	(21,00000000,'De Sherwood',7),
	(22,00000000,'Joao e Maria',8),
	(23,00000000,'Sansao e Dalila',8),
	(24,00000001,'Adao e Eva',8),
	(25,00000001,'Monteiro Lobato',9),
	(26,00000000,'Mauricio de Souza',9),
	(27,00000000,'Jorge Amado',9),
	(28,00000000,'Senador',10),
	(29,00000001,'Vice Presidente',10),
	(30,00000000,'Deputado Federal',10),
	(31,00000000,'São Paulo',11),
	(32,00000000,'Atlético Mineiro',11),
	(33,00000001,'Corinthians',11),
	(34,00000000,'Cristóvão Colombo',12),
	(35,00000001,'Pedro Álvares Cabral',12),
	(36,00000000,'Edson Arantes do Nascimento',12);

DROP TABLE IF EXISTS `Pontuacoes`;

CREATE TABLE `Pontuacoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessao_id` int(11) NOT NULL,
  `jogador_id` int(11) NOT NULL,
  `total_pontos` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY(`sessao_id`) REFERENCES `sessoes` (`id`),
  FOREIGN KEY(`jogador_id`) REFERENCES `jogadores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `respostas`;

CREATE TABLE `respostas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessao_id` int(11) DEFAULT NULL,
  `jogador_id` int(11) DEFAULT NULL,
  `pergunta_id` int(11) DEFAULT NULL,
  `opcao_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`sessao_id`) REFERENCES `sessoes` (`id`),
  FOREIGN KEY (`jogador_id`) REFERENCES `jogadores` (`id`),
  FOREIGN KEY (`pergunta_id`) REFERENCES `perguntas` (`id`),
  FOREIGN KEY (`opcao_id`) REFERENCES `opcoes_resposta` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;