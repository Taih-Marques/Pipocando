const express = require('express')
const app = express()
require('dotenv').config()
const port = Number(process.env.PORT)

app.set('view engine', 'ejs')

app.use(express.json())

app.get('/', (req, res) => {
    res.redirect('/filmes')
})

require("./routes/filme.routes.js")(app);

app.listen(port, () => {
    console.log(`App listening at port ${port}`)
})