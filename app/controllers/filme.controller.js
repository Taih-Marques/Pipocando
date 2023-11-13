const Filme = require("../models/filme.model.js");
const Avaliacao = require("../models/avaliacao.model.js");

exports.criar = (req, res) => {
    // validar requisição
    if (!req.body) {
        res.status(400).send({
            message: "Conteúdo não pode ser vazio!"
        });
    }

    const filme = new Filme({
        nome: req.body.nome,
        sinopse: req.body.sinopse,
        ano_lancamento: req.body.ano_lancamento,
        id_diretor: req.body.id_diretor,
        banner: req.body.banner
    });

    Filme.criar(filme, (err, filmeCriado) => {
        if (err)
            res.status(500).send({
                message:
                    err.message || "Erro ao criar filme"
            });
        else res.send(filmeCriado);
    });
};

exports.buscar = (req, res) => {
    const texto = req.query.texto;

    Filme.buscar(texto, (err, filmes) => {
        if (err)
            res.status(500).send({
                message:
                    err.message || "Erro ao buscar filmes."
            });
        else res.render('pages/lista-filmes', {
            filmes: filmes,
            title: "Filmes"
        });
    });
};

exports.buscarPaginaFilme = (req, res) => {
    Filme.buscarPorId(req.params.id, (err, filme) => {
        if (err) {
            // mudar res.status para res.render com página de erro
            if (err.codigo === 404) {
                res.status(404).send({
                    message: `Não encontrado filme com o id: ${req.params.id}.`
                });
            } else {
                res.status(500).send({
                    message: "Erro ao buscar filme com o id: " + req.params.id
                });
            }
            return;
        }

        Avaliacao.buscarAvaliacoes(filme.id, (err, avaliacoes) => {
            if (err) {
                res.status(500).send({
                    message: "Erro ao buscar avaliações do filme com o id: " + req.params.id
                });
                return;
            }

            res.render('pages/filme', {
                filme: filme,
                avaliacoes: avaliacoes,
                title: filme.nome
            });
        })
    });

    Filme.buscar
};