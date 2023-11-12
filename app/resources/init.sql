use pipocando;

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
  FOREIGN KEY (id_diretor) REFERENCES diretor(id)
);

CREATE TABLE filme_ator(
  id_ator int(11) NOT NULL,
  id_filme int(11) NOT NULL,
  FOREIGN KEY (id_ator) REFERENCES ator(id),
  FOREIGN KEY (id_filme) REFERENCES filme(id)
);

CREATE TABLE filme_genero(
  id_filme int(11) NOT NULL,
  id_genero int(11) NOT NULL,
  FOREIGN KEY (id_filme) REFERENCES filme(id),
  FOREIGN KEY (id_genero) REFERENCES genero(id)
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
  FOREIGN KEY (id_usuario) REFERENCES usuario(id),
  FOREIGN KEY (id_filme) REFERENCES filme(id)
);

CREATE TABLE comentario_avaliacao(
  id_avaliacao int(11) NOT NULL,
  id_usuario int(11) NOT NULL,
  texto text NOT NULL,
  data_comentario datetime NOT NULL,
  FOREIGN KEY (id_avaliacao) REFERENCES avaliacao(id),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

CREATE TABLE curtida_avaliacao(
  id_avaliacao int(11) NOT NULL,
  id_usuario int(11) NOT NULL,
  FOREIGN KEY (id_avaliacao) REFERENCES avaliacao(id),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id)
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
  ('Meu vizinho totoro', '1988-04-16', '', 1, '');

SELECT
  *
FROM
  filme
ORDER BY
  id_diretor;

SELECT
  MIN(nota) AS SmallestPrice
FROM
  avaliacao;

SELECT
  MAX(nota) AS LargestPrice
FROM
  avaliacao;