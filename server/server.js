var express = require('express');
var app = express();
var path = require('path');

app.use(express.static('../build/web'));

app.listen(8080);

console.log('listenint');