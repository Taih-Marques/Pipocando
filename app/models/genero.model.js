const sql = require("./db.js");

// constructor
const Genero = function (genero) {
  this.id = genero.id;
  this.nome = genero.nome;
};

Genero.criar = (genero, callback) => {
  sql.query(
    "INSERT INTO genero (nome) VALUES (?)",
    [genero.nome],
    (err, res) => {
      if (err) {
        console.log("erro: ", err);
        callback(err, null);
        return;
      }

      // console.log("Genero criado: ", { id: res.insertId, ...genero });
      callback(null, { id: res.insertId, ...genero });
    }
  );
};

Genero.buscaPorIdFilme = (id_filme, callback) => {
  sql.query(
    `SELECT genero.nome 
            FROM filme_genero 
            INNER JOIN genero ON genero.id = filme_genero.id_genero
            WHERE id_filme = ${id_filme}`,

    (err, res) => {
      if (err) {
        console.log("erro: ", err);
        callback(err, null);
        return;
      }
      callback(null, res || []);
    }
  );
};

module.exports = Genero;
