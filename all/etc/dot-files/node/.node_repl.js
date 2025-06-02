// ~/.node_repl.js

// Carregar automaticamente alguns módulos úteis
const util = require('util');
const fs = require('fs');
const path = require('path');

// Tornar os módulos acessíveis globalmente no REPL
global.util = util;
global.fs = fs;
global.path = path;

// Função para listar arquivos de forma amigável
global.ls = (dir = '.') => fs.readdirSync(dir);

// Função para inspecionar objetos com profundidade
global.inspect = (obj, depth = 2) => console.log(util.inspect(obj, { colors: true, depth }));

// Mensagem de boas-vindas personalizada
console.log('Bem-vindo ao Node REPL! Módulos fs, path, util carregados.');
console.log('Use `ls()` para listar arquivos e `inspect(obj)` para inspecionar objetos.');

