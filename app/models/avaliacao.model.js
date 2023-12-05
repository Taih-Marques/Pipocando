const sql = require("./db.js");

// constructor
const Avaliacao = function (avaliacao) {
  this.id = avaliacao.id;
  this.id_usuario = avaliacao.id_usuario;
  this.id_filme = avaliacao.id_filme;
  this.assistido = avaliacao.assistido;
  this.favorito = avaliacao.favorito;
  this.texto = avaliacao.texto;
  this.nota = avaliacao.nota;
  this.data_avaliacao = avaliacao.data_avaliacao;
  this.comentarios = avaliacao.comentarios;
};

Avaliacao.criar = (avaliacao, callback) => {
  sql.query(
    `INSERT INTO avaliacao
    (id_usuario, id_filme, assistido, favorito, texto, nota, data_avaliacao)
    VALUES (?, ?, ?, ?, ?, ?, ?)`,
    [
      avaliacao.id_usuario,
      avaliacao.id_filme,
      avaliacao.assistido,
      avaliacao.favorito,
      avaliacao.texto,
      avaliacao.nota,
      avaliacao.data_avaliacao,
    ],
    (err, res) => {
      if (err) {
        console.log("erro: ", err);
        callback(err, null);
        return;
      }

      const avaliacaoCriada = { id: res.insertId, ...avaliacao };

      // console.log("Avalição criada: ", avaliacaoCriada);
      callback(null, avaliacaoCriada);
    }
  );
};

Avaliacao.editarAssistido = (id_avaliacao, novoValor, callback) => {
  sql.query(
    "UPDATE avaliacao SET assistido = ? WHERE id = ?",
    [novoValor, id_avaliacao],
    (err, res) => {
      if (err) {
        console.log("erro: ", err);
        callback(null, err);
        return;
      }

      if (res.affectedRows == 0) {
        callback({ codigo: 404 }, null);
        return;
      }

      // console.log("Atualizando filme assistido: ", { id: id, ...avaliacao });
      callback(null, { id: id, ...avaliacao });
    }
  );
};

Avaliacao.editarFavorito = (id_avaliacao, novoValor, callback) => {
  sql.query(
    "UPDATE avaliacao SET favorito = ? WHERE id = ?",
    [novoValor, id_avaliacao],
    (err, res) => {
      if (err) {
        console.log("erro: ", err);
        callback(null, err);
        return;
      }

      if (res.affectedRows == 0) {
        callback({ codigo: 404 }, null);
        return;
      }

      // console.log("Atualizando filme favorito: ", { id: id, ...avaliacao });
      callback(null, { id: id, ...avaliacao });
    }
  );
};

Avaliacao.editar = (id, avaliacao, callback) => {
  sql.query(
    "UPDATE avaliacao SET texto = ?, nota = ? WHERE id = ?",
    [avaliacao.texto, avaliacao.nota, id],
    (err, res) => {
      if (err) {
        console.log("erro: ", err);
        callback(null, err);
        return;
      }

      if (res.affectedRows == 0) {
        // nao foi encontrado a avaliação pelo id
        callback({ codigo: 404 }, null);
        return;
      }

      // console.log("Atualizando avaliação: ", { id: id, ...avaliacao });
      callback(null, { id: id, ...avaliacao });
    }
  );
};

Avaliacao.removerAvaliacao = (id, callback) => {
  sql.query("DELETE FROM avaliacao WHERE id = ?", id, (err, res) => {
    if (err) {
      console.log("erro: ", err);
      callback(null, err);
      return;
    }

    if (res.affectedRows == 0) {
      callback({ codigo: 404 }, null);
      return;
    }

    console.log("deletada a avaliação com o id: ", id);
    callback(null, res);
  });
};

Avaliacao.curtirAvaliacao = (id_avaliacao, id_usuario, callback) => {
  sql.query(
    "INSERT INTO curtida_avaliacao (id_avaliacao, id_usuario) VALUES (?, ?)",
    [id_avaliacao, id_usuario],
    (err, res) => {
      if (err) {
        console.log("erro: ", err);
        callback(err, null);
        return;
      }

      const curtida = { id: res.insertId, ...avaliacao };

      // console.log("Avalição curtida: ", curtida);
      callback(null, curtida);
    }
  );
};

Avaliacao.removerCurtidaAvaliacao = (id_avaliacao, id_usuario, callback) => {
  sql.query(
    "DELETE FROM curtida_avaliacao WHERE id_avaliacao = ? AND id_usuario = ?",
    [id_avaliacao, id_usuario],
    (err, res) => {
      if (err) {
        console.log("erro: ", err);
        callback(null, err);
        return;
      }

      if (res.affectedRows == 0) {
        callback({ codigo: 404 }, null);
        return;
      }

      console.log("deletada a curtida na avaliação com o id: ", id);
      callback(null, res);
    }
  );
};

Avaliacao.removerComentarioAvaliacao = (id, callback) => {
  sql.query("DELETE FROM comentario_avaliacao WHERE id = ?", id, (err, res) => {
    if (err) {
      console.log("erro: ", err);
      callback(null, err);
      return;
    }

    if (res.affectedRows == 0) {
      callback({ codigo: 404 }, null);
      return;
    }

    console.log("deletada o comentario da avaliação com o id: ", id);
    callback(null, res);
  });
};

Avaliacao.buscarAvaliacoes = (id_filme, callback) => {
  sql.query(
    `SELECT
          avaliacao.id, 
          avaliacao.id_usuario, 
          avaliacao.texto, 
          avaliacao.nota, 
          avaliacao.data_avaliacao, 
          usuario.nome AS nome_usuario, 
          COUNT(curtida_avaliacao.id_usuario) AS curtidas
    FROM avaliacao 
    LEFT JOIN curtida_avaliacao ON curtida_avaliacao.id_avaliacao = avaliacao.id
    INNER JOIN usuario ON avaliacao.id_usuario = usuario.id
    WHERE id_filme = ${id_filme} AND texto IS NOT NULL 
    GROUP BY avaliacao.id, 
      avaliacao.id_usuario,
      avaliacao.texto,
      avaliacao.nota,
      avaliacao.data_avaliacao,
      usuario.nome`,
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
Avaliacao.buscarPorUsuarioEFilme = (id_usuario, id_filme, callback) => {
  sql.query(
    `SELECT id, id_usuario, id_filme, assistido, favorito, texto, nota, data_avaliacao
    FROM avaliacao 
    WHERE id_filme = ${id_filme} AND id_usuario = ${id_usuario}`,
    (err, res) => {
      if (err) {
        console.log("erro: ", err);
        callback(err, null);
        return;
      }
      // console.log(res);
      callback(null, res.length > 0 ? res[0] : null);
    }
  );
};
Avaliacao.buscarComentarios = (ids_avaliacoes, callback) => {
  if (!ids_avaliacoes || ids_avaliacoes.length === 0) {
    callback(null, []);
    return;
  }
  sql.query(
    `SELECT com.id_avaliacao,
            com.id_usuario,
            user.nome as nome_usuario,
            com.texto,
            com.data_comentario
      FROM comentario_avaliacao com 
        INNER JOIN usuario user ON com.id_usuario = user.id
        WHERE com.id_avaliacao IN (${ids_avaliacoes.join(", ")})
        ORDER BY com.data_comentario DESC`,
    (err, res) => {
      if (err) {
        console.log("erro: ", err);
        callback(err, null);
        return;
      }
      // console.log(res);
      callback(null, res);
    }
  );
};

module.exports = Avaliacao;
