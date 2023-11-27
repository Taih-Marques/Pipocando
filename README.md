# Pipocando

Projeto de Banco de dados 1, com tecnologias de plataforma web full-stack, e no a lado do servidor: ambiente Node.js, framework express, dependências para Ejs e Mysql, para lado cliente: html, css, bootstrap, ejs;

## Executando o projeto

`npm start` caso já tenha MySQL rodando, caso contrário `docker compose -f "docker-compose.yml" up -d --build`.

## Banco de dados

Ao fazer modificações no arquivo `resources/init.sql`, rodar `docker volume rm pipocando_mysql` para limpar o volume.
