const sql = require("./db.js");

// constructor
const Filme = function (filme) {
  this.id = filme.id;
  this.nome = filme.nome;
  this.sinopse = filme.sinopse;
  this.ano_lancamento = filme.ano_lancamento;
  this.id_diretor = filme.id_diretor;
  this.banner = filme.banner;
  this.generos = filme.generos;
};

Filme.criar = (filme, callback) => {
  sql.query(
    "INSERT INTO filme (nome, sinopse, ano_lancamento, id_diretor, banner) VALUES (?, ?, ?, ?, ?)",
    [
      filme.nome,
      filme.sinopse,
      filme.ano_lancamento,
      filme.id_diretor,
      filme.banner,
    ],
    (err, res) => {
      if (err) {
        console.log("erro: ", err);
        callback(err, null);
        return;
      }

      const filmeCriado = { id: res.insertId, ...filme };

      // console.log("Filme criado: ", filmeCriado);
      callback(null, filmeCriado);
    }
  );
};

Filme.buscarPorId = (id, callback) => {
  sql.query(
    `SELECT filme.*, diretor.nome as nome_diretor,
       TRUNCATE(SUM(avaliacao.nota)/COUNT(avaliacao.nota), 1) AS media_nota,
        MIN(avaliacao.nota) AS menor_nota,
        MAX(avaliacao.nota) AS maior_nota
      FROM filme
      LEFT JOIN avaliacao ON filme.id = avaliacao.id_filme
      INNER JOIN diretor ON diretor.id = filme.id_diretor
      WHERE filme.id = ${id}
      GROUP BY filme.id, filme.nome, filme.ano_lancamento, filme.sinopse, filme.id_diretor, filme.banner, nome_diretor`,
    (err, res) => {
      if (err) {
        console.log("erro: ", err);
        callback(err, null);
        return;
      }

      if (res.length) {
        // console.log("Filme encontrado: ", res[0]);
        callback(null, res[0]);
        return;
      }

      // not found Tutorial with the id
      callback({ codigo: 404 }, null);
    }
  );
};

Filme.buscar = (texto, callback) => {
  let query = `SELECT DISTINCT filme.* FROM filme `;

  if (texto) {
    query += `INNER JOIN diretor ON diretor.id = filme.id_diretor
              LEFT JOIN filme_ator ON filme_ator.id_filme = filme.id
              INNER JOIN ator ON filme_ator.id_ator = ator.id
              LEFT JOIN filme_genero ON filme_genero.id_filme = filme.id
              INNER JOIN genero ON filme_genero.id_genero = genero.id
            WHERE filme.nome LIKE '%${texto}%' 
              OR diretor.nome LIKE '%${texto}%'
              OR ator.nome LIKE '%${texto}%'
              OR genero.nome LIKE '%${texto}%'`;
  }

  query += " ORDER BY filme.ano_lancamento DESC";

  sql.query(query, (err, res) => {
    if (err) {
      console.log("erro: ", err);
      callback(null, err);
      return;
    }

    // console.log("filmes: ", res);
    callback(null, res || []);
  });
};

Filme.buscarFilmeComNotaMedia = (notaMedia, callback) => {
  sql.query(
    `SELECT filme.*       
    FROM filme
    LEFT JOIN avaliacao ON filme.id = avaliacao.id_filme
    GROUP BY filme.id, filme.nome, filme.ano_lancamento, filme.sinopse, filme.id_diretor, filme.banner
    HAVING AVG(avaliacao.nota) >= ${notaMedia}`,
    (err, res) => {
      if (err) {
        console.log("erro: ", err);
        callback(err, null);
        return;
      }
      callback(null, res);
    }
  );
};

Filme.somarAvaliacoesPorFilme = (callback) => {
  sql.query(
    `SELECT filme.* 
        SUM(avaliacao.nota) AS soma_notas
    FROM filme
    RIGHT JOIN avaliacao ON filme.id = avaliacao.id_filme
    GROUP BY filme.id, filme.nome, filme.ano_lancamento, filme.sinopse, filme.id_diretor, filme.banner `,
    (err, res) => {
      if (err) {
        console.log("erro: ", err);
        callback(err, null);
        return;
      }

      callback(null, res);
    }
  );
};

module.exports = Filme;
