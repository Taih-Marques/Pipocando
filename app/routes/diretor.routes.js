module.exports = app => {
  const controller = require("../diretor.controller.js");

  var router = require("express").Router();

  // cria novo diretor
  router.post("/", controller.criar);

  // buscar diretor por id
  router.get("/:id", controller.buscarPorId);

  app.use('/api/diretores', router);
};