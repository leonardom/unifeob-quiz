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
  `ordem` int(11),
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
	(1,'Em que ano o Brasil conquistou a última copa do mundo de futebol?'),
	(2,'Como e composta a Molécula da agua?'),
	(3,'O que é a Via Lactea?'),
	(4,'Quem era o homem mais sedutor do mundo?'),
	(5,'De quantos anos é constituido um século?'),
	(6,'Qual o coletivo de cães?'),
	(7,'Qual a maior floresta no planeta?'),
	(8,'Qual casal foi expulso do Paraiso?'),
	(9,'Na literatura, quem foi o criado da boneca Emilia?'),
	(10,'Quem é o primeiro substituto do Presidente?'),
	(11,'Qual é o clube brasileiro que ganhou o último mundial inter clubes da Fifa?'),
	(12,'Quem descobriu o Brasil?'),
	(13,'Nesta região da Ásia estão localizados dois dos quatro países mais ricos do mundo:'),
	(14,'Qual o coletivo de chave?'),
	(15,'A metade do dobro de uma dúzia é?'),
	(16,'O avião que ultrapassa a velocidade do som é?'),
	(17,'O mesmo que setentrional:'),
	(18,'Depósito de mel das abelhas:'),
	(19,'O número 101 em romanos:'),
	(20,'Onde o papel foi inventado aproximadamente 2000 anos atrás?'),
	(21,'Pronome da terceira pessoa do singular:'),
	(22,'Vegetação rasteira encontrada próximo as regiões polares:'),
	(23,'Número de estados da Região Sudeste do Brasil:'),
	(24,'Foi introduzido na agricultura brasileira em 1727, sendo uma bebida muito apreciada:'),
	(25,'Fábrica de tecidos de algodão:'),
	(26,'Qual o nome da nossa galáxia?'),
	(27,'Termo utilizado para designar alimentos geneticamente modificados:'),
	(28,'Um destes ingredientes não é utilizado como alimento:'),
	(29,'O Castor é uma espécie de:'),
	(30,'A maçã é:'),
	(31,'O tomate é:'),
	(32,'O macarrão é originário da:'),
	(33,'Crença religiosa baseada em muitos deuses:'),
	(34,'Qual é a maior ave do mundo em peso:'),
	(35,'Qual é o maior continente do mundo:'),
	(36,'Laje saliente na fachada dos edifícios:'),
	(37,'1 hectare equivale a:'),
	(38,'Quantos ossos tem o corpo humano:'),
	(39,'Alfred Nobel foi?'),
	(40,'Número de constituições que o Brasil já teve:'),
	(41,'Qual é o maior planeta do Sistema Solar:'),
	(42,'Quem inventou a Lâmpada:'),
	(43,'Qual o maior ser vivo:'),
	(44,'Qual o deus da morte segundo a mitologia grega:'),
	(45,'Qual o deus da mumificação segundo os egípcios:'),
	(46,'A fênix é uma ave originária da mitologia:'),
	(47,'A mitologia cujo deuses são mortais:'),
	(48,'Napoleão morreu:'),
	(49,'Qual destes não foi um império:'),
	(50,'O autor de Sherlock Holmes foi:'),
	(51,'Antes de ser parceiro do Batman, Robin era:'),
	(52,'Quantos anéis de poder os elfos criaram na Terra-Média:'),
	(53,'Quantas guerras o Brasil perdeu:'),
	(54,'a palavra “parentes” em inglês é:');

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
	(36,00000000,'Edson Arantes do Nascimento',12),
	(37,00000001,'Extremo Oriente',13),
	(38,00000000,'Oriente médio',13),
	(39,00000000,'Norte da Ásia',13),
	(40,00000000,'Chaves',14),
	(41,00000001,'Molho',14),
	(42,00000000,'Chaveiro',14),
	(43,00000000,'6',15),
	(44,00000000,'24',15),
	(45,00000001,'12',15),
	(46,00000001,'Supersônico',16),
	(47,00000000,'Hipersônico',16),
	(48,00000000,'Ultrassônico',16),
	(49,00000000,'Sul',17),
	(50,00000001,'Norte',17),
	(51,00000000,'Sudoeste',17),
	(52,00000000,'Colmeia',18),
	(53,00000000,'Favolíneo',18),
	(54,00000001,'Favo',18),
	(55,00000001,'CI',19),
	(56,00000000,'DI',19),
	(57,00000000,'MI',19),
	(58,00000000,'Egito',20),
	(59,00000001,'China',20),
	(60,00000000,'Grécia',20),
	(61,00000000,'Eu',21),
	(62,00000000,'Vós',21),
	(63,00000001,'Ele',21),
	(64,00000001,'Tundra',22),
	(65,00000000,'Gramíneas',22),
	(66,00000000,'Coníferas',22),
	(67,00000000,'3',23),
	(68,00000001,'4',23),
	(69,00000000,'5',23),
	(70,00000000,'Chá',24),
	(71,00000000,'Leite de Cabra',24),
	(72,00000001,'Café',24),
	(73,00000001,'Cotonofício',25),
	(74,00000000,'Algodoaria',25),
	(75,00000000,'Algodolofia',25),
	(76,00000000,'Andrômeda',26),
	(77,00000001,'Via láctea',26),
	(78,00000000,'Sistema Solar',26),
	(79,00000000,'Genéticos',27),
	(80,00000000,'Transdérmicos',27),
	(81,00000001,'Transgênicos',27),
	(82,00000001,'Vinhoto',28),
	(83,00000000,'Farelo de trigo',28),
	(84,00000000,'Amido',28),
	(85,00000000,'Vegetal',29),
	(86,00000001,'Roedor',29),
	(87,00000000,'Morcego',29),
	(88,00000000,'Fruta',30),
	(89,00000000,'Legume',30),
	(90,00000001,'Pseudofruta',30),
	(91,00000001,'Fruta',31),
	(92,00000000,'Legume',31),
	(93,00000000,'Verdura',31),
	(94,00000000,'Alemanha',32),
	(95,00000001,'China',32),
	(96,00000000,'Itália',32),
	(97,00000000,'Paganismo',33),
	(98,00000000,'Gnosticismo',33),
	(99,00000001,'Politeísmo',33),
	(100,00000001,'Avestruz',34),
	(101,00000000,'Ema',34),
	(102,00000000,'Pinguim',34),
	(103,00000000,'Oceania',35),
	(104,00000001,'Ásia',35),
	(105,00000000,'África',35),
	(106,00000000,'Sacada',36),
	(107,00000000,'Beiral',36),
	(108,00000001,'Marquize',36),
	(109,00000001,'10000m²',37),
	(110,00000000,'1000m²',37),
	(111,00000000,'5000m²',37),
	(112,00000000,'204',38),
	(113,00000001,'206',38),
	(114,00000000,'216',38),
	(115,00000000,'Professor Universitário',39),
	(116,00000000,'Farmacêutico',39),
	(117,00000001,'Industrial do ramo bélico',39),
	(118,00000001,'7',40),
	(119,00000000,'1',40),
	(120,00000000,'3',40),
	(121,00000000,'Saturno',41),
	(122,00000001,'Júpiter',41),
	(123,00000000,'Netuno',41),
	(124,00000000,'Nicolas Tesla',42),
	(125,00000000,'Michael Faraday',42),
	(126,00000001,'Thomas Edison',42),
	(127,00000001,'Cogumelo do Mel',43),
	(128,00000000,'Sequoia',43),
	(129,00000000,'Baleia Azul',43),
	(130,00000000,'Hades',44),
	(131,00000001,'Tanatos',44),
	(132,00000000,'Morfeu',44),
	(133,00000000,'Osíris',45),
	(134,00000000,'Seth',45),
	(135,00000001,'Anúbis',45),
	(136,00000001,'Egípcia',46),
	(137,00000000,'Grega',46),
	(138,00000000,'Nórdica',46),
	(139,00000000,'Romana',47),
	(140,00000001,'Nórdica',47),
	(141,00000000,'Chinesa',47),
	(142,00000000,'Em batalha',48),
	(143,00000000,'De velhice',48),
	(144,00000001,'No exílio',48),
	(145,00000001,'Indiano',49),
	(146,00000000,'Macedônico',49),
	(147,00000000,'Egípcio',49),
	(148,00000000,'Agatha Christie',50),
	(149,00000001,'Sir Arthur Conan Doyle',50),
	(150,00000000,'Bram Stocker',50),
	(151,00000000,'Dançarino',51),
	(152,00000000,'Taxista',51),
	(153,00000001,'Trapezista',51),
	(154,00000001,'19',52),
	(155,00000000,'16',52),
	(156,00000000,'3',52),
	(157,00000000,'Duas',53),
	(158,00000001,'Nenhuma',53),
	(159,00000000,'Uma',53),
	(160,00000000,'Parents',54),
	(161,00000000,'Neighbor',54),
	(162,00000001,'Relatives',54);

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