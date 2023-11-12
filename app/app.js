const express = require('express')
const app = express()
require('dotenv').config()
const port = Number(process.env.PORT)

app.set('view engine', 'ejs')

app.use(express.json())

const posts = [
    { title: 'Title 1', body: 'Body 1' },
    { title: 'Title 2', body: 'Body 2' },
    { title: 'Title 3', body: 'Body 3' },
    { title: 'Title 4', body: 'Body 4' },
]
const user = {
    firstName: 'Tim',
    lastName: 'Cook',
    admin: true,
}

app.get('/', (req, res) => {
    res.redirect('/filmes')
})

app.get('/articles', (req, res) => {
    res.render('pages/articles', {
        articles: posts,
        title: "Articles"
    })
})

require("./routes/filme.routes.js")(app);

app.listen(port, () => {
    console.log(`App listening at port ${port}`)
})