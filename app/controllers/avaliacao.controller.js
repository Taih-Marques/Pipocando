const Avaliacao = require("../models/avaliacao.model.js");
const Auth = require("../models/auth.js");

exports.salvarTextoAvaliacao = (req, res) => {
  // Validar requisição
  if (!req.body) {
    res.status(400).send({
      message: "Conteúdo não pode ser vazio!",
    });
  }

  const id_usuario = Auth.getIdUsuarioLogado();

  Avaliacao.buscarPorUsuarioEFilme(
    id_usuario,
    req.body.id_filme,
    (err, avaliacaoDb) => {
      if (err) {
        res.status(500).send({
          message: err.message || "Erro ao buscar avaliação.",
        });
      } else {
        let avaliacao = avaliacaoDb;
        if (avaliacaoDb) {
          console.log("avaliacao encontrada");
          avaliacao.texto = req.body.texto;
          avaliacao.nota = req.body.nota;
          Avaliacao.editar(
            avaliacaoDb.id,
            avaliacao,
            (err, avaliacaoEditada) => {
              res.redirect("/filmes/" + req.body.id_filme);
            }
          );
        } else {
          avaliacao = new Avaliacao({
            id_usuario: id_usuario,
            id_filme: req.body.id_filme,
            assistido: true,
            favorito: false,
            texto: req.body.texto,
            nota: req.body.nota,
            data_avaliacao: new Date(),
          });
          console.log("criando avaliacao", avaliacao);
          Avaliacao.criar(avaliacao, (err, avaliacaoCriada) => {
            if (err) {
              res.status(500).send({
                message: err.message || "Erro ao criar avaliação.",
              });
            } else {
              res.status(200);
            }
          });
        }
      }
    }
  );
};

exports.excluirAvaliacao = (req, res) => {
  // Validar requisição
  if (!req.body) {
    res.status(400).send({
      message: "Conteúdo não pode ser vazio!",
    });
  }

  const id_usuario = Auth.getIdUsuarioLogado();

  Avaliacao.removerAvaliacao(req.body.id_filme, id_usuario, (err) => {
    if (err) {
      res.status(500).send({
        message: err.message || "Erro ao excluir avaliação.",
      });
    } else {
      res.status(200);
    }
  });
};
