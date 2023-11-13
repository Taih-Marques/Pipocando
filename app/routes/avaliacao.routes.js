module.exports = app => {
  const avaliacao = require("../controllers/avaliacao.controller.js");

  var router = require("express").Router();

  // Criar nova avaliacao
  router.post("/", controller.criar);

  // Retrieve all Tutorials
  router.get("/", controller.buscar);

  // Retrieve all published Tutorials
  router.get("/", controller.findAllPublished);

  // Retrieve a single Tutorial with id
  router.get("/:id", controller.findOne);

  // Update a Tutorial with id
  router.put("/:id", controller.update);

  // Delete a Tutorial with id
  router.delete("/:id", controller.delete);

  // Delete all Tutorials
  router.delete("/", controller.deleteAll);

  app.use('/api/controller', router);
};