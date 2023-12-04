const sql = require("./db.js");

// constructor
const Diretor = function (diretor) {
  this.id = diretor.id;
  this.nome = diretor.nome;
};

Diretor.criar = (diretor, callback) => {
  sql.query(
    "INSERT INTO diretor (nome) VALUES (?)",
    [diretor.nome],
    (err, res) => {
      if (err) {
        console.log("erro: ", err);
        callback(err, null);
        return;
      }

      // console.log("Diretor criado: ", { id: res.insertId, ...diretor });
      callback(null, { id: res.insertId, ...diretor });
    }
  );
};

Diretor.buscaPorId = (id, callback) => {
  sql.query(`SELECT * FROM diretor WHERE id = ${id}`, (err, res) => {
    if (err) {
      console.log("erro: ", err);
      callback(err, null);
      return;
    }

    if (res.length) {
      console.log("diretor encontrado: ", res[0]);
      callback(null, res[0]);
      return;
    }
    // not found Tutorial with the id
    callback({ codigo: 404 }, null);
  });
};

module.exports = Diretor;
