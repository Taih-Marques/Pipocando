const sql = require("./db.js");

// constructor
const Ator = function (ator) {
  this.id = ator.id;
  this.nome = ator.nome;
};

Ator.criar = (ator, callback) => {
  sql.query("INSERT INTO ator (nome) VALUES (?)", [ator.nome], (err, res) => {
    if (err) {
      console.log("erro: ", err);
      callback(err, null);
      return;
    }

    console.log("Ator criado: ", { id: res.insertId, ...ator });
    callback(null, { id: res.insertId, ...ator });
  });
};

Ator.buscaPorId = (id, callback) => {
  sql.query(`SELECT * FROM ator WHERE id = ${id}`, (err, res) => {
    if (err) {
      console.log("erro: ", err);
      callback(err, null);
      return;
    }

    if (res.length) {
      console.log("ator encontrado: ", res[0]);
      callback(null, res[0]);
      return;
    }
    // not found Tutorial with the id
    callback({ codigo: 404 }, null);
  });
};

module.exports = Ator;