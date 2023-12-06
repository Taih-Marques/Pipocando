const sql = require("./db.js");

// constructor
const Genero = function (genero) {
  this.id = genero.id;
  this.nome = genero.nome;
};

Genero.buscaPorIdFilme = (id_filme, callback) => {
  sql.query(
    `SELECT genero.* 
      FROM genero 
      RIGHT JOIN filme_genero ON filme_genero.id_genero = genero.id
      WHERE filme_genero.id_filme = ${id_filme}`,

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
