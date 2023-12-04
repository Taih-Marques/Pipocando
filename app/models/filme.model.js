const sql = require("./db.js");

// constructor
const Filme = function (filme) {
  this.id = filme.id;
  this.nome = filme.nome;
  this.sinopse = filme.sinopse;
  this.ano_lancamento = filme.ano_lancamento;
  this.id_diretor = filme.id_diretor;
  this.banner = filme.banner;
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
    `SELECT filme.*, diretor.nome as nome_diretor
          FROM filme
          INNER JOIN diretor ON diretor.id = filme.id_diretor
          WHERE filme.id = ${id}`,
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
  let query = "SELECT * FROM filme";

  if (texto) {
    query += ` WHERE nome LIKE '%${texto}%'`;
  }

  sql.query(query, (err, res) => {
    if (err) {
      console.log("erro: ", err);
      callback(null, err);
      return;
    }

    // console.log("filmes: ", res);
    callback(null, res);
  });
};

module.exports = Filme;
