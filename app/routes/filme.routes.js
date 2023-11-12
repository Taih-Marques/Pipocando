module.exports = app => {
  const controller = require("../controllers/filme.controller.js");

  var router = require("express").Router();

  // criar novo filme
  router.post("/", controller.criar);

  // buscar filme por id
  router.get("/:id", controller.buscarPorId);

  // buscar por texto
  router.get("/", controller.buscar);

  app.use('/filmes', router);
};