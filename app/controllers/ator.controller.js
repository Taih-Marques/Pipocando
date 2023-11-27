const Ator = require("../models/ator.model.js");

exports.criar = (req, res) => {
    // validar requisição
    if (!req.body) {
        res.status(400).send({
            message: "Conteúdo não pode ser vazio"
        });
    }

    // criar ator
    const Ator = new Ator({
        nome: req.body.nome
    });

    Ator.criar(Ator, (err, data) => {
        if (err)
            res.status(500).send({
                message:
                    err.message || "Erro ao tentar criar diretor."
            });
        else res.send(data);
    });
};

exports.buscarPorId = (req, res) => {
    Ator.buscarPorId(req.params.id, (err, data) => {
        if (err) {
            if (err.codigo === 404) {
                res.status(404).send({
                    message: `Não encontrado ator com o id:${req.params.id}.`
                });
            } else {
                res.status(500).send({
                    message: "Erro ao buscar id: " + req.params.id
                });
            }
        } else res.send(data);
    });
};