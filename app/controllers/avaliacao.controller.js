const Avaliacao = require("../models/avaliacao.model.js");

// criar and Save a new Tutorial
exports.criar = (req, res) => {
    // Validar requisição
    if (!req.body) {
        res.status(400).send({
            message: "Conteúdo não pode ser vazio!"
        });
    }

    // criar a avaliacao
    const avaliacao = new Avaliacao({
        id_usuario: req.body.id_usuario,
        id_filme: req.body.id_filme,
        assistido: req.body.assistido || false,
        favorito: req.body.favorito || false,
        texto: req.body.texto,
        nota: req.body.nota,
        data_avaliacao: req.body.data_avaliacao
    });

    Avaliacao.criar(avaliacao, (err, avaliacaoCriada) => {
        if (err)
            res.status(500).send({
                message:
                    err.message || "Erro ao criar avaliação."
            });
        else res.send(avaliacaoCriada);
    });
};

exports.buscar = (req, res) => {
    const texto = req.query.texto;

    Avaliacao.getAll(texto, (err, avaliacao) => {
        if (err)
            res.status(500).send({
                message:
                    err.message || "Erro ao buscar avaliação."
            });
        else res.render('pages/lista-filmes', {
            filmes: filmes,
            title: "Filmes"
        });
    });
};

// find all published Tutorials
exports.findAllPublished = (req, res) => {
    Avaliacao.getAllPublished((err, data) => {
        if (err)
            res.status(500).send({
                message:
                    err.message || "Some error occurred while retrieving tutorials."
            });
        else res.send(data);
    });
};

// Find a single Tutorial with a id
exports.buscarPorId = (req, res) => {
    Avaliacao.buscarPorId(req.params.id, (err, data) => {
        if (err) {
            if (err.codigo === 404) {
                res.status(404).send({
                    message: `Não encontrado avaliação com o id:${req.params.id}.`
                });
            } else {
                res.status(500).send({
                    message: "Erro ao buscar avaliação com o id: " + req.params.id
                });
            }
        } else res.send(data);
    });
};

// Update a Tutorial identified by the id in the request
exports.update = (req, res) => {
    // Validate Request
    if (!req.body) {
        res.status(400).send({
            message: "Content can not be empty!"
        });
    }

    console.log(req.body);

    Avaliacao.updateById(
        req.params.id,
        new Avaliacao(req.body),
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.status(404).send({
                        message: `Not found Tutorial with id ${req.params.id}.`
                    });
                } else {
                    res.status(500).send({
                        message: "Error updating Tutorial with id " + req.params.id
                    });
                }
            } else res.send(data);
        }
    );
};

// Delete a Tutorial with the specified id in the request
exports.delete = (req, res) => {
    Avaliacao.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({
                    message: `Not found Tutorial with id ${req.params.id}.`
                });
            } else {
                res.status(500).send({
                    message: "Could not delete Tutorial with id " + req.params.id
                });
            }
        } else res.send({ message: `Tutorial was deleted successfully!` });
    });
};

// Delete all Tutorials from the database.
exports.deleteAll = (req, res) => {
    Avaliacao.removeAll((err, data) => {
        if (err)
            res.status(500).send({
                message:
                    err.message || "Some error occurred while removing all tutorials."
            });
        else res.send({ message: `All Tutorials were deleted successfully!` });
    });
};