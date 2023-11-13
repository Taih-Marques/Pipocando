const sql = require("./db.js");

// constructor
const Genero = function (genero) {
  this.id = genero.id;
  this.nome = genero.nome;
};

Genero.criar = (genero, callback) => {
  sql.query("INSERT INTO genero (nome) VALUES (?)", [genero.nome], (err, res) => {
    if (err) {
      console.log("erro: ", err);
      callback(err, null);
      return;
    }

    console.log("Genero criado: ", { id: res.insertId, ...genero });
    callback(null, { id: res.insertId, ...genero });
  });
};

Genero.buscaPorId = (id, callback) => {
  sql.query(`SELECT * FROM genero WHERE id = ${id}`, (err, res) => {
    if (err) {
      console.log("erro: ", err);
      callback(err, null);
      return;
    }

    if (res.length) {
      console.log("genero encontrado: ", res[0]);
      callback(null, res[0]);
      return;
    }
    // not found Tutorial with the id
    callback({ codigo: 404 }, null);
  });
};

module.exports = Genero;