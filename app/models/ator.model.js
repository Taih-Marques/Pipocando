const sql = require("./db.js");

// constructor
const Ator = function (ator) {
  this.id = ator.id;
  this.nome = ator.nome;
};

Ator.buscaPorIdFilme = (id_filme, callback) => {
  sql.query(
    `SELECT ator.* 
      FROM filme_ator
      INNER JOIN ator ON filme_ator.id_ator = ator.id
      WHERE filme_ator.id_filme = ${id_filme}`,
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

module.exports = Ator;
