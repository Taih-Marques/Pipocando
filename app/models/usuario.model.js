const sql = require("./db.js");

// constructor
const Usuario = function (usuario) {
  this.id = usuario.id;
  this.nome = usuario.nome;
  this.email = usuario.email;
  this.senha = usuario.senha;
};

Usuario.criar = (usuario, callback) => {
  sql.query("INSERT INTO usuario (nome, email, senha) VALUES (?, ?, ?)", [usuario.nome, usuario.email, usuario.senha], (err, res) => {
    if (err) {
      console.log("erro: ", err);
      callback(err, null);
      return;
    }

    console.log("Usuario criado: ", { id: res.insertId, ...usuario });
    callback(null, { id: res.insertId, ...usuario });
  });
};

Usuario.buscaPorId = (id, callback) => {
  sql.query(`SELECT * FROM usuario WHERE id = ${id}`, (err, res) => {
    if (err) {
      console.log("erro: ", err);
      callback(err, null);
      return;
    }

    if (res.length) {
      console.log("usuario encontrado: ", res[0]);
      callback(null, res[0]);
      return;
    }
    // not found Tutorial with the id
    callback({ codigo: 404 }, null);
  });
};

module.exports = Usuario;