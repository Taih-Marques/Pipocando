const express = require("express");
const app = express();
const path = require("path");
require("dotenv").config();
const port = Number(process.env.PORT);

app.set("view engine", "ejs");
app.use(express.static("./resources"));

app.use(express.json());

app.get("/", (req, res) => {
  res.redirect("/filmes");
});

require("./routes/filme.routes.js")(app);
require("./routes/avaliacao.routes.js")(app);

app.listen(port, () => {
  console.log(`App listening at port ${port}`);
});
