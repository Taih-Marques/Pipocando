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

INSERT INTO
  diretor (nome)
VALUES
  ('Hayao Miyazaki');

INSERT INTO
  filme (
    nome,
    ano_lancamento,
    sinopse,
    id_diretor,
    banner
  )
VALUES
  ('Meu vizinho totoro', '1988-04-16', '', 1, ''),
  ('Spirited away', '2001-07-20', '', 1, ''),
  ('Princess Mononoke', '1997-07-12', '', 1, ''),
  ('Ponyo', '2008-07-19', '', 1, ''),
  ('howls moving castle', '2001-07-19', '', 1, '');

-- USUARIOS
INSERT INTO
  pipocando.usuario (nome, email, senha)
VALUES
  ('Stefani', 'stef@sushi.com', 'japa'),
  ('Taih', 'taih@sushi.com', 'india'),
  ('Hiago', 'hiago@sushi.com', 'branco');

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
  (1, 2, 1, 0, NULL, NULL, '2023-11-12');

-- COMENTARIOS NA AVALIAÇÃO
INSERT INTO
  pipocando.comentario_avaliacao (
    id,
    id_avaliacao,
    id_usuario,
    texto,
    data_comentario
  )
VALUES
  (
    1,
    1,
    2,
    'faco das suas palavras as minhas',
    '2023-11-12'
  ),
  (2, 2, 3, 'querida, vc esta loka?', '2023-11-12');