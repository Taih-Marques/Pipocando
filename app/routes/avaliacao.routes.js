module.exports = (app) => {
  const controller = require("../controllers/avaliacao.controller.js");

  var router = require("express").Router();

  // Criar nova avaliacao
  router.post("/escrever", controller.salvarTextoAvaliacao);

  app.use("/avaliacao", router);
};
