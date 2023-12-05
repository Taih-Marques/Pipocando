drop table if exists curtida_avaliacao;

drop table if exists comentario_avaliacao;

drop table if exists avaliacao;

drop table if exists filme_genero;

drop table if exists filme_ator;

drop table if exists filme;

drop table if exists usuario;

DROP TABLE IF EXISTS genero;

drop table if exists ator;

drop table if exists diretor;

create table diretor(
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nome varchar(100) NOT NULL
);

create table ator(
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nome varchar (100) NOT NULL
);

CREATE TABLE genero(
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nome varchar(20) NOT NULL
);

CREATE TABLE usuario(
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nome varchar(100) NOT NULL,
  email varchar(100) NOT NULL,
  senha varchar(20) NOT NULL
);

CREATE TABLE filme(
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nome varchar(70) NOT NULL,
  banner varchar(1000) NOT NULL,
  sinopse text (2000) NOT NULL,
  ano_lancamento date NOT NULL,
  id_diretor int(11) NOT NULL,
  FOREIGN KEY (id_diretor) REFERENCES diretor(id) ON DELETE CASCADE
);

CREATE TABLE filme_ator(
  id_ator int(11) NOT NULL,
  id_filme int(11) NOT NULL,
  FOREIGN KEY (id_ator) REFERENCES ator(id) ON DELETE CASCADE,
  FOREIGN KEY (id_filme) REFERENCES filme(id) ON DELETE CASCADE
);

CREATE TABLE filme_genero(
  id_filme int(11) NOT NULL,
  id_genero int(11) NOT NULL,
  FOREIGN KEY (id_filme) REFERENCES filme(id) ON DELETE CASCADE,
  FOREIGN KEY (id_genero) REFERENCES genero(id) ON DELETE CASCADE
);

CREATE TABLE avaliacao(
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  id_usuario int(11) NOT NULL,
  id_filme int(11) NOT NULL,
  assistido boolean DEFAULT false,
  favorito boolean DEFAULT false,
  texto text,
  nota float(1),
  data_avaliacao datetime NOT NULL,
  FOREIGN KEY (id_usuario) REFERENCES usuario(id) ON DELETE CASCADE,
  FOREIGN KEY (id_filme) REFERENCES filme(id) ON DELETE CASCADE
);

CREATE TABLE comentario_avaliacao(
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  id_avaliacao int(11) NOT NULL,
  id_usuario int(11) NOT NULL,
  texto text NOT NULL,
  data_comentario datetime NOT NULL,
  FOREIGN KEY (id_avaliacao) REFERENCES avaliacao(id) ON DELETE CASCADE,
  FOREIGN KEY (id_usuario) REFERENCES usuario(id) ON DELETE CASCADE
);

CREATE TABLE curtida_avaliacao(
  id_avaliacao int(11) NOT NULL,
  id_usuario int(11) NOT NULL,
  FOREIGN KEY (id_avaliacao) REFERENCES avaliacao(id) ON DELETE CASCADE,
  FOREIGN KEY (id_usuario) REFERENCES usuario(id) ON DELETE CASCADE
);

-- criando inserts 
-- diretores
INSERT INTO
  diretor (nome)
VALUES
  ('Hayao Miyazaki'),
  ('Tim Burton'),
  ('Quentin Tarantino'),
  ('Charlie Chaplin');

-- FILMES 
INSERT INTO
  filme (
    nome,
    ano_lancamento,
    sinopse,
    id_diretor,
    banner
  )
VALUES
  (
    'Meu vizinho totoro',
    '1988-04-16',
    'Two sisters move to the country with their father in order to be closer to their hospitalized mother, and discover the surrounding trees are inhabited by Totoros, magical spirits of the forest. When the youngest runs away from home, the older sister seeks help from the spirits to find her.',
    1,
    'my-neighborn-totoro.jpg'
  ),
  (
    'Spirited away',
    '2001-07-20',
    'A young girl, Chihiro, becomes trapped in a strange new world of spirits. When her parents undergo a mysterious transformation, she must call upon the courage she never knew she had to free her family.',
    1,
    'spirited-away.jpg'
  ),
  (
    'Princess Mononoke',
    '1997-07-12',
    'THE FATE OF THE WORLD RESTS ON THE COURAGE OF ONE WARRIOR. \n
Ashitaka, a prince of the disappearing Emishi people, is cursed by a demonized boar god and must journey to the west to find a cure. Along the way, he encounters San, a young human woman fighting to protect the forest, and Lady Eboshi, who is trying to destroy it. Ashitaka must find a way to bring balance to this conflict.',
    1,
    'princess-mononoke.jpg'
  ),
  (
    'Ponyo',
    '2008-07-19',
    'WELCOME TO A WORLD WHERE ANYTHING IS POSSIBLE. \n
The son of a sailor, 5-year old Sosuke lives a quiet life on an oceanside cliff with his mother Lisa. One fateful day, he finds a beautiful goldfish trapped in a bottle on the beach and upon rescuing her, names her Ponyo. But she is no ordinary goldfish. The daughter of a masterful wizard and a sea goddess, Ponyo uses her father’s magic to transform herself into a young girl and quickly falls in love with Sosuke, but the use of such powerful sorcery causes a dangerous imbalance in the world. As the moon steadily draws nearer to the earth and Ponyo’s father sends the ocean’s mighty waves to find his daughter, the two children embark on an adventure of a lifetime to save the world and fulfill Ponyo’s dreams of becoming human.',
    1,
    'ponyo.jpg'
  ),
  (
    'howls moving castle',
    '2001-07-19',
    'THE TWO LIVED THERE \n
When Sophie, a shy young woman, is cursed with an old body by a spiteful witch, her only chance of breaking the spell lies with a self-indulgent yet insecure young wizard and his companions in his legged, walking castle.',
    1,
    'howls-moving-castle.jpg'
  ),
  (
    'beetlejuice',
    '1988-06-16',
    'HE’S GUARANTEED TO PUT SOME LIFE IN YOUR AFTERLIFE. \n
Thanks to an untimely demise via drowning, a young couple end up as poltergeists in their New England farmhouse, where they fail to meet the challenge of scaring away the insufferable new owners, who want to make drastic changes. In desperation, the undead newlyweds turn to an expert frightmeister, but he’s got a diabolical agenda of his own. ',
    2,
    'beetlejuice.jpg'
  ),
  (
    'Chocolate Factory',
    '2005-07-22',
    'PREPARE FOR A TASTE OF ADVENTURE. \n
A young boy wins a tour through the most magnificent chocolate factory in the world, led by the world’s most unusual candy maker.',
    2,
    'chocolate-factory.jpg'
  ),
  (
    'Ed Wood',
    '1994-09-28',
    'WHEN IT CAME TO MAKING BAD MOVIES, ED WOOD WAS THE BEST. \n
The mostly true story of the legendary “worst director of all time”, who, with the help of his strange friends, filmed countless B-movies without ever becoming famous or successful. ',
    2,
    'ed-wood.jpg'
  ),
  (
    'Edward Scissorhands',
    '1990-05-24',
    'A small suburban town receives a visit from a castaway unfinished science experiment named Edward.',
    2,
    'edward-scissorhands.jpg'
  ),
  (
    'Frankenweenie',
    '1984-12-14',
    ' THE ELECTRIFYING DOG IS BACK FROM BEYOND THE GRAVE \n
When a car hits young Victor’s pet dog Sparky, Victor decides to bring him back to life the only way he knows how. But when the bolt-necked “monster” wreaks havoc and terror in the hearts of Victor’s neighbors, he has to convince them that Sparky’s still the good, loyal friend he was.',
    2,
    'frankenweenie.jpg'
  ),
  (
    'Pulp Fiction',
    '1995-03-03',
    'JUST BECAUSE YOU ARE A CHARACTER DOESN’T MEAN YOU HAVE CHARACTER. \n
A burger-loving hit man, his philosophical partner, a drug-addled gangster’s moll and a washed-up boxer converge in this sprawling, comedic crime caper. Their adventures unfurl in three stories that ingeniously trip back and forth in time.',
    3,
    'pulpfiction.jpg'
  ),
  (
    'Django',
    '2005-06-21',
    'LIFE, LIBERTY AND THE PURSUIT OF VENGEANCE. \n
With the help of a German bounty hunter, a freed slave sets out to rescue his wife from a brutal Mississippi plantation owner.',
    3,
    'django.jpg'
  ),
  (
    'Kill bill',
    '2003-04-23',
    'A ROARING RAMPAGE OF REVENGE. \n
An assassin is shot by her ruthless employer, Bill, and other members of their assassination circle – but she lives to plot her vengeance.',
    3,
    'kill-bill.jpg'
  ),
  (
    'Kill bill 2',
    '2004-04-08',
    'THE BRIDE IS BACK FOR THE FINAL CUT. \n
The Bride unwaveringly continues on her roaring rampage of revenge against the band of assassins who had tried to kill her and her unborn child. She visits each of her former associates one-by-one, checking off the victims on her Death List Five until there’s nothing left to do … but kill Bill.',
    3,
    'kill-bill-2.jpg'
  ),
  (
    'Modern Times',
    '1936-02-25',
    ' HE STANDS ALONE AS THE GREATEST ENTERTAINER OF MODERN TIMES! NO ONE ON EARTH CAN MAKE YOU LAUGH AS HEARTILY OR TOUCH YOUR HEART AS DEEPLY…THE WHOLE WORLD LAUGHS, CRIES AND THRILLS TO HIS PRICELESS GENIUS! \n
The Tramp struggles to live in modern industrial society with the help of a young homeless woman.',
    4,
    'modern-times.jpg'
  ),
  (
    'The Great Dictator',
    '1942-08-12',
    'Dictator Adenoid Hynkel tries to expand his empire while a poor Jewish barber tries to avoid persecution from Hynkel’s regime. ',
    4,
    'the-great-dictator.jpg'
  );

-- GENEROS
INSERT INTO
  pipocando.genero (nome)
VALUES
  ('animação'),
  ('romance'),
  ('ação'),
  ('comédia'),
  ('drama'),
  ('ficção científica'),
  ('terror'),
  ('aventura'),
  ('fantasia'),
  ('thriller'),
  ('musical'),
  ('mistério'),
  ('crime'),
  ('histórico');

-- FILME GENERO
INSERT INTO
  pipocando.filme_genero (id_filme, id_genero)
VALUES
  (1, 1),
  (1, 8),
  (1, 9),
  (2, 1),
  (2, 8),
  (2, 9),
  (3, 1),
  (3, 8),
  (3, 9),
  (3, 12),
  (4, 1),
  (4, 8),
  (4, 9),
  (5, 1),
  (5, 2),
  (5, 8),
  (5, 9),
  (6, 4),
  (6, 9),
  (6, 11),
  (7, 4),
  (7, 8),
  (7, 9),
  (7, 11),
  (8, 4),
  (8, 5),
  (8, 14),
  (9, 4),
  (9, 5),
  (9, 9),
  (9, 14),
  (10, 1),
  (10, 4),
  (10, 9),
  (10, 10),
  (11, 3),
  (11, 12),
  (11, 13),
  (12, 3),
  (12, 5),
  (12, 10),
  (12, 13),
  (12, 14),
  (13, 3),
  (13, 6),
  (13, 13),
  (14, 3),
  (14, 6),
  (14, 13),
  (15, 4),
  (15, 5),
  (15, 14),
  (16, 4),
  (16, 5),
  (16, 14);

-- ATORES
INSERT INTO
  pipocando.ator (nome)
VALUES
  ('John Travolta'),
  ('Uma Thurman'),
  ('Samuel L. Jackson'),
  ('Bruce Willis'),
  ('Harvey Keitel'),
  ('Jamie Foxx'),
  ('Christoph Waltz'),
  ('Leonardo DiCaprio'),
  ('Kerry Washington'),
  ('Lucy Liu'),
  ('Vivica A. Fox'),
  ('Michael Madsen'),
  ('Daryl Hannah'),
  ('Michael Keaton'),
  ('Alec Baldwin'),
  ('Geena Davis'),
  ('Geena Davis'),
  ('Johnny Depp'),
  ('Freddie Highmore'),
  ('David Kelly'),
  ('Martin Landau'),
  ('Sarah Jessica Parker'),
  ('Dianne Wiest'),
  ('Charlie Tahan'),
  ('Martin Short'),
  ('Chieko Baisho'),
  ('Takuya Kimura'),
  ('Akihiro Miwa'),
  ('Noriko Hidaka'),
  ('Chika Sakamoto'),
  ('Shigesato Itoi'),
  ('Yuria Nara'),
  ('Hiroki Doi'),
  ('Tomoko Yamaguchi'),
  ('Yoji Matsuda'),
  ('Yuriko Ishida'),
  ('Yuko Tanaka'),
  ('Rumi Hiiragi'),
  ('Miyu Irino'),
  ('Mari Natsuki');

-- filmes atores
INSERT INTO
  pipocando.filme_ator (id_ator, id_filme)
VALUES
  (1, 11),
  (2, 11),
  (3, 11),
  (4, 11),
  (5, 11),
  (6, 12),
  (7, 12),
  (8, 12),
  (9, 12),
  (3, 12),
  (2, 13),
  (10, 13),
  (11, 13),
  (12, 13),
  (13, 13),
  (2, 14),
  (10, 14),
  (11, 14),
  (12, 14),
  (13, 14),
  (14, 6),
  (15, 6),
  (16, 6),
  (17, 6),
  (18, 7),
  (19, 7),
  (20, 7),
  (18, 8),
  (21, 8),
  (22, 8),
  (18, 9),
  (17, 9),
  (23, 9),
  (24, 10),
  (17, 10),
  (25, 10),
  (26, 1),
  (27, 1),
  (28, 1),
  (29, 2),
  (30, 2),
  (31, 2),
  (32, 3),
  (33, 3),
  (34, 3),
  (35, 4),
  (36, 4),
  (37, 4),
  (38, 5),
  (39, 5);

-- USUARIOS
INSERT INTO
  pipocando.usuario (nome, email, senha)
VALUES
  ('Usuario Logado', 'stef@email.com', 'japa'),
  ('Taih', 'taih@gmail.com', 'india'),
  ('Hiago', 'hiago@email.com', 'branco'),
  ('João Silva', 'joao.silva@email.com', 'senha123'),
  (
    'Maria Souza',
    'maria.souza@email.com',
    'senha456'
  ),
  (
    'Carlos Oliveira',
    'carlos.oliveira@email.com',
    'senha789'
  ),
  ('Ana Lima', 'ana.lima@email.com', 'senha987'),
  (
    'Fernando Costa',
    'fernando.costa@email.com',
    'senha654'
  ),
  (
    'Amanda Rocha',
    'amanda.rocha@email.com',
    'senha321'
  ),
  (
    'Gabriel Pereira',
    'gabriel.pereira@email.com',
    'senha890'
  ),
  (
    'Carolina Santos',
    'carolina.santos@email.com',
    'senha567'
  ),
  (
    'Lucas Oliveira',
    'lucas.oliveira@email.com',
    'senha234'
  ),
  (
    'Juliana Martins',
    'juliana.martins@email.com',
    'senha901'
  ),
  (
    'Ricardo Sousa',
    'ricardo.sousa@email.com',
    'senha678'
  ),
  (
    'Camila Almeida',
    'camila.almeida@email.com',
    'senha345'
  ),
  (
    'Eduardo Silva',
    'eduardo.silva@email.com',
    'senha012'
  ),
  (
    'Patrícia Lima',
    'patricia.lima@email.com',
    'senha789'
  ),
  (
    'Marcelo Santos',
    'marcelo.santos@email.com',
    'senha456'
  ),
  (
    'Isabela Oliveira',
    'isabela.oliveira@email.com',
    'senha123'
  ),
  (
    'Bruno Costa',
    'bruno.costa@email.com',
    'senha890'
  ),
  (
    'Vanessa Pereira',
    'vanessa.pereira@email.com',
    'senha567'
  );

-- AVALIAÇÕES
INSERT INTO
  pipocando.avaliacao (
    id_usuario,
    id_filme,
    assistido,
    favorito,
    texto,
    nota,
    data_avaliacao
  )
VALUES
  (
    1,
    1,
    1,
    1,
    'Sem plot, sem começo, sem fim, porem perfeito',
    5,
    '2023-11-12'
  ),
  (
    2,
    2,
    1,
    0,
    'bom, porem falta historia',
    3,
    '2023-11-12'
  ),
  (
    3,
    3,
    1,
    1,
    'Muito emocionante, recomendo!',
    4,
    '2023-11-13'
  ),
  (
    4,
    4,
    1,
    1,
    'Ótima atuação dos atores principais',
    5,
    '2023-11-14'
  ),
  (
    5,
    5,
    1,
    0,
    'Interessante, mas poderia ser mais curto',
    3,
    '2023-11-15'
  ),
  (
    6,
    6,
    1,
    1,
    'Incrível, mal posso esperar pela continuação',
    5,
    '2023-11-16'
  ),
  (
    7,
    7,
    0,
    0,
    'Não gostei, enredo confuso',
    2,
    '2023-11-17'
  ),
  (
    8,
    8,
    1,
    1,
    'Surpreendente do início ao fim',
    5,
    '2023-11-18'
  ),
  (
    9,
    9,
    0,
    1,
    'Não assisti ainda, mas parece promissor',
    0,
    '2023-11-18'
  ),
  (
    10,
    10,
    1,
    1,
    'Adorei, especialmente os efeitos especiais',
    4,
    '2023-11-19'
  ),
  (
    11,
    11,
    1,
    0,
    'Bom, mas esperava mais do desfecho',
    3,
    '2023-11-20'
  ),
  (
    12,
    12,
    1,
    1,
    'Um clássico que nunca envelhece',
    5,
    '2023-11-21'
  ),
  (
    13,
    13,
    1,
    0,
    'Achei regular, não me cativou',
    2,
    '2023-11-22'
  ),
  (
    14,
    14,
    1,
    1,
    'Divertido e leve, ótimo para relaxar',
    4,
    '2023-11-23'
  ),
  (
    15,
    15,
    0,
    0,
    'Não assisti, mas ouvi boas recomendações',
    3,
    '2023-11-18'
  ),
  (
    16,
    16,
    1,
    1,
    'Suspense incrível, recomendo a todos',
    5,
    '2023-11-24'
  ),
  (
    1,
    5,
    1,
    1,
    'Intrigante, adorei a reviravolta no final',
    5,
    '2023-11-25'
  ),
  (
    2,
    8,
    1,
    1,
    'Ótima produção, mal posso esperar pelos extras no Blu-ray',
    5,
    '2023-11-26'
  ),
  (
    3,
    11,
    1,
    0,
    'História envolvente, mas alguns personagens são fracos',
    4,
    '2023-11-27'
  ),
  (
    4,
    2,
    1,
    1,
    'Cenas de ação impressionantes',
    5,
    '2023-11-28'
  ),
  (
    5,
    14,
    0,
    0,
    'Não gostei do desenvolvimento da trama',
    2,
    '2023-11-29'
  ),
  (
    6,
    7,
    1,
    1,
    'Excelente trilha sonora, combinou perfeitamente',
    5,
    '2023-11-30'
  ),
  (
    7,
    9,
    0,
    0,
    'Ainda não assisti, mas estou animado',
    0,
    '2023-11-30'
  ),
  (
    8,
    12,
    1,
    1,
    'Clássico atemporal, sempre emocionante',
    5,
    '2023-12-01'
  ),
  (
    9,
    3,
    1,
    0,
    'Faltou originalidade, clichê demais',
    2,
    '2023-12-02'
  ),
  (
    10,
    6,
    1,
    1,
    'Surpreendente, recomendo para todos',
    5,
    '2023-12-03'
  ),
  (
    11,
    16,
    1,
    1,
    'Mistério envolvente, adorei desvendar os segredos',
    4,
    '2023-12-04'
  ),
  (
    12,
    13,
    1,
    0,
    'Regular, não me impactou',
    3,
    '2023-12-05'
  ),
  (
    13,
    10,
    1,
    1,
    'Ação do início ao fim, me manteve colado na tela',
    4,
    '2023-12-06'
  ),
  (
    14,
    1,
    0,
    1,
    'Ainda não assisti, mas ouvi boas críticas',
    0,
    '2023-11-30'
  ),
  (
    15,
    4,
    1,
    0,
    'Bom, mas esperava mais do desfecho',
    3,
    '2023-12-07'
  ),
  (
    16,
    15,
    1,
    1,
    'Comédia leve, perfeito para um dia descontraído',
    4,
    '2023-12-08'
  ),
  (
    17,
    5,
    0,
    0,
    'Não assisti, mas estou curioso',
    0,
    '2023-11-30'
  ),
  (
    18,
    8,
    1,
    1,
    'Muito emocionante, chorei no final',
    5,
    '2023-12-09'
  ),
  (
    19,
    11,
    1,
    1,
    'Surpreendente, não esperava esse desfecho',
    5,
    '2023-12-10'
  ),
  (
    20,
    14,
    0,
    1,
    'Não gostei muito, mas tem seus momentos',
    4,
    '2023-12-11'
  ),
  (
    1,
    3,
    1,
    0,
    'Interessante, mas esperava mais do enredo',
    3,
    '2023-12-12'
  ),
  (
    2,
    6,
    1,
    1,
    'Incrível, recomendo para todos os fãs do gênero',
    5,
    '2023-12-13'
  ),
  (
    3,
    9,
    0,
    0,
    'Não assisti ainda, mas ouvi críticas positivas',
    5,
    '2023-12-13'
  ),
  (
    4,
    12,
    1,
    1,
    'Um dos melhores filmes que já vi, emocionante',
    5,
    '2023-12-14'
  ),
  (
    5,
    15,
    1,
    0,
    'Bom entretenimento, mas o final deixou a desejar',
    3,
    '2023-12-15'
  ),
  (
    6,
    1,
    1,
    1,
    'Adorei, especialmente a atuação do elenco',
    4,
    '2023-12-16'
  ),
  (
    7,
    4,
    1,
    0,
    'História envolvente, mas alguns momentos previsíveis',
    4,
    '2023-12-17'
  ),
  (
    8,
    7,
    0,
    0,
    'Não assisti, mas pretendo em breve',
    0,
    '2023-12-13'
  ),
  (
    9,
    10,
    1,
    1,
    'Surpreendente, não esperava por esse desfecho',
    5,
    '2023-12-18'
  ),
  (
    10,
    13,
    1,
    1,
    'Ação intensa, me manteve grudado na cadeira',
    5,
    '2023-12-19'
  ),
  (
    11,
    16,
    0,
    1,
    'Ainda não assisti, mas estou ansioso',
    4,
    '2023-12-13'
  ),
  (
    12,
    2,
    1,
    1,
    'Um clássico moderno, vale a pena assistir',
    5,
    '2023-12-20'
  ),
  (
    13,
    5,
    1,
    0,
    'Cenas de suspense bem construídas',
    3,
    '2023-12-21'
  ),
  (
    14,
    8,
    1,
    1,
    'História cativante, me fez refletir',
    5,
    '2023-12-22'
  ),
  (
    15,
    11,
    1,
    1,
    'Intrigante, mal posso esperar por uma continuação',
    5,
    '2023-12-23'
  ),
  (
    16,
    14,
    1,
    0,
    'Não gostei muito, esperava mais do roteiro',
    3,
    '2023-12-24'
  ),
  (
    17,
    3,
    0,
    1,
    'Não assisti ainda, mas está na minha lista',
    0,
    '2023-12-13'
  ),
  (
    18,
    6,
    1,
    1,
    'Emocionante, chorei em várias cenas',
    5,
    '2023-12-25'
  ),
  (
    19,
    9,
    1,
    1,
    'Ótimo, especialmente a cinematografia',
    4,
    '2023-12-26'
  ),
  (
    20,
    12,
    1,
    0,
    'Bom, mas algumas partes arrastadas',
    3,
    '2023-12-27'
  ),
  (
    21,
    15,
    1,
    1,
    'Divertido, perfeito para um dia descontraído',
    4,
    '2023-12-28'
  ),
  (
    20,
    1,
    0,
    0,
    'Não gostei, não recomendaria',
    1,
    '2023-12-29'
  ),
  (
    20,
    4,
    1,
    1,
    'Excelente, especialmente para os fãs do gênero',
    5,
    '2023-12-30'
  ),
  (
    4,
    7,
    1,
    0,
    'Gostei, mas esperava mais do final',
    3,
    '2023-12-31'
  ),
  (
    5,
    10,
    1,
    1,
    'Surpreendente, recomendo a todos',
    5,
    '2024-01-01'
  ),
  (
    6,
    13,
    0,
    0,
    'Não assisti ainda, mas ouvi boas críticas',
    0,
    '2023-12-13'
  ),
  (
    2,
    16,
    1,
    1,
    'Intrigante, me deixou pensando por dias',
    4,
    '2024-01-02'
  ),
  (
    8,
    2,
    1,
    1,
    'Um clássico moderno, não canso de assistir',
    5,
    '2024-01-03'
  ),
  (
    9,
    5,
    1,
    0,
    'Bom, mas o final deixou a desejar',
    3,
    '2024-01-04'
  ),
  (
    10,
    8,
    1,
    1,
    'História emocionante, me fez chorar',
    4,
    '2024-01-05'
  ),
  (
    11,
    11,
    1,
    1,
    'Ação intensa, adorei as cenas de luta',
    5,
    '2024-01-06'
  ),
  (
    12,
    14,
    0,
    1,
    'Não assisti ainda, mas estou ansioso',
    0,
    '2023-12-13'
  ),
  (
    8,
    3,
    1,
    1,
    'Interessante, especialmente para os fãs do gênero',
    4,
    '2024-01-07'
  ),
  (
    3,
    6,
    1,
    0,
    'Incrível, mas algumas partes são previsíveis',
    4,
    '2024-01-08'
  ),
  (
    5,
    9,
    0,
    0,
    'Ainda não assisti, mas ouvi críticas positivas',
    0,
    '2023-12-13'
  ),
  (
    3,
    12,
    1,
    1,
    'Um dos melhores filmes que já vi, recomendo',
    5,
    '2024-01-09'
  ),
  (
    7,
    15,
    1,
    0,
    'Divertido, mas poderia ser mais curto',
    3,
    '2024-01-10'
  ),
  (
    8,
    1,
    1,
    1,
    'Adorei, especialmente a trilha sonora',
    4,
    '2024-01-11'
  ),
  (
    19,
    4,
    0,
    0,
    'Não gostei, não me prendeu a atenção',
    2,
    '2024-01-12'
  ),
  (
    20,
    7,
    1,
    0,
    'Ainda não assisti, mas estou curioso',
    0,
    '2023-12-13'
  ),
  (
    21,
    10,
    1,
    1,
    'Surpreendente, mal posso esperar pela continuação',
    5,
    '2024-01-13'
  ),
  (
    12,
    13,
    1,
    1,
    'Ação eletrizante, recomendo para os fãs do gênero',
    4,
    '2024-01-14'
  ),
  (
    13,
    16,
    0,
    1,
    'Não assisti ainda, mas estou ansioso',
    0,
    '2023-12-13'
  ),
  (
    14,
    2,
    1,
    1,
    'Emocionante, especialmente o desenvolvimento dos personagens',
    5,
    '2024-01-15'
  ),
  (
    4,
    5,
    1,
    0,
    'Bom, mas algumas cenas são previsíveis',
    3,
    '2024-01-16'
  ),
  (
    16,
    8,
    1,
    1,
    'História envolvente, me manteve grudado na tela',
    4,
    '2024-01-17'
  ),
  (
    17,
    11,
    1,
    1,
    'Intrigante, mal posso esperar por uma continuação',
    5,
    '2024-01-18'
  ),
  (
    8,
    14,
    0,
    0,
    'Não gostei muito, esperava mais do roteiro',
    2,
    '2024-01-19'
  ),
  (
    19,
    3,
    0,
    1,
    'Não assisti ainda, mas está na minha lista',
    0,
    '2023-12-13'
  ),
  (
    20,
    6,
    1,
    1,
    'Emocionante, recomendo para todos',
    5,
    '2024-01-20'
  );

-- COMENTARIOS NA AVALIAÇÃO
INSERT INTO
  pipocando.comentario_avaliacao (
    id_avaliacao,
    id_usuario,
    texto,
    data_comentario
  )
VALUES
  (
    1,
    2,
    'faco das suas palavras as minhas',
    '2023-11-12'
  ),
  (2, 3, 'querida, vc esta loka?', '2023-11-12'),
  (
    3,
    4,
    'Concordo plenamente, a trama deixou a desejar',
    '2023-11-13'
  ),
  (
    4,
    5,
    'Achei as atuações medianas, esperava mais',
    '2023-11-14'
  ),
  (
    5,
    6,
    'Você captou exatamente o que eu pensei!',
    '2023-11-15'
  ),
  (
    6,
    7,
    'Eu discordo, a história é envolvente do início ao fim',
    '2023-11-16'
  ),
  (
    7,
    8,
    'Mal posso esperar para assistir, obrigado pela recomendação',
    '2023-11-17'
  ),
  (
    8,
    9,
    'Achei o final surpreendente, não vi isso chegando',
    '2023-11-18'
  ),
  (
    9,
    10,
    'O filme ainda não foi lançado por aqui, estou ansioso para assistir',
    '2023-11-19'
  ),
  (
    10,
    11,
    'Completamente decepcionado, não recomendaria',
    '2023-11-20'
  ),
  (
    11,
    12,
    'Eu amei cada minuto, especialmente a reviravolta no final',
    '2023-11-21'
  ),
  (
    12,
    13,
    'A trama é um pouco previsível, mas ainda assim gostei',
    '2023-11-22'
  ),
  (
    13,
    14,
    'Parece interessante, vou colocar na minha lista para assistir',
    '2023-11-23'
  ),
  (
    14,
    15,
    'O filme me fez rir do começo ao fim, recomendo para todos',
    '2023-11-24'
  ),
  (
    15,
    16,
    'Ainda não assisti, mas estou curioso para ver como é',
    '2023-11-25'
  ),
  (
    16,
    1,
    'Concordo, a história é um pouco confusa em alguns momentos',
    '2023-11-26'
  ),
  (
    17,
    2,
    'Eu não gostei muito, achei a trama fraca',
    '2023-11-27'
  ),
  (
    18,
    3,
    'As cenas de ação foram incríveis, mal posso esperar pelo próximo filme',
    '2023-11-28'
  ),
  (
    19,
    4,
    'Ainda não assisti, mas estou ansioso para ver',
    '2023-11-29'
  ),
  (
    20,
    5,
    'Eu discordo, achei o filme incrível do começo ao fim',
    '2023-11-30'
  ),
  (
    21,
    6,
    'Eu ainda não vi, mas sua análise me deixou animado para assistir',
    '2023-12-01'
  ),
  (
    22,
    9,
    'Achei a narrativa um pouco confusa, mas as atuações são impressionantes',
    '2023-12-02'
  ),
  (
    23,
    12,
    'Concordo com você, a reviravolta no final foi surpreendente',
    '2023-12-03'
  ),
  (
    24,
    15,
    'Não concordo, a trama foi bem construída e os personagens foram cativantes',
    '2023-12-04'
  ),
  (
    25,
    2,
    'Eu ainda não assisti, mas sua análise me deixou curioso',
    '2023-12-05'
  ),
  (
    26,
    5,
    'O final me deixou perplexo, não esperava por aquela reviravolta',
    '2023-12-06'
  ),
  (
    27,
    8,
    'Gostei da sua análise, pretendo assistir em breve',
    '2023-12-07'
  ),
  (
    28,
    11,
    'Eu também achei o filme um pouco longo, mas vale a pena',
    '2023-12-08'
  ),
  (
    29,
    14,
    'A trama é intrigante, mas algumas cenas são previsíveis',
    '2023-12-09'
  ),
  (
    30,
    1,
    'Estou ansioso para assistir, espero que seja tão bom quanto você descreveu',
    '2023-12-10'
  ),
  (
    31,
    4,
    'As cenas de ação foram emocionantes, especialmente aquela perseguição',
    '2023-12-11'
  ),
  (
    32,
    7,
    'Eu ainda não vi, mas sua análise me deixou animado para assistir',
    '2023-12-12'
  ),
  (
    33,
    10,
    'Concordo plenamente, a trama deixou a desejar',
    '2023-12-13'
  ),
  (
    34,
    13,
    'Achei as atuações medianas, esperava mais',
    '2023-12-14'
  ),
  (
    35,
    16,
    'Você captou exatamente o que eu pensei!',
    '2023-12-15'
  ),
  (
    36,
    3,
    'Eu discordo, a história é envolvente do início ao fim',
    '2023-12-16'
  ),
  (
    37,
    6,
    'Mal posso esperar para assistir, obrigado pela recomendação',
    '2023-12-17'
  ),
  (
    38,
    9,
    'Achei o final surpreendente, não vi isso chegando',
    '2023-12-18'
  ),
  (
    39,
    12,
    'O filme ainda não foi lançado por aqui, estou ansioso para assistir',
    '2023-12-19'
  ),
  (
    40,
    15,
    'Completamente decepcionado, não recomendaria',
    '2023-12-20'
  ),
  (
    41,
    2,
    'Eu amei cada minuto, especialmente a reviravolta no final',
    '2023-12-21'
  ),
  (
    42,
    5,
    'A trama é um pouco previsível, mas ainda assim gostei',
    '2023-12-22'
  ),
  (
    43,
    8,
    'Parece interessante, vou colocar na minha lista para assistir',
    '2023-12-23'
  ),
  (
    44,
    11,
    'O filme me fez rir do começo ao fim, recomendo para todos',
    '2023-12-24'
  ),
  (
    45,
    14,
    'Ainda não assisti, mas estou curioso para ver como é',
    '2023-12-25'
  ),
  (
    46,
    1,
    'Concordo, a história é um pouco confusa em alguns momentos',
    '2023-12-26'
  ),
  (
    47,
    4,
    'Eu não gostei muito, achei a trama fraca',
    '2023-12-27'
  ),
  (
    48,
    7,
    'As cenas de ação foram incríveis, mal posso esperar pelo próximo filme',
    '2023-12-28'
  ),
  (
    49,
    10,
    'Ainda não assisti, mas estou ansioso para ver',
    '2023-12-29'
  ),
  (
    50,
    13,
    'Eu discordo, achei o filme incrível do começo ao fim',
    '2023-12-30'
  );

-- CURTIDA AVALIACAO
INSERT INTO
  pipocando.curtida_avaliacao (id_avaliacao, id_usuario)
VALUES
  (1, 1),
  (2, 3),
  (3, 5),
  (4, 7),
  (5, 9),
  (6, 11),
  (7, 13),
  (8, 15),
  (9, 2),
  (10, 4),
  (11, 6),
  (12, 8),
  (13, 10),
  (14, 12),
  (15, 14),
  (16, 16),
  (17, 1),
  (18, 3),
  (19, 5),
  (20, 7),
  (21, 9),
  (22, 11),
  (23, 13),
  (24, 15),
  (25, 2),
  (26, 4),
  (27, 6),
  (28, 8),
  (29, 10),
  (30, 12),
  (31, 14),
  (32, 16),
  (33, 1),
  (34, 3),
  (35, 5),
  (36, 7),
  (37, 9),
  (38, 11),
  (39, 13),
  (40, 15),
  (41, 2),
  (42, 4),
  (43, 6),
  (44, 8),
  (45, 10),
  (46, 12),
  (47, 14),
  (48, 16),
  (49, 1),
  (50, 3);

SELECT
  filme.*,
  diretor.nome as nome_diretor,
  AVG(avaliacao.nota) AS media_nota,
  MIN(avaliacao.nota) AS menor_nota,
  MAX(avaliacao.nota) AS maior_nota
FROM
  filme
  LEFT JOIN avaliacao ON filme.id = avaliacao.id_filme
  INNER JOIN diretor ON diretor.id = filme.id_diretor
WHERE
  filme.id = 1
GROUP BY
  filme.id,
  filme.nome,
  filme.ano_lancamento,
  filme.sinopse,
  filme.id_diretor,
  filme.banner,
  nome_diretor
SELECT
  filme.*
FROM
  filme
  LEFT JOIN avaliacao ON filme.id = avaliacao.id_filme
GROUP BY
  filme.id,
  filme.nome,
  filme.ano_lancamento,
  filme.sinopse,
  filme.id_diretor,
  filme.banner
HAVING
  AVG(avaliacao.nota) >= 4;

SELECT
  *
FROM
  filme
ORDER BY
  ano_lancamento ASC