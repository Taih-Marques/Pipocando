const Diretor = require("../models/diretor.model.js");

exports.criar = (req, res) => {
    // validar requisição
    if (!req.body) {
        res.status(400).send({
            message: "Conteúdo não pode ser vazio"
        });
    }

    const diretor = new Diretor({
        nome: req.body.nome
    });

    Diretor.criar(diretor, (err, data) => {
        if (err)
            res.status(500).send({
                message:
                    err.message || "Erro ao tentar criar diretor."
            });
        else res.send(data);
    });
};

exports.buscarPorId = (req, res) => {
    Diretor.buscarPorId(req.params.id, (err, data) => {
        if (err) {
            if (err.codigo === 404) {
                res.status(404).send({
                    message: `Não encontrado diretor com o id: ${req.params.id}.`
                });
            } else {
                res.status(500).send({
                    message: "Erro ao buscar id: " + req.params.id
                });
            }
        } else res.send(data);
    });
};
