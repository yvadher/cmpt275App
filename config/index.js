var nconf = require('nconf');
var path = require('path');

nconf.argv()
    .env()
    .file({ file: path.join(__dirname, 'config.json') });

var env = nconf.get('NODE_ENV'); // or process.env.NODE_ENV
console.log("env = " + env);
if(!env) env = 'development';

// Load non-prod first since with nconf, first in wins
if (env !== 'production') {  
  console.log("loading from " + path.join(__dirname, env + '.json'));
  nconf.file(env, path.join(__dirname, env + '.json'));
}
// Now load production
nconf.file('production', path.join(__dirname, 'production.json'));  

module.exports = nconf;
