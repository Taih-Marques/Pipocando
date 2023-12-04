# Pipocando

Projeto de Banco de dados 1, com tecnologias de plataforma web full-stack, e no a lado do servidor: ambiente Node.js, framework express, dependências para Ejs e Mysql, para lado cliente: html, css, bootstrap, ejs;

## Executando o projeto

### MySQL

É necessário ter o MySQL em execução. Caso use Docker, você pode executar uma instância MySQL com o comando `docker run --name pipocando-mysql -v PASTA_BANCO:/var/lib/mysql -e MYSQL_DATABASE=pipocando -e MYSQL_ROOT_PASSWORD=123456 -p 3306:3306 -d mysql`, substituindo `PASTA_BANCO` pelo caminho de uma pasta vazia no sistema, que será usada para guardar os dados.

Defina as variáveis de ambiente ou crie um arquivo `.env` na pasta app, conforme exemplo:

```ini
DB_PASSWORD=123456
DB_USER=root
DB_NAME=pipocando
DB_HOST=localhost
PORT=8080
```

Após isso, usando o MySQLWorkbench (ou outro cliente) crie um banco de dados com o nome definido em `DB_NAME`, conecte-se e execute o script `app/resources/init.sql`.

Abra um terminal na pasta do projeto e execute `npm start`.

## Banco de dados

Ao fazer modificações no arquivo `resources/init.sql`, rodar `docker volume rm pipocando_mysql` para limpar o volume.
