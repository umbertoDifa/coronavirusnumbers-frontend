var express = require('express');
var app = express();
var path = require('path');

console.log(path.join(__dirname,'../build/web'));
app.use('/', express.static(path.join(__dirname,'../build/web')));

app.listen(8080);
